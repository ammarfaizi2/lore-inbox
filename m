Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVKRTff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVKRTff (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVKRTff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:35:35 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:34517 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750917AbVKRTfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:35:34 -0500
Message-ID: <437E2D2A.2070308@austin.rr.com>
Date: Fri, 18 Nov 2005 13:36:10 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The missing XATTR ifdef is now fixed in cifs-2.6 git tree along with 
some minor fixes related to mounts where sfu mount option specified.

Thanks for pointing this out.

Andy Whitcroft <apw@shadowen.org> wrote on 11/18/2005 05:29:47 AM:

 > Andrew Morton wrote:
 >
 > > - cifs is busted when built as a module.  Mysteriously.
 >
 > Don't know if this is related, but it appears that there is a problem
 > linking it static.  Specifically when you enable CONFIG_CIFS but not
 > CONFIG_CIFS_XATTR.  It seems that get_sfu_uid_mode() uses
 > CIFSSMBQueryEA() which is only available when CIFS_XATTR is defined.
 > Oddly the error seems to be reported against the function which follows:
 >
 >   fs/built-in.o(.text+0x131520): In function `.cifs_get_inode_info':
 >   : undefined reference to `.CIFSSMBQueryEA'
 >   make: *** [.tmp_vmlinux1] Error 1
 >
 > -apw

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWDLPHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWDLPHX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 11:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWDLPHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 11:07:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:42719 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750703AbWDLPHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 11:07:21 -0400
Message-ID: <443D1778.5060803@us.ibm.com>
Date: Wed, 12 Apr 2006 08:06:32 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Special handling of sysfs device resource files?
References: <443C1ECA.1040308@us.ibm.com> <17468.34286.730652.585388@cargo.ozlabs.ibm.com>
In-Reply-To: <17468.34286.730652.585388@cargo.ozlabs.ibm.com>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Mackerras wrote:
> Ian Romanick writes:
> 
>>This seems to mostly work, but I am having one problem.  I map the
>>region by opening the file with O_RDWR, then mmap with
>>(PROT_READ|PROT_WRITE) and MAP_SHARED.  In all cases, the open and mmap
>>succeed.  However, for I/O BARs, the resulting pointer from mmap is
>>invalid.  Any access to it results in a segfault and GDB says it's "out
>>of range".
> 
> On which architecture(s)?

I've only tried on x86-64 (an Athlon64 3000+ to be exact) so far.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEPRd4X1gOwKyEAw8RAhdxAKCX9Y/ju2jK7q5Wdzmb9kfwt9T3lwCbBwrq
BIRJkEIGqSOrXtkDC3/2Fts=
=mePG
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVADBvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVADBvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVADBvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 20:51:08 -0500
Received: from terminus.zytor.com ([209.128.68.124]:43945 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261944AbVADBvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 20:51:02 -0500
Message-ID: <41D9F65E.3030301@zytor.com>
Date: Mon, 03 Jan 2005 17:50:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@samba.org
CC: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
References: <41D9C635.1090703@zytor.com>	<16857.56805.501880.446082@samba.org>	<41D9E3AA.5050903@zytor.com>	<16857.59946.683684.231658@samba.org>	<41D9EDF6.1060600@zytor.com> <16857.62250.259275.305392@samba.org>
In-Reply-To: <16857.62250.259275.305392@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:
> 
> That API would make sense, but I didn't really expect the kernel to
> provide it. What I expected to happen was for Samba4 to use the xattr
> blobs like it does now, hopefully for Wine to learn to interpret those
> same blobs, for backup/restore apps to learn to backup/restore them
> (as blobs, with no interpretation) and for the proposed Samba LSM
> module to do the dirty work of interpreting the contents of these
> blobs in-kernel to provide raceless windows file serving. 
> 

Right, but here we're talking about exposing the guts of a DOS-based 
filesystem so they can be manipulated by an application which isn't 
necessarily a bulk file handler.  The API doesn't really work for that, 
especially since some of the attributes have different access properties 
from the others.

	-hpa

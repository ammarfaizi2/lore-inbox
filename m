Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbUBXPj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbUBXPj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:39:56 -0500
Received: from hera.kernel.org ([63.209.29.2]:44166 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262275AbUBXPjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:39:54 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: BOOT_CS
Date: Tue, 24 Feb 2004 15:39:51 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1fr87$r2a$1@terminus.zytor.com>
References: <20040224100530.68794.qmail@web11805.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077637191 27723 63.209.29.3 (24 Feb 2004 15:39:51 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 24 Feb 2004 15:39:51 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040224100530.68794.qmail@web11805.mail.yahoo.com>
By author:    =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
In newsgroup: linux.dev.kernel
> 
>   The other problem is for the people who want to check the validity
>  of the RAM disk before starting Linux - for instance by checking
>  the CRC32 of the decompressed RAM disk - and stop the boot process
>  before it is too late - i.e. in the bootloader when you can select
>  another kernel version / initrd to load.
>   You cannot place the decompressed initrd at a maximum address before
>  knowing its decompressed size - the address to place it is the max
>  address (or the end of free RAM) minus ramdisk size if I remember
>  correctly. That is working for so long loading the decompressed
>  initrd after few Mb after the last kernel byte (so that the kernel
>  will move it where it wants - no need to move it twice) that I do
>  not remember the details. Did you changed this part?
> 

If you absolutely want to do this -- for pretty much no reason -- you
can either decompress it twice, decompress it to nowhere (after all,
the kernel will decompress it when it starts) or move it into place
before starting the kernel.

	-hpa

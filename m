Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbQJ3MmE>; Mon, 30 Oct 2000 07:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQJ3Mly>; Mon, 30 Oct 2000 07:41:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31040 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129054AbQJ3Mlf>; Mon, 30 Oct 2000 07:41:35 -0500
Subject: Re: / on ramfs, possible?
To: aer-list@mailandnews.com (Anders Eriksson)
Date: Mon, 30 Oct 2000 12:42:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200010300727.IAA12250@hell.wii.ericsson.net> from "Anders Eriksson" at Oct 30, 2000 08:27:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qEHB-0006po-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want my / to be a ramfs filesystem. I intend to populate it from an 
> initrd image, and then remount / as the ramfs filesystem. Is that at 
> all possible? The way I see it the kernel requires / on a device 
> (major,minor) or nfs.
> 
> Am I out of luck using ramfs as /? If it's easy to fix, how do I fix it?

Firstly make sure you get the patches that make ramfs work if they arent all
yet applied, then build your initrd that populates it on boot. Now you can
make use of the pivot_root() syscall (you may need to generate your own 
syscall wrapper for that one as its very new). That lets you flip your root
and initrd around

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

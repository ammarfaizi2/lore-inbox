Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276339AbRJHPLO>; Mon, 8 Oct 2001 11:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276919AbRJHPLF>; Mon, 8 Oct 2001 11:11:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43277 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276339AbRJHPKx>; Mon, 8 Oct 2001 11:10:53 -0400
Subject: Re: Problem creating filesystems (and othe operations) under 2.4.10
To: quintaq@yahoo.co.uk
Date: Mon, 8 Oct 2001 16:16:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011008145018Z276906-760+22140@vger.kernel.org> from "quintaq@yahoo.co.uk" at Oct 08, 2001 03:50:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qc99-0000qB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have just installed a Maxtor 30GB drive as /dev/hdc in my SuSE 7.0 system
> which has a vanilla 2.4.10 kernel.  I found that I could write the
> partition table and create a small ext2 partition for /boot plus 768MB of
> swap.  Creation of the main ext2 filesystem on /hdc7 failed (before the
> inode tables even began to be written), with "file size limit exceeded".
> The same problem recurred every time I tried - and I did try various
> combinations of partition size.  I see the same error message when trying
> to change partition table flags.  The problem is identical using fdisk,
> cfdisk and parted.  I have no file limits set in ulimit and I do not think
> that this is the problem. 
> 
> I eventually put the same drive as /dev/hdc in another box running a stock
> SuSE 2.2.16 kernel and creation of the filesystems completed without any
> problem.  I have also verified this by booting this box using SuSE's 2.2.16
> rescue kernel.
> 
> Any ideas?

Obvious one to check would be to see if when 2.4.10 acquired the page cache 
changes someone backed out the device picks up underlying file size limit bug 
fix that the -ac tree has and went to Linus.

It really sounds like that happened.

Alan


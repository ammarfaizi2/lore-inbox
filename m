Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286192AbRLJIYq>; Mon, 10 Dec 2001 03:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286193AbRLJIYh>; Mon, 10 Dec 2001 03:24:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10758 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286192AbRLJIY1>; Mon, 10 Dec 2001 03:24:27 -0500
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 10 Dec 2001 08:32:57 +0000 (GMT)
Cc: phillips@bonn-fries.net (Daniel Phillips),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112092220400.13692-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 09, 2001 10:27:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DLrt-0001Ct-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Continuing the little warts list, there's Alan's comment re needing endian
> > reversal on big endian machines.
> 
> Now that's a load of bollocks.

Inodes are in native format with lots of unpacked additional info so we
can't just point into the inode.  We can certainly do things like writeback
all the inodes in a block when the block has to go for queueing to disk.

Indirect blocks are a totally unrelated item to the discussion I was having
at least.

Alan

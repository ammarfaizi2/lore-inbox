Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRAFPe1>; Sat, 6 Jan 2001 10:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRAFPeQ>; Sat, 6 Jan 2001 10:34:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7691 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129868AbRAFPeK>; Sat, 6 Jan 2001 10:34:10 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: viro@math.psu.edu (Alexander Viro)
Date: Sat, 6 Jan 2001 15:35:32 +0000 (GMT)
Cc: stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0101060015540.25336-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 06, 2001 12:18:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EvNX-0001Ac-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Add UnlockPage(page) at the end of ramfs_writepage().
> > Shit. You are quite fast. Works.
> 
> 	Sure, especially considering the fact that patch was sent to
> Linus about a month ago (several times, actually)... ;-/

Its in all the -ac trees 8)

BTW Al: We have another general vfs/fs problem to handle - which is exceeding
max file sizes on limited file systems. Pretty much nobody is getting it
right. Ext2 can be tricked to go past the limit, sys5 1k sits there emitting
printk messages etc.

Any objections to me putting max file size for an fs (in pages) into the
superblock ? An fs can still implement weird rules by putting large values
in that and doing its own checks.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

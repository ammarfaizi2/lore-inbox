Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130550AbQLZPxn>; Tue, 26 Dec 2000 10:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131389AbQLZPxe>; Tue, 26 Dec 2000 10:53:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18699 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130805AbQLZPxZ>; Tue, 26 Dec 2000 10:53:25 -0500
Subject: Re: innd mmap bug in 2.4.0-test12
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 25 Dec 2000 20:45:41 -0500 (EST)
Cc: md@Linux.IT (Marco d'Itri), viro@math.psu.edu (Alexander Viro),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10012250131370.5340-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 25, 2000 01:42:33 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ag3n-0000Me-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The simple fix is along the lines of adding code to fsync() that walks the
> inode page list and writes out dirty pages.
> 
> The clever and clean fix is to split the inode page list into two lists,
> one for dirty and one for clean pages, and only walk the dirty list.

Like the patches that were floating around on the list for the past 
few months to make O_SYNC work. Could those be used for it ?

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

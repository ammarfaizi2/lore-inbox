Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136507AbREDVKU>; Fri, 4 May 2001 17:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136508AbREDVKK>; Fri, 4 May 2001 17:10:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49423 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136507AbREDVJ5>; Fri, 4 May 2001 17:09:57 -0400
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 4 May 2001 22:11:21 +0100 (BST)
Cc: R.E.Wolff@BitWizard.nl (Rogier Wolff), alan@lxorguk.ukuu.org.uk (Alan Cox),
        volodya@mindspring.com, viro@math.psu.edu (Alexander Viro),
        andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105041015520.521-100000@penguin.transmeta.com> from "Linus Torvalds" at May 04, 2001 10:28:10 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vmrD-00082F-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, if you want to speed up accesses, there are things you can do. You
> can lay out the filesystem in the access order - trace the IO accesses at
> bootup ("which file, which offset, which metadata block?") and lay out the
> blocks of the files in exactly the right order. Then you will get linear
> reads _without_ doing any "dd" at all.

iso9660 alas doesn't allow you to do that. You can speed it up by reading
the entire file into memory rather than paging it in (or reading it in and
then executing it). iso9660 layout is pretty constrained and designed for
linear file reads


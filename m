Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261516AbREOVDJ>; Tue, 15 May 2001 17:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbREOVCu>; Tue, 15 May 2001 17:02:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20740 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261514AbREOVCb>; Tue, 15 May 2001 17:02:31 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 15 May 2001 21:58:46 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <Pine.LNX.4.21.0105150803230.1802-100000@penguin.transmeta.com> from "Linus Torvalds" at May 15, 2001 08:10:29 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zlu2-00032X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	else
> > 		error
> 
> Ugh. You do this?

Lots of apps do it - hdparm, mt-st, lilo

> The fix, I think, is to make the ioctl commands much more regular. That is
> probably true in general, and fixing that would hopefully fix the need for
> horrible code like the above.

Definitely.  Some of it would remain but it becomes

		if(ioctl(foo)==-EOPNOTSUPP)
			bang_it_nby_hand()


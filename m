Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265766AbRF1Nhy>; Thu, 28 Jun 2001 09:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265796AbRF1Nhe>; Thu, 28 Jun 2001 09:37:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32012 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265766AbRF1Nhc>; Thu, 28 Jun 2001 09:37:32 -0400
Subject: Re: VM Requirement Document - v0.0
To: tori@unhappy.mine.nu (Tobias Ringstrom)
Date: Thu, 28 Jun 2001 14:37:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mike_phillips@urscorp.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106281523390.1258-100000@boris.prodako.se> from "Tobias Ringstrom" at Jun 28, 2001 03:33:57 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Fbyy-0006xF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That isnt really down to labelling pages, what you are talking qbout is what
> > you get for free when page aging works right (eg 2.0.39) but don't get in
> > 2.2 - and don't yet (although its coming) quite get right in 2.4.6pre.
> 
> Correct, but all pages are not equal.

That is the whole point of page aging done right. The use of a page dictates
how it is aged before being discarded. So pages referenced once are aged
rapidly, but once they get touched a couple of times then you know they arent
streaming I/O. There are other related techniques like punishing pages that
are touched when streaming I/O is done to pages further down the same file -
FreeBSD does this one for example

> The problem with updatedb is that it pushes all applications to the swap,
> and when you get back in the morning, everything has to be paged back from
> swap just because the (stupid) OS is prepared for yet another updatedb
> run.

Updatedb is a bit odd in that it mostly sucks in metadata and the buffer to
page cache balancing is a bit suspect IMHO.

Alan


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbRF1OuI>; Thu, 28 Jun 2001 10:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265977AbRF1Ot6>; Thu, 28 Jun 2001 10:49:58 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:1549 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265976AbRF1Otm>; Thu, 28 Jun 2001 10:49:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        tori@unhappy.mine.nu (Tobias Ringstrom)
Subject: Re: VM Requirement Document - v0.0
Date: Thu, 28 Jun 2001 16:52:56 +0200
X-Mailer: KMail [version 1.2]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mike_phillips@urscorp.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <E15Fbyy-0006xF-00@the-village.bc.nu>
In-Reply-To: <E15Fbyy-0006xF-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01062816525604.00419@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 June 2001 15:37, Alan Cox wrote:
> > The problem with updatedb is that it pushes all applications to the swap,
> > and when you get back in the morning, everything has to be paged back
> > from swap just because the (stupid) OS is prepared for yet another
> > updatedb run.
>
> Updatedb is a bit odd in that it mostly sucks in metadata and the buffer to
> page cache balancing is a bit suspect IMHO.

For Ext2, most or all of that metadata will be moved into the page cache 
early in 2.5, and other filesystem will likely follow that lead.  That's not 
to say the buffer/page cache balancing shouldn't get attention, just that 
this particular problem will die by itself.

--
Daniel

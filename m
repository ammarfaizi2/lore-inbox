Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285268AbRLFWrN>; Thu, 6 Dec 2001 17:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285275AbRLFWrH>; Thu, 6 Dec 2001 17:47:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3347 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285272AbRLFWqx>; Thu, 6 Dec 2001 17:46:53 -0500
Subject: Re: SMP/cc Cluster description
To: lm@bitmover.com (Larry McVoy)
Date: Thu, 6 Dec 2001 22:54:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), lm@bitmover.com (Larry McVoy),
        davem@redhat.com (David S. Miller), phillips@bonn-fries.net,
        davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        hps@intermeta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20011206143516.P27589@work.bitmover.com> from "Larry McVoy" at Dec 06, 2001 02:35:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C7P1-0003Ou-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Most of my block drivers in Linux have one lock. The block queuing layer
> > has one lock which is often the same lock.
> 
> Hooray!  That's great and that's the way I'd like to keep it.  Do you think
> you can do that on a 64 way SMP?  Not much chance, right?

It wouldn't be a big problem to keep it that way on the well designed
hardware. The badly designed stuff (here Im thinking the NCR5380 I debugged
today since its fresh in my mind) I'd probably want 2 locks, one for queue
locking, one for request management.

> > Which is easier. Managing 64 routers or managing 1 router ?
> That's a red herring, there are not 64 routers in either picture, there
> are 64 ethernet interfaces in both pictures.  So let me rephrase the
> question: given 64 ethernets, 64 CPUs, on one machine, what's easier,
> 1 multithreaded networking stack or 64 independent networking stacks?

I think you miss the point. If I have to program the system as 64
independant stacks from the app level I'm going to go slowly mad


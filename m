Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAICDl>; Mon, 8 Jan 2001 21:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbRAICDc>; Mon, 8 Jan 2001 21:03:32 -0500
Received: from inje.iskon.hr ([213.191.128.16]:27145 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S129927AbRAICDU>;
	Mon, 8 Jan 2001 21:03:20 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.10.10101080951140.3750-100000@penguin.transmeta.com>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 09 Jan 2001 00:41:14 +0100
In-Reply-To: Linus Torvalds's message of "Mon, 8 Jan 2001 09:58:15 -0800 (PST)"
Message-ID: <87n1d1mx2d.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Mon, 8 Jan 2001, Rik van Riel wrote:
> 
> > On Sun, 7 Jan 2001, Wayne Whitney wrote:
> > 
> > > Well, here is a workload that performs worse on 2.4.0 than on 2.2.19pre,
> > 
> > > The typical machine is a dual Intel box with 512MB RAM and 512MB swap.
> > 
> > How does 2.4 perform when you add an extra GB of swap ?
> > 
> > 2.4 keeps dirty pages in the swap cache, so you will need
> > more swap to run the same programs...
> > 
> > Linus: is this something we want to keep or should we give
> > the user the option to run in a mode where swap space is
> > freed when we swap in something non-shared ?
> 
> I'd prefer just documenting it and keeping it. I'd hate to have two fairly
> different modes of behaviour. It's always been the suggested "twice the
> amount of RAM", although there's historically been the "Linux doesn't
> really need that much" that we just killed with 2.4.x.
> 
> If you have 512MB or RAM, you can probably afford another 40GB or so of
> harddisk. They are disgustingly cheap these days.
> 

Yes, but a lot more data on the swap also means degraded performance,
because the disk head has to seek around in the much bigger area. Are
you sure this is all OK?
-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

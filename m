Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263955AbRFDIWN>; Mon, 4 Jun 2001 04:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264132AbRFDIVy>; Mon, 4 Jun 2001 04:21:54 -0400
Received: from inje.iskon.hr ([213.191.128.16]:8359 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S263955AbRFDIVw>;
	Mon, 4 Jun 2001 04:21:52 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove nr_async_pages limit
In-Reply-To: <E156o18-00059a-00@the-village.bc.nu>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 04 Jun 2001 10:21:32 +0200
In-Reply-To: <E156o18-00059a-00@the-village.bc.nu> (Alan Cox's message of "Mon, 4 Jun 2001 07:39:10 +0100 (BST)")
Message-ID: <87iticfyer.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > This patch removes the limit on the number of async pages in the
> > flight.
> 
> I have this in all  2.4.5-ac. It does help a little but there are some other
> bits you have to deal with too, in paticular wrong aging. See the -ac version
> 

Yes, I'll check -ac to see your changes. Although, I can't see what is
the impact of the unlimited number of the async pages on the aging, I
don't see a connection?!

In the mean time I tested the patch even more thoroughly under various
loads and I can't find any problem with it. Performance is same or
better a little bit, as you say. :)

My other patch (enlarging inactive dirty list) has a much bigger
impact on the aging process, but I also see only improvement with
it. I think that swap_out path should be tweaked a little bit (it is
too aggressive now), and then things will come up even better.

Regards,
-- 
Zlatko

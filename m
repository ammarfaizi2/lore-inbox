Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbRAIM31>; Tue, 9 Jan 2001 07:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130138AbRAIM3R>; Tue, 9 Jan 2001 07:29:17 -0500
Received: from magla.iskon.hr ([213.191.128.32]:33797 "EHLO magla.iskon.hr")
	by vger.kernel.org with ESMTP id <S130105AbRAIM3H>;
	Tue, 9 Jan 2001 07:29:07 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.10.10101082322030.1222-100000@penguin.transmeta.com>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 09 Jan 2001 13:29:00 +0100
In-Reply-To: Linus Torvalds's message of "Mon, 8 Jan 2001 23:27:15 -0800 (PST)"
Message-ID: <dnbstgewoj.fsf@magla.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Notus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 8 Jan 2001, Eric W. Biederman wrote:
> 
> > Zlatko Calusic <zlatko@iskon.hr> writes:> 
> > > 
> > > Yes, but a lot more data on the swap also means degraded performance,
> > > because the disk head has to seek around in the much bigger area. Are
> > > you sure this is all OK?
> > 
> > I don't think we have more data on the swap, just more data has an
> > allocated home on the swap.
> 
> I think Zlatko's point is that because of the extra allocations, we will
> have worse locality (more seeks etc).

Yes that was my concern.

But in the end I'm not sure. I made two simple tests and haven't found
any problems with 2.4.0 mm logic (opposed to 2.2.17). In fact, the new
kernel was faster in the more interesting (make -j32) test.

Also I have found that new kernel allocates 4 times more swap space
under some circumstances. That may or may not be alarming, it remains
to be seen.

-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

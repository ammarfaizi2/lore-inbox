Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267609AbTALWoa>; Sun, 12 Jan 2003 17:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbTALWo3>; Sun, 12 Jan 2003 17:44:29 -0500
Received: from zork.zork.net ([66.92.188.166]:15336 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S267609AbTALWo0>;
	Sun, 12 Jan 2003 17:44:26 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: HEINOUS SELF-AGGRANDIZATION,
 PROMOTION OF SELF
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 12 Jan 2003 22:53:15 +0000
In-Reply-To: <1042410897.1209.165.camel@RobsPC.RobertWilkens.com> (Rob
 Wilkens's message of "Sun, 12 Jan 2003 17:34:58 -0500")
Message-ID: <6u7kdax9no.fsf@zork.zork.net>
User-Agent: Gnus/5.090011 (Oort Gnus v0.11) Emacs/21.2
 (i386-debian-linux-gnu)
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
	<1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
	<20030112211530.GP27709@mea-ext.zmailer.org>
	<1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
	<Pine.LNX.4.50L.0301121939170.26759-100000@imladris.surriel.com>
	<1042407845.3162.131.camel@RobsPC.RobertWilkens.com>
	<20030112214937.GM31238@vitelus.com>
	<1042409239.3162.136.camel@RobsPC.RobertWilkens.com>
	<20030112221802.GN31238@vitelus.com>
	<1042410897.1209.165.camel@RobsPC.RobertWilkens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Rob Wilkens quotation:

> On Sun, 2003-01-12 at 17:18, Aaron Lehmann wrote:
>> These are usually error conditions. If you inline them, you will have
>> to jump *over* them as part of the normal code path. You don't save
>
> You're wrong.  You wouldn't have to jump over them any more than you
> have to jump over the "goto" statement.  They would be where the goto
> statement is.  Instead of the goto you would have the function.

He said the *normal* path.  Jumping to error code is rarely a normal
path.  By replacing the gotos with inlined functions, you turn the
fast path into a bunch of jumps over duplicated error code, and the
error path into a straight line.

>> any instructions, and you end up with a kernel which has much more
>> duplicated code and thus thrashes the cache more. It also makes the
>
> If that argument was taken to it's logical conclusion (and I did, in my
> mind just now), no one should add any code the grows the kernel at all.

The interesting thing about taking arguments to their logical
conclusion is that it rarely makes any sense to do so.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |

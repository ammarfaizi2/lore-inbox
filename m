Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbSJUNGd>; Mon, 21 Oct 2002 09:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSJUNFt>; Mon, 21 Oct 2002 09:05:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:899 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261370AbSJUNFm>; Mon, 21 Oct 2002 09:05:42 -0400
Date: Mon, 21 Oct 2002 09:13:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jdow <jdow@earthlink.net>
cc: Robert Love <rml@tech9.net>, Neil Conway <nconway.list@ukaea.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4: variable HZ
In-Reply-To: <005601c2773d$b6fc65a0$6f1ee043@wizardess.wiz>
Message-ID: <Pine.LNX.3.95.1021021085003.10164A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, jdow wrote:

> Richard, would you believe that this is essentially what is done with the
> GPS satellites in the dither process and in the clock correction process
> to make the drifty Rb standards as stable as ground standards?
> 
> (You'd better. I designed the beastie involved.)
> {^_-}    Joanne, jdow@earthlink.net

Sure. I helped develop a Kalman Filter that would run in real-time.
It was first implemented in Matlab (which is awful to interpret).
I rewrote it in ix86 assembly, using synthetic division (where you
save the remainder and use it in a subsequent division for the same
element in the polynomial). The result being that the filter generates
no error even though it performs multiple divisions of non-integral
numbers.

These techniques are great for continuous functions. Early filtering
techniques, using classical methods (average, r.m.s, r.s.s, etc.)
develop a bias because of round-off. The synthetic division bounds
the bias to one less than the last divisor.

If you filter enough stuff, over a long enough time, you can make
gold out of shit. The onboard GPS software has a very long time
to tune. Its a good candidate. In principle, the ground standard
doesn't have to be very good as long as it averages correctly
with low residual bias.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275823AbRJNRfV>; Sun, 14 Oct 2001 13:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276607AbRJNRfL>; Sun, 14 Oct 2001 13:35:11 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:31495 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S275823AbRJNRe6>;
	Sun, 14 Oct 2001 13:34:58 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110141735.VAA06277@ms2.inr.ac.ru>
Subject: Re: TCP acking too fast
To: Mika.Liljeberg@welho.com (Mika Liljeberg)
Date: Sun, 14 Oct 2001 21:35:04 +0400 (MSK DST)
Cc: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BC9CAA9.7378075B@welho.com> from "Mika Liljeberg" at Oct 14, 1 08:26:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Well, you should read the preceding messages to understand how we got
> here.

I am reading now and until now I did not find why problem of calculating
rcv_mss raised at all. :-)

You nicely understood the reason of the problem and
it is surely not related to rcv_mss in any way.  :-)


> When you say "reliably", you should recognize the underlying assumptions
> as well.

The assumptions are so conservative, that it is not worth to tell about them.

Heuristics does not predict fall of rcv_mss below 536 when sender
sets PSH on each frame. And it is pretty evident that such prediction
is impossible theoretically in this sad case. All that we can do is
to cry and to hold rcv_mss at 536 and to ack each 4th segment on
with mtu of 256.

Alexey

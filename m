Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314019AbSDQBxV>; Tue, 16 Apr 2002 21:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314022AbSDQBxU>; Tue, 16 Apr 2002 21:53:20 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:5843 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S314019AbSDQBxT>; Tue, 16 Apr 2002 21:53:19 -0400
Subject: Re: Why HZ on i386 is 100 ?
From: Dan Mann <mainlylinux@attbi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1019005044.1670.16.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1019094667.1435.20.camel@hermes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.3 
Date: 17 Apr 2002 21:51:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not just try and modify the time slice scale?  wouldn't this then
help with what you are trying to gain, while leaving other values alone
that rely on 100HZ?

Doesn't an unmodified TICK_SCALE negate most of the lowered time slice
effect you'd gain from raising HZ anyway?

Seems like Ingo did a bunch of work on trying to get the "sweet spot"
time slice quanta value already, and I don't think he did it with the HZ
value, but I could be wrong. 

And if it is Xwindows performance you are trying for, it's not the
kernel (flying by the seat of my pants here).  I can have crappy X
performance and yet my audio never skips a beat, running at exactly the
same priority as X(though my X perf problems seem to stem from multiple
clients rendering on screen at the same time.;-)(No disrespect to the X
developers, since it does a lot of thing very nicely :-)

Dan

On Tue, 2002-04-16 at 20:57, Robert Love wrote:
> On Tue, 2002-04-16 at 20:49, David Mosberger wrote:
> 
> > But since it's popular, I did measure it quickly on a relatively
> > slow (old) Itanium box: with 100Hz, the kernel compile was about
> > 0.6% faster than with 1024Hz (2.4.18 UP kernel).
> 
> One question I have always had is why 1024 and not 1000 ?

> Because that is what Alpha does?  It seems to me there is no reason for
> a power-of-two timer value, and using 1024 vs 1000 just makes the math
> and rounding more difficult.
> 
> 	Robert Love
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266097AbUFWGkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUFWGkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 02:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUFWGkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 02:40:43 -0400
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:39380 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266097AbUFWGki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 02:40:38 -0400
Date: Wed, 23 Jun 2004 16:40:27 +1000 (EST)
From: Con Kolivas <kernel@kolivas.org>
To: Diffie <diffie@gmail.com>
cc: Panagiotis Papadakos <papadako@csd.uoc.gr>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase 7.1 for 2.6.7-mm1
In-Reply-To: <9dda3492040622232337451cbb@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0406231634420.5606@kolivas.org>
References: <9dda34920406222056500f67d3@mail.gmail.com>
 <1087957407.40d8e99fb1398@vds.kolivas.org> <9dda3492040622232337451cbb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, Diffie wrote:

> Thanks for pointing this out. I have just patched from s7.1 to s7.3
> and did notice much better responses under the game...yet music still
> skips when moving the mouse very very fast.

Great. The non-interactive mode may well be better suited to gaming as 
well (I use it when playing neverwinternights):
echo 0 > /proc/sys/kernel/interactive

I am still at the "ironing bugs" stage with this scheduler, and hope that 
this corrects any further problems, and may make things behave even better 
with interactive mode on (as the last few bugfixes have done).

> Also when playing bmp or xmms and trying to turn on caps lock on USB
> kbd there's this pause of a second...but that could be related to the
> keyboard itself. I thought i would mention this though.

Maybe, but anything is possible given the magnitude of change to the 
behaviour of all tasks.

Thanks for feedback!
Cheers,
Con

> On Wed, 23 Jun 2004 12:23:27 +1000, kernel@kolivas.org
> <kernel@kolivas.org> wrote:
> > 
> > Quoting Diffie <diffie@gmail.com>:
> > 
> > > I have tried this staircase patch on 2.6.7-mm1 kernel under NForce2
> > > based system and when playing games the sound stops and skips every
> > > second and moving mouse at the same time makes the response very
> > > slow.The game is Unreal engine based.
> > 
> > Most hardware got better for this problem with s7.1. There is a new release that
> > addressed a few bugs only just announced on lkml (staircase 7.3) which seemed
> > to fix this problem on machines tested so far. This should address these
> > issues.
> > 
> > Note that at very high loads mainline will be more responsive, but it does this
> > to the detriment of fairness which I decided was not worth pursuing in
> > staircase. The machine should will be usable at these very high loads - which
> > is important when a box goes out of control - but it will not be as smooth as
> > mainline.

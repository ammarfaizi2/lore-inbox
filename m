Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317180AbSFQXcx>; Mon, 17 Jun 2002 19:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSFQXcw>; Mon, 17 Jun 2002 19:32:52 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:5925 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S317180AbSFQXcv>; Mon, 17 Jun 2002 19:32:51 -0400
Date: Tue, 18 Jun 2002 01:30:31 +0200 (CEST)
From: Rui Sousa <rui.sousa@laposte.net>
X-X-Sender: rsousa@localhost.localdomain
To: "Justin S. Peavey" <jpeavey+kernel@peaveynet.com>
cc: linux-kernel@vger.kernel.org,
       emu10k1-devel <emu10k1-devel@lists.sourceforge.net>
Subject: Re: Oops from EMU10K1 (2.4.18 and CVS version)
In-Reply-To: <20020616201656.GE15266@colltech.com>
Message-ID: <Pine.LNX.4.44.0206180120580.2633-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jun 2002, Justin S. Peavey wrote:

> Noticed using maseq (MainActor) application, all attempts to use audio
> caused the application to crash when opening the /dev/dsp device and
> generated an oops (see oops1).  Based on the oops error generated
> (kernel BUG at audio.c:1474!) and a posting from Rui ("Re: Oops in
> emu10k1 driver", 01 Apr 2002), I upgraded to the latest CVS version of
> emu10k1.

This one was fixed in kernel 2.4.19-pre8.

> 
> After CVS upgrade, the application now plays about a half-second of
> audio then crashes again with a different Oops message (see oops2).
> Strace shows the application now crashing while writing to the sound
> device.  Just to be experimental, I applied the 2.4 patch sitting in
> the docs area of the CVS tree, recompiled, installed and re-tested -
> same problem (see oops3).
> 
> Any suggestions on where to go next with this?

Can you try and install 2.4.19-pre10 with the included emu10k1?
I suspect you are just hitting a driver miscompilation problem when
compiling the module outside the kernel tree (somehow not using the 
correct compile options...) since the crash is inside 
interrupt_sleep_on().

Rui Sousa


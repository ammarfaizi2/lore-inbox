Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270490AbTHLPVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270499AbTHLPVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:21:38 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:43493
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S270490AbTHLPVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:21:36 -0400
Date: Tue, 12 Aug 2003 17:23:58 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: WINE + Galciv + 2.6.0-test3-mm1-O15
Message-Id: <20030812172358.5afe0cc1.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-08-12 14:42:02 gaxt wrote:

[...]
> Galciv plays videos quite smoothly but as soon as I run it it will
> freeze the cursor for 12-15 seconds every half-minute or so even
> within the game itself which is turn-based strategy without a lot of
> whizbang stuff. In the past, the videos would stutter but the game
> would not suffer from more than short pauses now and then.

Similar experience here running the game-test (xfree86 4.3.99.10, winex
3.1 and "Baldurs Gate I") on a PII 400 with 128 meg ram. Using
2.6.0-test3-O14.1int + O14.1-O15int.

I would say this is the best _and_ worst scheduler I've tried since Con
had to adopt his work to the new Ingo infrastructure. Slightly
smoother than pure A3 unless you manage to trigger badness. Then you (or
I, at least) get exactly 15 seconds of total freezes, mixed with
different periods of normality. And by freezes, I mean total freezes.

I can switch to an already opened text console, but there
a running "top" is dead and it won't take any keystrokes until the
freeze has gone. The only thing not dead is the "sound repeats" that
Daniel Phillips explained in:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105966612027670&w=2

--quote--
To convince yourself of this, note that when DMA refill fails to meet
its deadline you will hear repeats, not skipping, because the DMA
hardware on the sound card has been set up to automatically restart the
DMA each time the buffer expires.  Try running the kernel under kgdb and
breaking to the monitor while sound is playing.
--unquote--

Mvh
Mats Johannesson

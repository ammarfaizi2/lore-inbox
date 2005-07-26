Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVG0AKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVG0AKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVGZXuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:50:01 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:14863 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262354AbVGZXtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:49:15 -0400
Date: Wed, 27 Jul 2005 01:36:47 +0200
From: Willy Tarreau <willy@w.ods.org>
To: johsc@arcor.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 panics on boot on 486 box: TSC requires pentium
Message-ID: <20050726233647.GU8907@alpha.home.local>
References: <20050726182258.GA1719@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726182258.GA1719@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 08:22:58PM +0200, johsc@arcor.de wrote:
> 2.4.31 compiled with -m486, panics on boot (486DX) and says something about
> TSC requires pentium, bang.

The processor type is wrong, you're on at least a pentium instead of a 486.
If you changed the config by hand (vi .config), you must do "make oldconfig"
after, to propagate values along the options.

> enabling the obscure flag
> 
>  [*] Unsynced TSC support
>
> seems to fix this - the corresponding .config label name is actually *more*
> helpful than the documentation.

Seems to me that it simply disables use of TSC. But if you see this option,
it means that your kernel has been compiled with SMP enabled, which is not
possible on 486 (I may be wrong here). Most probably, you took a config from
an inadequate kernel for your machine.

> - Obscure-sound-bug
> jazz16 on Travelmate 4000M doesn't seem to work either, sb.o 
> complains about DSP version being "only" 3.01.
> 
> (#insmod sb type=10 io=0x220 irq={5,7} dma=1 dma16=7)
> 
> there is sound but mpg123 says 44100 is impossible.

mpg123 requires at least around 486 DX4-100 to play mp3 at 44100, so
perhaps it fails a self-test and complains because of that ?

Willy


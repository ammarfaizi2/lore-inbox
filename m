Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266122AbUAGCef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 21:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUAGCef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 21:34:35 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:38665 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266122AbUAGCed convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 21:34:33 -0500
Date: Wed, 7 Jan 2004 03:34:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Wim Van Sebroeck <wim@iguana.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: Just a thought: Kconfig & architecture command
In-Reply-To: <20040103155150.N30061@infomag.infomag.iguana.be>
Message-ID: <Pine.LNX.4.58.0401061651280.2255@spit.local>
References: <20040103155150.N30061@infomag.infomag.iguana.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 3 Jan 2004, Wim Van Sebroeck wrote:

> Lett me give a simple example: the sa1100 watchdog driver only works for
> the sa1100 architecture. In Kconfig this could then look like:
> -Kconfig------------------------------------------------------------------
> config SA1100_WATCHDOG
>         tristate "SA1100 watchdog"
>         architecture ARCH_SA1100
>         depends on WATCHDOG
>         help
>           Watchdog timer embedded into SA11x0 chips. This will reboot your
>           system when timeout is reached.
>           NOTE, that once enabled, this timer cannot be disabled.
>
>           To compile this driver as a module, choose M here: the
>           module will be called sa1100_wdt.
>
> --------------------------------------------------------------------------
> Â
> The advantage is that you could source driver directory's more easily in
> a lott of architectures (without having to copy general pieces in every
> seperate architecture-dependant Kconfig file, like we do know for sun,
> sh, ...).

I don't really see the need for another keyword, which is basically only
an alias. The ARCH_ prefix already says that it's an arch symbol and you
can already have multiple depends lines (which are connected via '&&'), so
you don't need to mix the arch dependecies with the other dependencies.

bye, Roman

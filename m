Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUHDNhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUHDNhX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUHDNhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:37:23 -0400
Received: from witte.sonytel.be ([80.88.33.193]:3016 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265487AbUHDNhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:37:20 -0400
Date: Wed, 4 Aug 2004 15:37:18 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Juergen Stuber <juergen@jstuber.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc3
In-Reply-To: <86r7qn9ip5.fsf@jstuber.net>
Message-ID: <Pine.GSO.4.58.0408041536360.15861@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org>
 <86r7qn9ip5.fsf@jstuber.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Juergen Stuber wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> >[...]
> >   o depends on PCI DMA API: Cisco/Aironet 34X/35X/4500/4800
>
> I guess it is this change that made the Airo driver disappear for me,
> because I didn't have ISA configured:
>
> --- linux-2.6.8-rc2/drivers/net/wireless/Kconfig        2004-07-18 06:57:48.000000000 +0200
> +++ linux-2.6.8-rc3/drivers/net/wireless/Kconfig        2004-08-03 23:27:14.000000000 +0200
> @@ -139,7 +139,7 @@
>
>  config AIRO
>         tristate "Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards"
> -       depends on NET_RADIO && (ISA || PCI)
> +       depends on NET_RADIO && ISA && (PCI || BROKEN)
>         ---help---
>           This is the standard Linux driver to support Cisco/Aironet ISA and
>           PCI 802.11 wireless cards.
>
>
> If I understand it correctly the logic is faulty and should better be
>
>        depends on NET_RADIO && ((ISA && BROKEN) || PCI)

Sorry, my fault. Yep, that sounds better.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbTDOJkg (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 05:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264422AbTDOJkg (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 05:40:36 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:49350 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S264419AbTDOJkf (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 05:40:35 -0400
Date: Tue, 15 Apr 2003 11:52:24 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Jamie Lokier <jamie@shareable.org>, Paul Mackerras <paulus@samba.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <20030415092332.GE10280@wohnheim.fh-wedel.de>
Message-ID: <Pine.GSO.4.21.0304151151290.26578-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003, [iso-8859-1] Jörn Engel wrote:
> On Tue, 15 April 2003 10:11:37 +0200, Geert Uytterhoeven wrote:
> > BTW, Atari uses MS-DOS style partitioning.
> 
> Interesting. Then how do you explain this (2.5.67)
> config MSDOS_PARTITION
> 	bool "PC BIOS (MSDOS partition tables) support" if PARTITION_ADVANCED
> 	default y if !PARTITION_ADVANCED && !AMIGA && !ATARI && !MAC && !SGI_IP22 && !ARM && !SGI_IP27
> 
> or this (2.4.20)
>    if [ "$CONFIG_AMIGA" != "y" -a "$CONFIG_ATARI" != "y" -a \
>         "$CONFIG_MAC" != "y" -a "$CONFIG_SGI_IP22" != "y" -a \
>         "$CONFIG_SGI_IP27" != "y" ]; then
>       define_bool CONFIG_MSDOS_PARTITION y
>    fi
> 
> In both cases, CONFIG_MSDOS_PARTITION is always y, *except* for Atari
> and some others. According to your comment above, that should be
> changed, shouldn't it?

Bummer, better check the sources first (I never had an Atari). Atari uses its
own partitioning scheme.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


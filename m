Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUIALtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUIALtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUIALsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:48:35 -0400
Received: from witte.sonytel.be ([80.88.33.193]:58537 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266193AbUIALpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:45:54 -0400
Date: Wed, 1 Sep 2004 13:44:57 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ian Wienand <ianw@gelato.unsw.edu.au>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: kbuild: Support LOCALVERSION
In-Reply-To: <20040831192642.GA15855@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.58.0409011341140.15681@waterleaf.sonytel.be>
References: <20040831192642.GA15855@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004, Sam Ravnborg wrote:
> This allows one to put a short string in localversion identifying this
> particular configuration "-smpacpi", or to identify applied patches
> to the source "-llat-np".
>
> More specifically:
> $(srctree)/localversion-lowlatency contains "-llat"
> $(srctree)/localversion-scheduler-nick constins "-np"
>
> $(objtree)/localversion contains "-smpacpi"
>
> Resulting KERNELRELEASE would be:
> 2.6.8.rc1-smpacpi-llat-np

Wouldn't it make more sense the other way around (i.e. first append
$(srctree)/localversion-*, then append $(objtree)/localversion*)?

Hmm, from a second thought the order depends on what your most interested in:
building kernels with different configs, or building kernels from different
sources.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

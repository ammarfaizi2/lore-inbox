Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282976AbRK0V52>; Tue, 27 Nov 2001 16:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbRK0V5T>; Tue, 27 Nov 2001 16:57:19 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:17418 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S282974AbRK0V5I>;
	Tue, 27 Nov 2001 16:57:08 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15364.1721.506563.253393@gargle.gargle.HOWL>
Date: Wed, 28 Nov 2001 08:33:45 +1100 (EST)
To: war <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16 Bug (PPC)
In-Reply-To: <3C028378.50CA616C@starband.net>
In-Reply-To: <3C028378.50CA616C@starband.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war writes:

> Bug still resides in 2.4.16 still, even after the PPC fixes that were
> applied to 2.4.16-pre1.
> 
> If nobody cares about PPC updates, I guess I should put the box back on
> the shelf.

Gratuitous rudeness will usually get you an answer. :)

> The video driver (plat) is the framebuffer for a few macs, without it,
> I cannot do anything.
> 
> Any plans to fix this?
> 
> //              default_vmode = nvram_read_byte(NV_VMODE);
> //              default_cmode = nvram_read_byte(NV_CMODE);
>
> Commenting the two undefined functions out in drivers/video/platinumfb.c
> allows for a successful compile.
> It also allows for the video driver to be brought up succesfully.

Have you reported this before, on this list or anywhere else?

The problem is that your config is slightly unusual in that you have
turned off CONFIG_NVRAM.  We can put some ifdefs in so that it
compiles without CONFIG_NVRAM.  For now, just turn on CONFIG_NVRAM.

Paul.

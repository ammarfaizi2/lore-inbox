Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVASP1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVASP1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVASP1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:27:49 -0500
Received: from witte.sonytel.be ([80.88.33.193]:32651 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261748AbVASP1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:27:47 -0500
Date: Wed, 19 Jan 2005 16:27:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kumar Gala <kumar.gala@freescale.com>
cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] raid6: altivec support
In-Reply-To: <F0F87817-6A2C-11D9-AC28-000393DBC2E8@freescale.com>
Message-ID: <Pine.GSO.4.61.0501191622060.15516@waterleaf.sonytel.be>
References: <Pine.GSO.4.61.0501191606260.15516@waterleaf.sonytel.be>
 <F0F87817-6A2C-11D9-AC28-000393DBC2E8@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005, Kumar Gala wrote:
> On Jan 19, 2005, at 9:08 AM, Geert Uytterhoeven wrote:
> > On Wed, 19 Jan 2005, David Woodhouse wrote:
> > > The binary structure which changes every few weeks and which is shared
> >  > between the bootloader and the kernel? Yeah, "somewhat broken" is one
> > > way of putting it :)
> >  >
> > > The ARM kernel does it a lot better with tag,value pairs.
> > 
> > As does m68k... That's why we never got beyond bootinfo major version 2.
> 
> Out of interest, on ARM & m68k I would assume that the list of tag's gets
> added to over time?

That's true. But besides the recent conversion of the HP9000/[34]00 code to
use bootinfo, not much has changed during the last 5 years.

If a tag is not recognized, it's just ignored. That means your new feature
cannot be used by the kernel, but it doesn't break the bootloader<->kernel
interface the hard way.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

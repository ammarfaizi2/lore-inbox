Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSLMInJ>; Fri, 13 Dec 2002 03:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSLMInI>; Fri, 13 Dec 2002 03:43:08 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:52984 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261600AbSLMInH>;
	Fri, 13 Dec 2002 03:43:07 -0500
Date: Fri, 13 Dec 2002 09:49:30 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: James Simmons <jsimmons@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: atyfb in 2.5.51
In-Reply-To: <1039596149.24691.2.camel@rth.ninka.net>
Message-ID: <Pine.GSO.4.21.0212130946100.6939-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 2002, David S. Miller wrote:
> On Tue, 2002-12-10 at 22:18, James Simmons wrote:
> > > AFAIK, the X "mach64" driver in XF 4.* doesn't care about UseFBDev.
> > > Marc Aurele La France (maintainer of this driver) is basically allergic
> > > to kernel fbdev support.
> > 
> > :-(
> 
> I've always stated that the whole fbdev model was flawed, it makes
> basic assumptions about how a video card's memory and registers are
> accessed (ie. the programming model) and many popular cards absolutely
> do not fit into that model.

Could you please elaborate so we have a chance to improve the model? Thanks!

In case you just mean graphics hardware (e.g. Creator) where you don't want to
provide direct access to the frame buffer, but do everything through the
acceleration engine, just set smem_start and smem_len both to 0.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


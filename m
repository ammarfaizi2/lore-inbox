Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTA1NH1>; Tue, 28 Jan 2003 08:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTA1NH1>; Tue, 28 Jan 2003 08:07:27 -0500
Received: from ns.suse.de ([213.95.15.193]:64517 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265339AbTA1NHY>;
	Tue, 28 Jan 2003 08:07:24 -0500
Date: Tue, 28 Jan 2003 14:16:43 +0100
From: Stefan Reinauer <stepan@suse.de>
To: John Bradford <john@grabjohn.com>
Cc: Raphael Schmid <Raphael_Schmid@CUBUS.COM>, linux-kernel@vger.kernel.org
Subject: Re: Bootscreen
Message-ID: <20030128131643.GB23296@suse.de>
References: <398E93A81CC5D311901600A0C9F29289469375@cubuss2> <200301281052.h0SAqW1n000148@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301281052.h0SAqW1n000148@darkstar.example.net>
User-Agent: Mutt/1.4i
X-Message-Flag: Life is too short to use a crappy OS.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Bradford <john@grabjohn.com> [030128 11:52]:
> > Yeah, these can be easily supressed, somewhere in arch/i386/boot/compressed
> > 
> > Are you in effect saying that Linux is *not* reinitializing the display,
> > but the bootloader is?
> 
> No.
> 
> If you use the framebuffer, the kernel re-initialises the display when
> it boots.

In vesafb this is different. The video mode is set before 32bit mode is
entered, then the 32bit part of the kernel just assumes it can paint to
some memory found attached to the graphics device.
Still, for painting a bootsplash screen using fbcon, this does not
matter as all you need is the framebuffer memory.

Stefan
  
-- 
The use of COBOL cripples the mind; its teaching should, therefore, be
regarded as a criminal offense.                      -- E. W. Dijkstra

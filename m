Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290309AbSBKUXR>; Mon, 11 Feb 2002 15:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290310AbSBKUXI>; Mon, 11 Feb 2002 15:23:08 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:27269
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S290309AbSBKUW7>; Mon, 11 Feb 2002 15:22:59 -0500
Date: Mon, 11 Feb 2002 12:54:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: John Hesterberg <jh@sgi.com>
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: driver location for platform-specific drivers
Message-ID: <20020211195458.GB9348@opus.bloom.county>
In-Reply-To: <20020211131744.A16032@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211131744.A16032@sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 01:17:44PM -0600, John Hesterberg wrote:

>     3) New platform directory.
>        Create a platform directory for SN, probably drivers/sn.
>        There is precedence for this with the drivers/macintosh


Being a PPC person, I sometimes wonder if this wsn't a horrible idea
sometimes.  Much of whats in thereshould be in a 'drivers/adb' or so,
ince it's all specific to the ADB bus, with the exception of things like
'rtc.c' (which works on all PPC except APUS).  Keep in mind other
'macintosh' specific drivers, like network ones, are in drivers/net/.

Wer also have an arch/ppc/{8xx,8260}_io/ directories for other
platform-specific drivers, which I want to kill in 2.5.x timeframe.

> I'm happy with whatever you'll accept.  To give you something to
> either agree with or shoot down, I'll suggest #3.  SGI's Scalable
> Node product will be different enough, with enough platform specific
> drivers, that it justifies it's own subdirectory, and that this
> should be called drivers/sn.

What excelty are the specific to tho?  Are these all for a new bus?
If these are just variopus network, io, whatnot drivers, just put them
in drivers/whatever.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

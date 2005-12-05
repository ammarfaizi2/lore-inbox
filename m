Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVLEG3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVLEG3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 01:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbVLEG3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 01:29:34 -0500
Received: from ip51cf17c4.direct-adsl.nl ([81.207.23.196]:15806 "EHLO
	xtr.attic.nerdnet.nl") by vger.kernel.org with ESMTP
	id S1751348AbVLEG3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 01:29:33 -0500
Date: Mon, 5 Dec 2005 07:27:50 +0100
From: Arno Griffioen <arno@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean-Luc Leger <reiga@dspnet.fr.eu.org>,
       Arno Griffioen <arno.griffioen@ieee.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: CONFIG_GG2 (was: Re: Some kconfig issues)
Message-ID: <20051205062750.GA2398@attic.nerdnet.nl>
References: <20051203195254.GG72294@dspnet.fr.eu.org> <Pine.LNX.4.62.0512042237520.15120@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0512042237520.15120@pademelon.sonytel.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 10:49:42PM +0100, Geert Uytterhoeven wrote:
> > GG2 in arch/m68k/Kconfig
> 
> Indeed, Amiga Golden Gate II Zorro/ISA bridge support is only partially there,
> and cannot be selected.
> 
> Arno, do we still miss a lot?

No, not as far as I know.. I'll try to build 2.6 on my Amiga with the GG
card soon and post the driver ont he list.

The 'driver' (if you can call it that) for the card pretty much does nothing 
anymore, just flip some bits on the card to enable it's interrupt forwarding and
enabling or disabling the waitstates on the ISA BUS.

Because most i386/ISA drivers these days can handle shared/chained interrupt
handlers like we always had on the m68k it's no longer needed to set up a
secondary IRQ handling for the ISA drivers. (like I had to do for 2.2)

After that it's just a matter of some macro's for the byte-swapping of
the ISA data and the address mangling for accessing the I/O and memory space.

Of course no DMA support and such, so no need to mess with that..

							Bye, Arno.

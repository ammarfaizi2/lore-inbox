Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbVAQM7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVAQM7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 07:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVAQM7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 07:59:15 -0500
Received: from witte.sonytel.be ([80.88.33.193]:4053 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262789AbVAQM7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 07:59:05 -0500
Date: Mon, 17 Jan 2005 13:58:56 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] SCSI NCR53C9x.c: some cleanups
In-Reply-To: <20050117125449.GP4274@stusta.de>
Message-ID: <Pine.GSO.4.61.0501171358230.3299@waterleaf.sonytel.be>
References: <200412290732.iBT7WifI018047@hera.kernel.org>
 <Pine.GSO.4.61.0501171339270.3226@waterleaf.sonytel.be> <20050117125449.GP4274@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005, Adrian Bunk wrote:
> On Mon, Jan 17, 2005 at 01:41:29PM +0100, Geert Uytterhoeven wrote:
> > On Tue, 21 Dec 2004, Linux Kernel Mailing List wrote:
> > > ChangeSet 1.2034.61.36, 2004/12/21 09:41:18-06:00, bunk@stusta.de
> > > 
> > > 	[PATCH] SCSI NCR53C9x.c: some cleanups
> > > 	
> > > 	Make two functions static
> > 
> > > --- a/drivers/scsi/NCR53C9x.c	2004-12-28 23:32:55 -08:00
> > > +++ b/drivers/scsi/NCR53C9x.c	2004-12-28 23:32:55 -08:00
> > > @@ -505,7 +505,7 @@
> > >  }
> > >  
> > >  /* This places the ESP into a known state at boot time. */
> > > -void esp_bootup_reset(struct NCR_ESP *esp, struct ESP_regs *eregs)
> > > +static void esp_bootup_reset(struct NCR_ESP *esp, struct ESP_regs *eregs)
> > >  {
> > >  	volatile unchar trash;
> > >  
> > 
> > This change breaks the Amiga Oktagon SCSI driver (drivers/scsi/oktagon_esp.c),
> > which calls esp_bootup_reset().
> 
> My bad - I did grep for esp_bootup_reset, but I confused the function 
> prototype in oktagon_esp.c with a local function in this file.
> 
> @Linus:
> Please exclude my buggy patch.

Or better: I'll move the prototype to drivers/scsi/NCR53C9x.h.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

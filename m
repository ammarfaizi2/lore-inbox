Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVAQMzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVAQMzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 07:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVAQMzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 07:55:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36622 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262785AbVAQMyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 07:54:54 -0500
Date: Mon, 17 Jan 2005 13:54:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] SCSI NCR53C9x.c: some cleanups
Message-ID: <20050117125449.GP4274@stusta.de>
References: <200412290732.iBT7WifI018047@hera.kernel.org> <Pine.GSO.4.61.0501171339270.3226@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0501171339270.3226@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 01:41:29PM +0100, Geert Uytterhoeven wrote:
> On Tue, 21 Dec 2004, Linux Kernel Mailing List wrote:
> > ChangeSet 1.2034.61.36, 2004/12/21 09:41:18-06:00, bunk@stusta.de
> > 
> > 	[PATCH] SCSI NCR53C9x.c: some cleanups
> > 	
> > 	Make two functions static
> 
> > --- a/drivers/scsi/NCR53C9x.c	2004-12-28 23:32:55 -08:00
> > +++ b/drivers/scsi/NCR53C9x.c	2004-12-28 23:32:55 -08:00
> > @@ -505,7 +505,7 @@
> >  }
> >  
> >  /* This places the ESP into a known state at boot time. */
> > -void esp_bootup_reset(struct NCR_ESP *esp, struct ESP_regs *eregs)
> > +static void esp_bootup_reset(struct NCR_ESP *esp, struct ESP_regs *eregs)
> >  {
> >  	volatile unchar trash;
> >  
> 
> This change breaks the Amiga Oktagon SCSI driver (drivers/scsi/oktagon_esp.c),
> which calls esp_bootup_reset().

My bad - I did grep for esp_bootup_reset, but I confused the function 
prototype in oktagon_esp.c with a local function in this file.

@Linus:
Please exclude my buggy patch.

> Gr{oetje,eeting}s,
> 
> 						Geert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317448AbSHHSVb>; Thu, 8 Aug 2002 14:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317581AbSHHSUs>; Thu, 8 Aug 2002 14:20:48 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:60168
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317799AbSHHSTg>; Thu, 8 Aug 2002 14:19:36 -0400
Date: Thu, 8 Aug 2002 11:02:04 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Nick Orlov <nick.orlov@mail.ru>
cc: Bill Davidsen <davidsen@tmr.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <20020808174258.GA5622@nikolas.hn.org>
Message-ID: <Pine.LNX.4.10.10208081052270.25573-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Because I can not get a FSCKING PATCH past any of the Lead Penquins.

/src/linux-2.5.4-pristine/drivers/ide/ide-pci.c
#ifdef CONFIG_PDC202XX_FORCE
        {DEVID_PDC20265,"PDC20265",     PCI_PDC202XX,   ATA66_PDC202XX,
INIT_PDC202XX,  NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
ON_BOARD,
48 },
#else /* !CONFIG_PDC202XX_FORCE */
        {DEVID_PDC20265,"PDC20265",     PCI_PDC202XX,   ATA66_PDC202XX,
INIT_PDC202XX,  NULL,           {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
OFF_BOARD,
48 },
#endif

But since there is the option to compile off-board as bootable, it is a
noop.  I have not been able to directly add code or update any kernel
first hand since the change in 2.5.3 and my exit of Linux Development at
2.5.5.  So I really don't give a damn.

But what I do know is people bug me for patches and updates and ask me to
fix 2.5.XX on a regular bases.  Nobody takes my patches but man when crap
hits the fan they come running for me to put it right again.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 8 Aug 2002, Nick Orlov wrote:

> On Thu, Aug 08, 2002 at 03:50:19AM -0700, Andre Hedrick wrote:
> > On Wed, 7 Aug 2002, Bill Davidsen wrote:
> > 
> > > I would just as soon use a boot option as to try and make it a compile
> > > option, and I think that many people just use a compiled kernel and never
> > > change, which argues for a reasonable default (most pdc20265) ARE
> > > currently offboard, and an easy way to change it.
> > 
> > There are ZERO pdc20265's offboard, only pdc20267's were in both options.
> > This is the direct asic packaging.  Thus all pdc20265 have the right to be
> > listed as onboard.
> 
> Could you comment next couple lines of code (2.4.19-vanilla):
> 
> ==========================================
> #else /* !CONFIG_PDC202XX_FORCE */
> [ ... skipped ... ]
>         {DEVID_PDC20265,"PDC20265" .... OFF_BOARD ..... },
>                                         ^^^^^^^^^
> [ ... skipped ... ]
> #endif
> ==========================================
> 
> Another bug? Just typo?
> Why author put PDC20265 in off-board list ?
> 
> > Cheers,
> > 
> > Andre Hedrick
> > LAD Storage Consulting Group
> > 
> 
> -- 
> With best wishes,
>         Nick Orlov.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


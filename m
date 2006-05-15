Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWEOXm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWEOXm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWEOXm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:42:29 -0400
Received: from animx.eu.org ([216.98.75.249]:57552 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1750810AbWEOXm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:42:28 -0400
Date: Mon, 15 May 2006 19:47:43 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT] major libata update
Message-ID: <20060515234743.GD4699@animx.eu.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060515170006.GA29555@havoc.gtf.org> <20060515230256.GB4699@animx.eu.org> <1147736327.26686.224.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147736327.26686.224.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2006-05-15 at 19:02 -0400, Wakko Warner wrote:
> > How about PATA?  Specifically intel's IDE chip.  I have a machine that I can
> > blow the hard drive away if I want to.
> 
> Give the patch on zeniv.linux.org.uk/~alan/IDE a go in that case and let
> me know how it behaves.

I noticed one hunk failed with 2.6.17-rc4 when using
patch-2.6.17-rc3-ide2.gz

It was only the version string so I should be ok.  As I said, if it blows up
on me, that's ok.

I attempted to patch Jeff's libata1 over top of this, it failed miserably.

When I patched Jeff's libata1 over 2.6.17-rc4, it was ok, except for 2
files:
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
32 out of 32 hunks ignored -- saving rejects to file drivers/scsi/ahci.c.rej
patching file drivers/scsi/ata_piix.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
5 out of 5 hunks ignored -- saving rejects to file
drivers/scsi/ata_piix.c.rej




If you're curious, alan's patch + jeff's patch:
patching file drivers/scsi/Makefile
Hunk #1 succeeded at 201 (offset 37 lines).
patching file drivers/scsi/ahci.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
32 out of 32 hunks ignored -- saving rejects to file drivers/scsi/ahci.c.rej
patching file drivers/scsi/ata_piix.c
Hunk #1 FAILED at 93.
Hunk #2 succeeded at 299 with fuzz 2 (offset 56 lines).
Hunk #3 succeeded at 335 with fuzz 2 (offset 61 lines).
Hunk #4 succeeded at 700 (offset 210 lines).
Hunk #5 succeeded at 805 (offset 234 lines).
1 out of 5 hunks FAILED -- saving rejects to file drivers/scsi/ata_piix.c.rej
patching file drivers/scsi/libata-bmdma.c
patching file drivers/scsi/libata-core.c
Hunk #23 succeeded at 1503 (offset 6 lines).
Hunk #24 succeeded at 1573 (offset 6 lines).
Hunk #25 succeeded at 1587 (offset 6 lines).
Hunk #26 succeeded at 1624 (offset 6 lines).
Hunk #27 succeeded at 1644 (offset 6 lines).
Hunk #28 succeeded at 1674 (offset 6 lines).
Hunk #29 succeeded at 1713 (offset 6 lines).
Hunk #30 succeeded at 1979 (offset 6 lines).
Hunk #31 succeeded at 2218 (offset 6 lines).
Hunk #32 succeeded at 2228 (offset 6 lines).
Hunk #33 succeeded at 2321 (offset 6 lines).
Hunk #34 succeeded at 2348 (offset 6 lines).
Hunk #35 succeeded at 2416 (offset 6 lines).
Hunk #36 succeeded at 2425 (offset 6 lines).
Hunk #37 succeeded at 2463 (offset 6 lines).
Hunk #38 succeeded at 2493 (offset 6 lines).
Hunk #39 succeeded at 2501 (offset 6 lines).
Hunk #40 succeeded at 2519 (offset 6 lines).
Hunk #41 succeeded at 2537 (offset 6 lines).
Hunk #42 succeeded at 2549 (offset 6 lines).
Hunk #43 succeeded at 2628 (offset 6 lines).
Hunk #44 succeeded at 2687 (offset 6 lines).
Hunk #45 succeeded at 2695 (offset 6 lines).
Hunk #46 succeeded at 2720 (offset 6 lines).
Hunk #47 succeeded at 2744 (offset 6 lines).
Hunk #48 succeeded at 2759 (offset 6 lines).
Hunk #49 succeeded at 2830 (offset 6 lines).
Hunk #50 succeeded at 2850 (offset 6 lines).
Hunk #51 succeeded at 2874 (offset 6 lines).
Hunk #52 succeeded at 2886 (offset 6 lines).
Hunk #53 succeeded at 2992 (offset 6 lines).
Hunk #54 FAILED at 3006.
Hunk #55 succeeded at 3068 (offset 1 line).
Hunk #56 succeeded at 3076 (offset 1 line).
Hunk #57 succeeded at 3091 (offset 1 line).
Hunk #58 succeeded at 3101 (offset 1 line).
Hunk #59 succeeded at 3114 (offset 1 line).
Hunk #60 succeeded at 3259 (offset 1 line).
Hunk #61 succeeded at 3496 (offset 1 line).
Hunk #62 succeeded at 3634 (offset -28 lines).
Hunk #63 FAILED at 3659.
Hunk #64 succeeded at 3761 with fuzz 1 (offset -28 lines).
Hunk #65 succeeded at 3786 (offset -28 lines).
Hunk #66 FAILED at 3813.
Hunk #67 FAILED at 3849.
Hunk #68 succeeded at 4207 (offset -27 lines).
Hunk #69 succeeded at 4226 (offset -27 lines).
Hunk #70 succeeded at 4269 (offset -27 lines).
Hunk #71 succeeded at 4450 (offset -27 lines).
Hunk #72 succeeded at 4515 (offset -27 lines).
Hunk #73 succeeded at 4643 (offset -27 lines).
Hunk #74 succeeded at 4711 (offset -27 lines).
Hunk #75 succeeded at 4749 (offset -27 lines).
Hunk #76 succeeded at 4764 (offset -27 lines).
Hunk #77 succeeded at 4937 (offset -27 lines).
Hunk #78 succeeded at 4959 (offset -27 lines).
Hunk #79 succeeded at 5112 (offset -23 lines).
Hunk #80 succeeded at 5126 (offset -23 lines).
Hunk #81 succeeded at 5193 (offset -23 lines).
Hunk #82 succeeded at 5266 (offset -21 lines).
Hunk #83 succeeded at 5318 (offset -15 lines).
Hunk #84 succeeded at 5413 (offset -15 lines).
Hunk #85 succeeded at 5577 (offset -15 lines).
Hunk #86 succeeded at 5636 (offset -15 lines).
Hunk #87 succeeded at 5661 (offset -13 lines).
Hunk #88 succeeded at 5682 (offset -13 lines).
Hunk #89 succeeded at 5721 (offset -13 lines).
4 out of 89 hunks FAILED -- saving rejects to file drivers/scsi/libata-core.c.rej
patching file drivers/scsi/libata-eh.c
patching file drivers/scsi/libata-scsi.c
patching file drivers/scsi/libata.h
patching file drivers/scsi/pdc_adma.c
patching file drivers/scsi/sata_mv.c
Hunk #2 succeeded at 682 (offset 2 lines).
Hunk #3 succeeded at 1311 (offset 2 lines).
Hunk #4 succeeded at 1398 (offset 2 lines).
Hunk #5 succeeded at 1419 (offset 2 lines).
Hunk #6 succeeded at 1936 (offset 2 lines).
Hunk #7 succeeded at 1962 (offset 2 lines).
Hunk #8 succeeded at 1994 (offset 2 lines).
Hunk #9 succeeded at 2025 (offset 2 lines).
patching file drivers/scsi/sata_nv.c
Hunk #2 succeeded at 280 (offset 1 line).
patching file drivers/scsi/sata_promise.c
Hunk #2 succeeded at 438 (offset 2 lines).
Hunk #3 succeeded at 446 (offset 2 lines).
Hunk #4 succeeded at 537 (offset 2 lines).
Hunk #5 succeeded at 680 (offset 2 lines).
patching file drivers/scsi/sata_qstor.c
Hunk #2 succeeded at 176 (offset 1 line).
Hunk #3 succeeded at 395 (offset 1 line).
Hunk #4 succeeded at 428 (offset 1 line).
patching file drivers/scsi/sata_sil.c
Hunk #3 FAILED at 176.
Hunk #4 succeeded at 269 (offset 1 line).
Hunk #5 succeeded at 320 (offset 1 line).
Hunk #6 succeeded at 393 (offset 1 line).
Hunk #7 succeeded at 417 (offset 1 line).
Hunk #8 succeeded at 507 (offset 1 line).
1 out of 8 hunks FAILED -- saving rejects to file drivers/scsi/sata_sil.c.rej
patching file drivers/scsi/sata_sil24.c
Hunk #9 succeeded at 388 with fuzz 2 (offset 1 line).
Hunk #10 succeeded at 415 (offset 1 line).
Hunk #11 succeeded at 425 (offset 1 line).
Hunk #12 succeeded at 434 (offset 1 line).
Hunk #13 succeeded at 442 (offset 1 line).
Hunk #14 succeeded at 510 (offset 1 line).
Hunk #15 succeeded at 580 (offset 1 line).
Hunk #16 succeeded at 661 (offset 1 line).
Hunk #17 succeeded at 687 (offset 1 line).
Hunk #18 succeeded at 699 (offset 1 line).
Hunk #19 succeeded at 709 (offset 1 line).
Hunk #20 succeeded at 729 (offset 1 line).
Hunk #21 succeeded at 890 (offset 1 line).
Hunk #22 succeeded at 903 (offset 1 line).
Hunk #23 succeeded at 940 (offset 1 line).
Hunk #24 succeeded at 1004 (offset 1 line).
Hunk #25 succeeded at 1057 (offset 1 line).
Hunk #26 succeeded at 1115 (offset 1 line).
Hunk #27 succeeded at 1137 (offset 1 line).
patching file drivers/scsi/sata_sis.c
patching file drivers/scsi/sata_svw.c
patching file drivers/scsi/sata_sx4.c
Hunk #2 succeeded at 219 (offset 1 line).
Hunk #3 succeeded at 834 (offset 1 line).
Hunk #4 succeeded at 869 (offset 1 line).
Hunk #5 succeeded at 1377 (offset 1 line).
patching file drivers/scsi/sata_uli.c
patching file drivers/scsi/sata_via.c
patching file drivers/scsi/sata_vsc.c
patching file drivers/scsi/scsi.c
patching file drivers/scsi/scsi_error.c
patching file drivers/scsi/scsi_lib.c
patching file drivers/scsi/scsi_priv.h
patching file include/linux/ata.h
patching file include/linux/libata.h
Hunk #2 succeeded at 45 with fuzz 2.
Hunk #4 FAILED at 123.
Hunk #5 succeeded at 140 (offset 1 line).
Hunk #6 succeeded at 223 (offset 1 line).
Hunk #7 succeeded at 284 (offset 1 line).
Hunk #8 succeeded at 375 (offset 1 line).
Hunk #9 succeeded at 387 (offset 1 line).
Hunk #10 succeeded at 424 (offset 1 line).
Hunk #11 succeeded at 466 (offset 1 line).
Hunk #12 succeeded at 489 (offset 1 line).
Hunk #13 succeeded at 531 (offset 3 lines).
Hunk #14 succeeded at 585 (offset 3 lines).
Hunk #15 succeeded at 610 (offset 3 lines).
Hunk #16 FAILED at 666.
Hunk #17 succeeded at 735 (offset 7 lines).
Hunk #18 succeeded at 821 (offset 7 lines).
Hunk #19 succeeded at 934 (offset 7 lines).
Hunk #20 succeeded at 977 (offset 7 lines).
Hunk #21 succeeded at 1060 (offset 7 lines).
Hunk #22 succeeded at 1097 (offset 7 lines).
2 out of 22 hunks FAILED -- saving rejects to file include/linux/libata.h.rej
patching file include/scsi/scsi_cmnd.h
patching file include/scsi/scsi_eh.h
patching file include/scsi/scsi_host.h


-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???

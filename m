Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUJVSI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUJVSI2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUJVSIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:08:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30980 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267818AbUJVSHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:07:23 -0400
Date: Fri, 22 Oct 2004 19:07:15 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] ide-2.6 update
Message-ID: <20041022190715.B3459@flint.arm.linux.org.uk>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	torvalds@osdl.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <58cb370e04102210385ca8b554@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <58cb370e04102210385ca8b554@mail.gmail.com>; from bzolnier@gmail.com on Fri, Oct 22, 2004 at 07:38:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 07:38:44PM +0200, Bartlomiej Zolnierkiewicz wrote:
> @@ -498,14 +483,6 @@
>  			ICS_ARCIN_V6_INTRSTAT_1)) & 1;
>  }
>  
> -static int icside_dma_verbose(ide_drive_t *drive)
> -{
> -	printk(", %s (peak %dMB/s)",
> -		ide_xfer_verbose(drive->current_speed),
> -		2000 / drive->drive_data);
> -	return 1;
> -}
> -
>  static int icside_dma_timeout(ide_drive_t *drive)
>  {
>  	printk(KERN_ERR "%s: DMA timeout occurred: ", drive->name);
> @@ -554,7 +531,6 @@
>  	hwif->dma_start		= icside_dma_start;
>  	hwif->ide_dma_end	= icside_dma_end;
>  	hwif->ide_dma_test_irq	= icside_dma_test_irq;
> -	hwif->ide_dma_verbose	= icside_dma_verbose;
>  	hwif->ide_dma_timeout	= icside_dma_timeout;
>  	hwif->ide_dma_lostirq	= icside_dma_lostirq;

Why are you denying me the ability to report detailed drive transfer
speed information?  Would you prefer me to printk a separate line
and further clutter up the message log instead?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

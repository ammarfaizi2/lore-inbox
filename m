Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285393AbRLSQjx>; Wed, 19 Dec 2001 11:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285390AbRLSQjf>; Wed, 19 Dec 2001 11:39:35 -0500
Received: from bigspace.hitnet.RWTH-Aachen.DE ([137.226.181.2]:28970 "EHLO
	bigspace.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S285388AbRLSQjZ>; Wed, 19 Dec 2001 11:39:25 -0500
Date: Wed, 19 Dec 2001 17:37:53 +0100
From: Thomas Deselaers <thomas@deselaers.de>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Brendan Pike <spike@superweb.ca>
Subject: Re: IDE Harddrive Performance
Message-ID: <20011219163753.GD4259@leukertje.hitnet.rwth-aachen.de>
In-Reply-To: <01121911444703.31762@spikes> <Pine.LNX.4.33.0112191101230.4575-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0112191101230.4575-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 11:20:22AM -0500, Mark Hahn wrote:
> > > I do have an Asus P2B-S Mainboard and since a week I have a Maxtor 60 GB
> 
> that's piix-based, is it not?

It is BX-chipset, not exactly sure if this is what is called piix. But I
think so and found this in /proc/ide/pix

                                Intel PIIX4 Ultra 33 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1
------DMA enabled:    yes              no              yes               no 
UDMA enabled:   yes              no              yes               no 
UDMA enabled:   2                X               2                 X
UDMA
DMA
PIO

> > >  Timing buffered disk reads:  64 MB in  5.63 seconds = 11.37 MB/sec
> 
> should be more like 30 MB/s, so you must not have the piix controller
> in your kernel.

I was expecting something above 20MB/s, and thus I wondered about the low
values. Well and when I tried first time, my computer was not really idle
and thus I only got something around 3.5 MB/s.
 

OK, what do I need to compile into my kernel to have the chipset configured
fine? Or do I need any boot-parameters?

Here is an excerpt from my kernel-config:

CONFIG_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDE_CHIPSETS=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

everything skipped is just not set.

Thanks, thomas
-- 
thomas@deselaers.de «<>» JabberID on request «<>» GPG/PGP key on request
  «< Unless stated otherwise everything I write is just my opinion >»

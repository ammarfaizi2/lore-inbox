Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317419AbSGDOQZ>; Thu, 4 Jul 2002 10:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSGDOQY>; Thu, 4 Jul 2002 10:16:24 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:21703 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317419AbSGDOQY>;
	Thu, 4 Jul 2002 10:16:24 -0400
Date: Thu, 4 Jul 2002 16:18:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24 IDE 97
Message-ID: <20020704161809.A27207@ucw.cz>
References: <Pine.SOL.4.30.0207030021060.27685-200000@mion.elka.pw.edu.pl> <20020704142938.D11601@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020704142938.D11601@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Jul 04, 2002 at 02:29:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 02:29:38PM +0100, Russell King wrote:

> On Wed, Jul 03, 2002 at 12:22:11AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > This patch is a accumulation of ata-hosts-7/8/9/10/11, ata-autodma
> > and ata-ata66_check patches previously posted on LKML.
> 
> >From a first review only, it looks like this patch prevents the chipset
> drivers from disabling DMA mode on initialisation.  This is Really Bad(tm)
> since some revisions of some chipsets must _never_ be placed into DMA
> mode due to hardware bugs.  Even if the user selects CONFIG_IDEDMA_AUTO.
> 
> The code in sl82c105.c knows about the chipset revisions that this is
> required for, and it looks like the code in ide-pci.c will override the
> chipset if CONFIG_IDEDMA_AUTO is enabled.

I think the best solution (for now) probably would be to supply the mode
map to the core IDE driver so that it can choose which modes (and
whether DMA) are available.

-- 
Vojtech Pavlik
SuSE Labs

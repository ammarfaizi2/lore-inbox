Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbVBEWAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbVBEWAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 17:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbVBEWAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 17:00:09 -0500
Received: from EASTCAMPUS-THREE-FORTY-FOUR.MIT.EDU ([18.248.6.89]:20096 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265973AbVBEV76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 16:59:58 -0500
Date: Sat, 5 Feb 2005 16:55:04 -0500
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange device init
Message-ID: <20050205215504.GA3621@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <4204FDEA.3090306@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4204FDEA.3090306@drzeus.cx>
User-Agent: Mutt/1.5.6+20040907i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 06:10:02PM +0100, Pierre Ossman wrote:
> I'm having problem with a card reader on a laptop (Acer Aspire 1501). 
> The device doesn't get its resources configured properly.
> 
> The reader is connected to the LPC bus so there is no standardised way 
> to configure the device. On other laptops the configuration is done via 
> ACPI (_STA & co. in the DSDT). On this laptop these functions don't do a 
> damn thing.
> In Windows this device gets configured through some other means. It's 
> not in the driver (I've disected it to confirm this). But under Linux 
> the device is left unconfigured.
> 
> So my question is if anyone has any ideas on how this device gets 
> configured by Windows and possibly how we can get this to work on Linux.
> 
> The reason this is an issue is that one cannot detect all the quirks of 
> the hardware so a PNP solution is prefered. In those cases the 
> manufacturer has chosen resources that work ok.
> 
> For some context: I am the maintainer of the driver for this hardware. I 
> have a laptop where the DSDT properly sets up the hardware. The Acer 
> belongs to some of my users but they are not familiar with the kernel so 
> I'm trying to fix this for them.
> 
> Rgds
> Pierre

So the device is not listed in the DSDT, or _SRS doesn't work?  Does _STA
succeed?  Finally have you checked if PnPBIOS detects the device?  Any
additional information you could provide would be appreciated.

Thanks,
Adam

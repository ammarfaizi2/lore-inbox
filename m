Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbTIJJZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbTIJJZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:25:22 -0400
Received: from pc1-cmbg5-6-cust223.cmbg.cable.ntl.com ([81.104.201.223]:36337
	"EHLO flat") by vger.kernel.org with ESMTP id S261200AbTIJJZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:25:19 -0400
Date: Wed, 10 Sep 2003 10:25:23 +0100
From: cb-lkml@fish.zetnet.co.uk
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE: Fix Power Management request race on resume
Message-ID: <20030910092522.GA1916@fish.zetnet.co.uk>
References: <20030910090419.GA3673@fish.zetnet.co.uk> <1063185375.1356.64.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063185375.1356.64.camel@gaston>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 11:16:15AM +0200, Benjamin Herrenschmidt wrote:
> On Wed, 2003-09-10 at 11:04, cb-lkml@fish.zetnet.co.uk wrote:
> > I applied this patch to 2.6.0-test5 and still have this problem:
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=106218353005043&w=2
> 
> There are a couple of other fixes pending though I don't thing
> they are related to your problem. Do you have a slave drive on
> this channel ? What driver are you using for the host controller ?
> Does it have a dma_check() function ?

It's a laptop, so there's no slave drive.

The host controller is a PIIX4, using CONFIG_BLK_DEV_PIIX. (Presumably
drivers/ide/pci/piix.c)

$ grep dma_check piix.c 
        hwif->ide_dma_check = &piix_config_drive_xfer_rate;

Charlie


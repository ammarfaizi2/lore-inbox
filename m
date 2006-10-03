Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWJCBI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWJCBI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWJCBI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:08:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:15273 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030202AbWJCBI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:08:28 -0400
Subject: Re: Undefined '.bus_to_virt', '.virt_to_bus' causes compile error
	on Powerpc 64-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Judith Lebzelter <judith@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <20061002214954.GD665@shell0.pdx.osdl.net>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 11:05:39 +1000
Message-Id: <1159837539.5482.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 14:49 -0700, Judith Lebzelter wrote:
> Hello:
> 
> For the automated cross-compile builds at OSDL, powerpc 64-bit 
> 'allmodconfig' is failing.  The warnings/errors below appear in 
> the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.

All those drivers are bogus and need to be updated. They should be
marked CONFIG_BROKEN

Ben.

> Thanks;
> Judith Lebzelter
> OSDL
> 
> -----------
> 
>   Building modules, stage 2.
>   MODPOST 1658 modules
> WARNING: Can't handle masks in drivers/ata/ahci:FFFF05
> WARNING: ".virt_to_bus" [sound/oss/sscape.ko] undefined!
> WARNING: ".virt_to_bus" [sound/oss/sound.ko] undefined!
> WARNING: ".bus_to_virt" [sound/oss/cs46xx.ko] undefined!
> WARNING: ".virt_to_bus" [sound/oss/cs46xx.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/scsi/tmscsim.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/scsi/BusLogic.ko] undefined!
> WARNING: ".virt_to_bus" [drivers/net/wan/lmc/lmc.ko] undefined!
> WARNING: ".virt_to_bus" [drivers/message/i2o/i2o_config.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/block/cpqarray.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/atm/zatm.ko] undefined!
> WARNING: ".virt_to_bus" [drivers/atm/zatm.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/atm/horizon.ko] undefined!
> WARNING: ".virt_to_bus" [drivers/atm/firestream.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/atm/firestream.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/atm/ambassador.ko] undefined!
> WARNING: ".virt_to_bus" [drivers/atm/ambassador.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


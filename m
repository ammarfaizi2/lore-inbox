Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVKAKF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVKAKF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 05:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVKAKFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 05:05:25 -0500
Received: from [85.8.13.51] ([85.8.13.51]:17045 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750724AbVKAKFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 05:05:25 -0500
Message-ID: <43673DDC.6090303@drzeus.cx>
Date: Tue, 01 Nov 2005 11:05:16 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: Jordan Crouse <jordan.crouse@amd.com>
CC: linux-kernel@vger.kernel.org, ralf.baechle@linux-mips.org,
       ppopov@embeddedalley.com
Subject: Re: Au1xxx MMC driver
References: <20051031164021.GG20777@cosmic.amd.com>
In-Reply-To: <20051031164021.GG20777@cosmic.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick extra comment. It would be nice if you could use the host 
controller name when doing the initial printk:

-         printk(KERN_INFO DRIVER_NAME ": MMC Controller %d set up at 
%8.8X (mode=%s)\n",
-                host->id, host->iobase, dma ? "dma" : "pio");
+         printk(KERN_INFO "%s: MMC Controller %d set up at %8.8X 
(mode=%s)\n",
+                mmc_hostname(mmc), host->id, host->iobase, dma ? "dma" 
: "pio");

It gives a nice, visible connection between the host name and the hardware.

Rgds
Pierre


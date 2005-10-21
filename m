Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVJUSAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVJUSAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbVJUSAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:00:55 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:25272 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S965048AbVJUSAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:00:54 -0400
X-ORBL: [67.117.73.34]
Date: Fri, 21 Oct 2005 21:00:28 +0300
From: Tony Lindgren <tony@atomide.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch 5/5] TI OMAP driver
Message-ID: <20051021180026.GN20442@atomide.com>
References: <20051019081906.615365000@omelas> <20051019091717.773678000@omelas> <435613B3.5060509@tremplin-utc.net> <20051019094439.GA12594@plexity.net> <20051021163553.GJ20442@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <20051021163553.GJ20442@atomide.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Tony Lindgren <tony@atomide.com> [051021 19:38]:
> 
> Cool, works on OMAP OSK after renaming the function above.

Looks like the following __iomem patch is needed for this to
work on OMAP H4.

At least these two compilers get confused without the following
patch:

arm-xscale-linux-gnu-gcc (GCC) 3.4.4
gcc version 3.4.3 (release) (CodeSourcery ARM Q1B 2005)

Regards,

Tony


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-omap-rng-24xx

--- a/drivers/char/rng/omap-rng.c
+++ b/drivers/char/rng/omap-rng.c
@@ -51,7 +51,7 @@
 #define RNG_SYSSTATUS		0x44		/* System status
 							[0] = RESETDONE */
 
-static u32 __iomem *rng_base;
+static void __iomem *rng_base;
 static struct clk *rng_ick;
 static struct device *rng_dev;
 

--7qSK/uQB79J36Y4o--

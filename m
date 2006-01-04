Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751903AbWAEDeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbWAEDeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbWAEDeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:34:24 -0500
Received: from 62.4.70.142.eliott-ness.com ([62.4.70.142]:38790 "HELO mput.de")
	by vger.kernel.org with SMTP id S1751903AbWAEDeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:34:24 -0500
Subject: Re: [PATCH 12/15] via-pmu: Wrap some uses of sleep_in_progress
	with proper ifdef's
From: Kristian Mueller <kernel@mput.de>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0ISL00EOC96O6A@a34-mta01.direcway.com>
References: <0ISL00EOC96O6A@a34-mta01.direcway.com>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 03:34:19 +0800
Message-Id: <1136403259.14273.17.camel@pismo>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben

On Mi, 2006-01-04 at 17:01 -0500, Ben Collins wrote:
> Basically completes what's already in the rest of the driver.
> sleep_in_progress is only defined for pm+ppc32.
> 
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>

We've already found a different solution to this in the Linuxppc-dev
list.

See:
 http://patchwork.ozlabs.org/linuxppc/patch?id=3737


Fix compilation of via-pmu.c without Power Management support.

Signed-off-by: Kristian Mueller <Kristian-M@Kristian-M.de>
Signed-off-by: Paul Mackerras <paulus@samba.org>

---

--- linux/drivers/macintosh/via-pmu.c.orig2005-12-15 11:28:28.000000000
+0800
+++ linux/drivers/macintosh/via-pmu.c2005-12-15 12:20:43.000000000 +0800
@@ -157,8 +157,8 @@ static int pmu_version;
 static int drop_interrupts;
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 static int option_lid_wakeup = 1;
-static int sleep_in_progress;
 #endif /* CONFIG_PM && CONFIG_PPC32 */
+static int sleep_in_progress;
 static unsigned long async_req_locks;
 static unsigned int pmu_irq_stats[11];



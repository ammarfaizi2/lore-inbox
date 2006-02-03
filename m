Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422929AbWBCU5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422929AbWBCU5U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422945AbWBCU5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:57:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51469 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422929AbWBCU5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:57:18 -0500
Date: Fri, 3 Feb 2006 21:57:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, John Stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] kernel/time/timeofday.c: make struct ts_interval static
Message-ID: <20060203205716.GI4408@stusta.de>
References: <20060203000704.3964a39f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203000704.3964a39f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 12:07:04AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm4:
>...
> +time-generic-timekeeping-infrastructure.patch
>...
>  Bring back John's time-reqork patches.  New, improved, fixed.
>...


This patch makes a needlessly global struct static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm5-full/kernel/time/timeofday.c.old	2006-02-03 20:04:56.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/kernel/time/timeofday.c	2006-02-03 20:05:09.000000000 +0100
@@ -80,7 +80,7 @@
  *	This constant is the requested fixed interval period
  *	in nanoseconds.
  */
-struct clocksource_interval ts_interval;
+static struct clocksource_interval ts_interval;
 #define INTERVAL_LEN ((PERIODIC_INTERVAL_MS-1)*1000000)
 
 /* [clocksource data]


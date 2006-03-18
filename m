Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751882AbWCRFzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbWCRFzs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 00:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbWCRFzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 00:55:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751882AbWCRFzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 00:55:48 -0500
Date: Fri, 17 Mar 2006 21:52:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/14] RTC: Remove RTC UIP synchronization on x86_64
Message-Id: <20060317215255.509fed49.akpm@osdl.org>
In-Reply-To: <3.132654658@selenic.com>
References: <2.132654658@selenic.com>
	<3.132654658@selenic.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
>  Remove RTC UIP synchronization on x86_64

Needed rework due to pending changes in get_cmos_time().  Please
check the result.

Patches which affect arch/x86_64/kernel/time.c:

	hpet-rtc-emulation-add-watchdog-timer.patch
	mark-cyc2ns_scale-readmostly.patch
	x86_64-mm-lost-ticks-dump-rip.patch
	x86_64-mm-pmtimer-dont-touch-pit.patch
	x86_64-mm-reenable-cmos-warning.patch
	x86_64-mm-time-style.patch
	x86_64-mm-year-check.patch

There are >1600 patches queued up already.  There's already a large RTC patch
series from Alessandro Zummo which has been queued for the last several
-mm's.

Your patches did merge up okayish but if they cause significant problems
I'll drop them, sorry.


Return-Path: <linux-kernel-owner+w=401wt.eu-S932202AbWLLQqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWLLQqX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWLLQqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:46:23 -0500
Received: from homer.mvista.com ([63.81.120.158]:13070 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932202AbWLLQqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:46:22 -0500
Subject: Re: + high-res-timers-utilize-tsc-clocksource-again.patch added to
	-mm tree
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@elte.hu
In-Reply-To: <200612010114.kB11EvV3027260@shell0.pdx.osdl.net>
References: <200612010114.kB11EvV3027260@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 08:46:09 -0800
Message-Id: <1165941969.8103.56.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +	if (pm == last_pm) {
> +		interval_tsc = now_tsc - last_tsc;
> +		interval_tsc *= HZ;
> +		do_div(interval_tsc, cpu_khz*1000);
> +	} else {
> +		if (pm < last_pm)
> +			pm += ACPI_PM_OVRRUN;
> +		pm_delta = pm - last_pm;
> +		interval_tsc = (((u64) pm_delta) * pm_multiplier) >> 22;
> +		do_div(interval_tsc, TICK_NSEC);
> +	}



What is this accomplishing? My TSC gets marked unstable, and it's not
unstable, in addition I have HRT off .. The else clause above just
doesn't seem right ..

Daniel


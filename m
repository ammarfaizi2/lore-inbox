Return-Path: <linux-kernel-owner+w=401wt.eu-S1751412AbXAFOzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbXAFOzI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 09:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXAFOzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 09:55:08 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:43817 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbXAFOzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 09:55:04 -0500
Date: Sat, 6 Jan 2007 15:20:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Wright <chrisw@sous-sol.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Georg Chini <georg.chini@triaton-webhosting.com>
Subject: Re: [patch 43/50] SOUND: Sparc CS4231: Fix IRQ return value and
 initialization.
In-Reply-To: <20070106023628.119087000@sous-sol.org>
Message-ID: <Pine.LNX.4.61.0701061518530.22558@yvahk01.tjqt.qr>
References: <20070106022753.334962000@sous-sol.org> <20070106023628.119087000@sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Subject: [patch 43/50] SOUND: Sparc CS4231: Fix IRQ return value and
>    initialization.
>
>--- linux-2.6.19.1.orig/sound/sparc/cs4231.c
>+++ linux-2.6.19.1/sound/sparc/cs4231.c
>@@ -1268,7 +1268,7 @@ static struct snd_pcm_hardware snd_cs423
> 	.channels_min		= 1,
> 	.channels_max		= 2,
> 	.buffer_bytes_max	= (32*1024),
>-	.period_bytes_min	= 4096,
>+	.period_bytes_min	= 256,
> 	.period_bytes_max	= (32*1024),
> 	.periods_min		= 1,
> 	.periods_max		= 1024,


>Subject: [patch 44/50] SOUND: Sparc CS4231: Use 64 for period_bytes_min
>--- linux-2.6.19.1.orig/sound/sparc/cs4231.c
>+++ linux-2.6.19.1/sound/sparc/cs4231.c
>@@ -1268,7 +1268,7 @@ static struct snd_pcm_hardware snd_cs423
> 	.channels_min		= 1,
> 	.channels_max		= 2,
> 	.buffer_bytes_max	= (32*1024),
>-	.period_bytes_min	= 256,
>+	.period_bytes_min	= 64,
> 	.period_bytes_max	= (32*1024),
> 	.periods_min		= 1,
> 	.periods_max		= 1024,

Can't 44 be folded into 43?


	-`J'
-- 

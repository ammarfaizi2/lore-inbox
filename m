Return-Path: <linux-kernel-owner+w=401wt.eu-S1751143AbXAFCd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbXAFCd4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbXAFCdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:33:41 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36922 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbXAFCd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:33:26 -0500
Message-Id: <20070106023628.119087000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:37 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de
Subject: [patch 44/50] SOUND: Sparc CS4231: Use 64 for period_bytes_min
Content-Disposition: inline; filename=sound-sparc-cs4231-use-64-for-period_bytes_min.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

    
This matches what the ISA cs4231 driver uses.

Tested by Georg Chini.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
commit f9af1d9deaaffe6803dec693748498886915d766

 sound/sparc/cs4231.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19.1.orig/sound/sparc/cs4231.c
+++ linux-2.6.19.1/sound/sparc/cs4231.c
@@ -1268,7 +1268,7 @@ static struct snd_pcm_hardware snd_cs423
 	.channels_min		= 1,
 	.channels_max		= 2,
 	.buffer_bytes_max	= (32*1024),
-	.period_bytes_min	= 256,
+	.period_bytes_min	= 64,
 	.period_bytes_max	= (32*1024),
 	.periods_min		= 1,
 	.periods_max		= 1024,
@@ -1288,7 +1288,7 @@ static struct snd_pcm_hardware snd_cs423
 	.channels_min		= 1,
 	.channels_max		= 2,
 	.buffer_bytes_max	= (32*1024),
-	.period_bytes_min	= 256,
+	.period_bytes_min	= 64,
 	.period_bytes_max	= (32*1024),
 	.periods_min		= 1,
 	.periods_max		= 1024,

--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTDIAaq (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTDIAaq (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:30:46 -0400
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:59506 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id S262655AbTDIAap (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 20:30:45 -0400
Date: Tue, 8 Apr 2003 20:41:54 -0400 (EDT)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.67] trivial compile fix for sound/isa/sb/sb16.c
In-Reply-To: <Pine.LNX.4.53.0304082008130.2109@quinn.larvalstage.com>
Message-ID: <Pine.LNX.4.53.0304082040370.2109@quinn.larvalstage.com>
References: <Pine.LNX.4.53.0304082008130.2109@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ack..  Here is the right patch.  Sorry.

John Kim

--- linux-2.5.67/sound/isa/sb/sb16.c	2003-04-07 13:32:23.000000000 -0400
+++ linux-2.5.67-new/sound/isa/sb/sb16.c	2003-04-08 20:38:36.000000000 -0400
@@ -331,7 +331,7 @@
 			goto __wt_error; 
 		} 
 		awe_port[dev] = pnp_port_start(pdev, 0);
-		snd_printdd("pnp SB16: wavetable port=0x%lx\n", pdev->resource[0].start);
+		snd_printdd("pnp SB16: wavetable port=0x%lx\n", awe_port[dev]);
 	} else {
 __wt_error:
 		if (pdev) {


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264687AbRFQEHG>; Sun, 17 Jun 2001 00:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbRFQEG4>; Sun, 17 Jun 2001 00:06:56 -0400
Received: from zbt61.eastnet.gatech.edu ([128.61.107.189]:30336 "EHLO pinky")
	by vger.kernel.org with ESMTP id <S264687AbRFQEGq>;
	Sun, 17 Jun 2001 00:06:46 -0400
Date: Sun, 17 Jun 2001 00:06:45 -0400
To: linux-kernel@vger.kernel.org
Subject: Longstanding APIC/NE2K bug
Message-ID: <20010617000645.A2022@zarq.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: rc@zarq.dhs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There has been a bug in the 2.4.x series of kernels for a long time (at
least -pre9) concerning SMP and ne2k-pci.

Maciej W. Rozycki posted a patch back during 2.4.0 that fixed this problem
"[patch] 2.4.0, 2.4.0-ac12: APIC lock-ups" in late January.  I've been
trying new kernels regularly since, and the patch doesn't seem to have
made it in (tested 2.4.2, .3, .4 and .5).  Falling back on my patched
2.4.0 works fine.

Symptoms: Network driver locks up.  Repeated messages of "ETH0: Transmit
timeout" occurs.  Unloading and reloading network drivers does not help,
reboot is required.  Usually only triggered by heavy network traffic
(300-400 megs at 700k or so usually does it).

Robert Cicconetti

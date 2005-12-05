Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVLEGZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVLEGZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 01:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVLEGZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 01:25:06 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:59348 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1751325AbVLEGZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 01:25:04 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200512050626.jB56Qf1o032238@auster.physics.adelaide.edu.au>
Subject: 2.6.14-rt21: slow-running clock
To: linux-kernel@vger.kernel.org
Date: Mon, 5 Dec 2005 16:56:40 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

When running Ingo's 2.6.14-rt21 (and in fact rt kernels back to at least
2.6.13-rc days), the clock on my i915-based laptop runs slow.  The degree
of slowness appears directly related to how busy the machine is.  If
it is just sitting around doing very little the time is kept rather
well.  However, as soon as the load increases the RTC and system time
diverge significantly.  For example, running jackd for 2 minutes results
in the system time loosing as much as 20 seconds compared to the CMOS RTC.
Processes doing HDD I/O also seem to affect the system time similarly.

Selectively disabling different timer-related kernel options does not make
any difference.  However, the clock seems fine under vanilla 2.6.14,
suggesting an issue somewhere in the rt patches.

HZ is set to 1000 on this machine in case that makes any difference.  I'm
happy to apply patches and run tests to try to narrow the problem down if
it will help.  Please CC me replys to ensure I see them.

Thanks and regards
  jonathan

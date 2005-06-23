Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVFWRwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVFWRwJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 13:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVFWRwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 13:52:08 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:19660 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262648AbVFWRvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 13:51:49 -0400
Subject: aic79xx -> can't  suspend
From: Lee Revell <rlrevell@joe-job.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 13:51:43 -0400
Message-Id: <1119549104.13259.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine with an Adaptec 2940U2W adapter running 2.6.11.  When I
try to go into standby like so:

    echo standby > /sys/power/state

this is what happens:

Stopping tasks:
===============================================================
stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, ahc_dv_0 not stopped
done 

The machine fails to suspend, and ahc_dv_0 is now wedged, consuming all
available CPU until reboot.

PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  SWAP WCHAN     COMMAND
735 root      39  19     0    0    0 S 99.3  0.0  53:09.97    0 text.lock [ahc_dv_0]

Lee







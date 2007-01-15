Return-Path: <linux-kernel-owner+w=401wt.eu-S1751308AbXAOTUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXAOTUA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbXAOTUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:20:00 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:57223 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbXAOTT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:19:59 -0500
Date: Tue, 16 Jan 2007 00:49:09 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul E McKenney <paulmck@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [mm PATCH] RCU: various patches
Message-ID: <20070115191909.GA32238@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please include this patchset for some testing in -mm.

This patchset consists of various merge candidates that would
do well to have some testing in -mm. This patchset breaks
out RCU implementation from its APIs to allow multiple
implementations, gives RCU its own softirq and finally
lines up preemptible RCU from -rt tree as a configurable
RCU implementation for mainline. Published earlier and
re-diffed against -mm. One major change since the last time
is that this has a new implementation of preemptible RCU
from Paul which fixes the problem with watchdog NMI.
For details - http://lkml.org/lkml/2006/10/13/259

They have been tested lightly using combinations of
dbench, kernbench and ltp (both CONFIG_CLASSIC_RCU=y and
CONFIG_RCU_PREEMPT=y) on x86_64 and ppc64. Also ran
rcutorture successfully on my x86_64 box with both
RCU implementations.

Thanks
Dipankar

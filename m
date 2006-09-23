Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWIWPa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWIWPa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWIWPa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:30:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:24240 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751227AbWIWPaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:30:25 -0400
Date: Sat, 23 Sep 2006 20:59:57 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Paul E McKenney <paulmck@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: [-mm PATCH] RCU: various patches
Message-ID: <20060923152957.GA13432@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset consists of various merge candidates that would
do well to have some testing in -mm. This patchset breaks
out RCU implementation from its APIs to allow multiple
implementations, gives RCU its own softirq and finally
lines up preemptible RCU from -rt tree as a configurable
RCU implementation for mainline. Published earlier and
re-diffed against -mm.

They have been tested lightly using combinations of
rcutorture, dbench, kernbench and ltp (both CONFIG_CLASSIC_RCU=y and 
CONFIG_RCU_PREEMPT=y) on x86 and ppc64.

Thanks
Dipankar

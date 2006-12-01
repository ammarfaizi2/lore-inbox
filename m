Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967993AbWLAAB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967993AbWLAAB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 19:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967994AbWLAAB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 19:01:26 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:50157 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S967993AbWLAABZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 19:01:25 -0500
Message-ID: <456F70C3.7010608@bigpond.net.au>
Date: Fri, 01 Dec 2006 10:01:07 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>,
       Paolo Ornati <ornati@fastwebnet.it>, Ingo Molnar <mingo@elte.hu>
Subject: [ANNOUNCE][RFC] PlugSched-6.4 for  2.6.19
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at oaamta01ps.mx.bigpond.com from [58.167.133.219] using ID pwil3058@bigpond.net.au at Fri, 1 Dec 2006 00:01:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version removes the hard/soft CPU rate caps from the SPA schedulers.

A patch for 2.6.19 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.4-for-2.6.19.patch?download>

Very Brief Documentation:

You can select a default scheduler at kernel build time.  If you wish to
boot with a scheduler other than the default it can be selected at boot
time by adding:

cpusched=<scheduler>

to the boot command line where <scheduler> is one of: ingosched,
ingo_ll, nicksched, staircase, spa_no_frills, spa_ws, spa_svr, spa_ebs
or zaphod.  If you don't change the default when you build the kernel
the default scheduler will be ingosched (which is the normal scheduler).

The scheduler in force on a running system can be determined by the
contents of:

/proc/scheduler

Control parameters for the scheduler can be read/set via files in:

/sys/cpusched/<scheduler>/

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

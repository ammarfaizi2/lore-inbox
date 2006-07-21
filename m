Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWGUDYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWGUDYq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 23:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWGUDYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 23:24:46 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:18240 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964897AbWGUDYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 23:24:46 -0400
Message-ID: <44C048FC.3040502@bigpond.net.au>
Date: Fri, 21 Jul 2006 13:24:44 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>,
       Paolo Ornati <ornati@fastwebnet.it>, Ingo Molnar <mingo@elte.hu>
Subject: [ANNOUNCE][RFC] PlugSched-6.4 for  2.6.18-rc2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 21 Jul 2006 03:24:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version removes the hard/soft CPU rate caps from the SPA schedulers.

A patch for 2.6.18-rc2 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.4-for-2.6.18-rc2.patch?download>

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

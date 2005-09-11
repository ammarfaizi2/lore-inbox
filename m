Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVIKBdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVIKBdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 21:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVIKBdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 21:33:38 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:43165 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932422AbVIKBdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 21:33:38 -0400
Message-ID: <4323896F.5050703@bigpond.net.au>
Date: Sun, 11 Sep 2005 11:33:35 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: [ANNOUNCE][RFC] PlugSched-6.1.1 for 2.6.13 and 2.6.13-mm2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 11 Sep 2005 01:33:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version contains minor code cleanups and more modifications to the 
spa_ws scheduler to improve its interactive responsiveness.  This 
modification includes control parameters for the identification of 
"media streaming" tasks.  The default values for these parameters are 
set based on observations of RealPlayer and the parameters of the video 
and audio benchmarks in Con Kolivas's interbench test and, therefore, 
may need adjusting for other programs.

A patch for 2.6.13-mm2 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.1-for-2.6.13-mm2.patch?download>

and a patch to upgrade the 6.1 for 2.6.13 to 6.1.1 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.1-to-6.1.1-for-2.6.13.patch?download>

Very Brief Documentation:

You can select a default scheduler at kernel build time.  If you wish to
boot with a scheduler other than the default it can be selected at boot
time by adding:

cpusched=<scheduler>

to the boot command line where <scheduler> is one of: ingosched,
nicksched, staircase, spa_no_frills, spa_ws or zaphod.  If you don't
change the default when you build the kernel the default scheduler will
be ingosched (which is the normal scheduler).

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

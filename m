Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264759AbTFLFyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 01:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264760AbTFLFyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 01:54:33 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:17282 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S264759AbTFLFya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 01:54:30 -0400
From: Artemio <artemio@artemio.net>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: SMP question
Date: Thu, 12 Jun 2003 08:37:40 +0300
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKMEJLDJAA.davids@webmaster.com> <200306112313.30903.artemio@artemio.net> <20030611225401.GE2712@werewolf.able.es>
In-Reply-To: <20030611225401.GE2712@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306120837.40421.artemio@artemio.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Thanks for your reply!

> > Hmmm... So, you mean uni-processor Linux kernel can't see two processors
> > as one "big" processor?
>
> No, but it will work as if it does...explain below.
>
> You have 2 processor packages, each one is HyperThreading capable. This
> means you have two 'CPUs' inside each package, so that sums up your 4 CPUs.
> But there is a flaw. The 2 'CPUs' inside each processor package are not
> full real CPUs, just two register sets that share cache, FP units, integer
> units and so on. So let's say your Xeon has 8 FP units, and you want to
> run a FPU intensive task with low or null disk IO. If you activate
> hyperthreading each of the 2 'cpus' has 4 FP units, so half the computation
> power. If you deactivate HT, you have 1 CPU with 8 FP units.
>
> In short, for FP intensive tasks, hyperthreading is a big lie...
> You can't run 2 computations in parallel.

Thanks for such in-depth explanation! 

As I understood, with HT enabled, Linux-SMP sees four CPUs with 5000 bogo mips 
each (of course I've already seen this in /proc/cpuinfo).

So, if I deactivate HT, will a UP Linux see one CPU with 4x5000=20000 bogo 
mips?

Anyway, I will try what I mentioned on that machine today.


Thank you again and good luck!


Artemio.

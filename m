Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270512AbTGSUTx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 16:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270522AbTGSUTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 16:19:53 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:5027 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270512AbTGSUTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 16:19:52 -0400
Date: Sat, 19 Jul 2003 22:32:48 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Miles Lane <miles.lane@comcast.net>
Cc: linux-kernel@vger.kernel.org, paulus@au.ibm.com, benh@kernel.crashing.org
Subject: Re: 2.6.0-test1-ac2 -- arch/ppc/platforms/pmac_cpufreq.c:179: `CPUFREQ_ALL_CPUS' undeclared  (first use in this function)
Message-ID: <20030719203248.GB731@brodo.de>
References: <200307191244.31830.miles.lane@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307191244.31830.miles.lane@comcast.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 12:44:31PM -0700, Miles Lane wrote:
>   CC      arch/ppc/platforms/pmac_cpufreq.o
> arch/ppc/platforms/pmac_cpufreq.c: In function `do_set_cpu_speed':
> arch/ppc/platforms/pmac_cpufreq.c: 179: `CPUFREQ_ALL_CPUS' undeclared (first 
> 
> use in this function)
> 
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_PROC_INTF=y
> CONFIG_CPU_FREQ_24_API=y
> CONFIG_CPU_FREQ_PMAC=y

Intermediate fix [replace CPUFREQ_ALL_CPUS with either 0 or
smp_processor_id() ] for this is already in Linus' tree, important update
for the pmac-cpufreq driver is in benh's tree and will hopefully be pushed
to Linus tree soon.

	Dominik

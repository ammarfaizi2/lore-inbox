Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbUCRXAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbUCRXAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:00:05 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:9982 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263085AbUCRW77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 17:59:59 -0500
Message-ID: <405A29EA.6000400@mvista.com>
Date: Thu, 18 Mar 2004 14:59:54 -0800
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Andrew Morton <akpm@osdl.org>, Kenneth Chen <kenneth.w.chen@intel.com>,
       linux-ia64@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       CPU Freq ML <cpufreq@www.linux.org.uk>
Subject: Re: add lowpower_idle sysctl
References: <20040317170436.430acfbe.akpm@osdl.org>	<200403180318.i2I3IDF03166@unix-os.sc.intel.com>	<20040317192821.1fe90f24.akpm@osdl.org> <Pine.LNX.4.58.0403172237470.28447@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403172237470.28447@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>>Set some system-wide integer via a sysctl and let the particular
>>architecture decide how best to implement the currently-selected idle mode?
> 
> I'm wondering whether the setting of these magic numbers can't be done
> using cpufreq infrastructure.

I'd vote for using Patrick Mochel's PM subsystem and use a standard set 
of identifiers that are mapped to a platform-specific idle behavior, in 
much the same way as platform suspend modes are handled today.  For 
example, strings echoed to /sys/power/idle could be an interface.  If 
folks are amenable to this I'd be happy to supply a (generic) patch for it.

-- 
Todd Poynor
MontaVista Software


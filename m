Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161177AbWFVSgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbWFVSgO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWFVSgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:36:14 -0400
Received: from [80.96.155.2] ([80.96.155.2]:33217 "EHLO aladin.ro")
	by vger.kernel.org with ESMTP id S1161176AbWFVSgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:36:12 -0400
Message-ID: <449B0DC0.8070203@aladin.ro>
Date: Thu, 22 Jun 2006 21:38:08 +0000
From: Eduard-Gabriel Munteanu <maxdamage@aladin.ro>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CPUFreq ability to overclock
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*This message was transferred with a trial version of CommuniGate(r) Pro*
I'm thinking to implement a way to have CPUFreq's maximum FSB increased 
to allow overclocking. Having that done, it should make sense to have a 
governor (userspace maybe, with a 3rd-party tool) thermal-throttle the 
CPU. There is one slight problem: can we control Vcore from within the 
kernel, on-the-fly, without rebooting? I've seen a comment about scaling 
voltages in cpufreq.c, but it seems there is no actual support for that.

My idea is to make cpufreq_policy.max (same for cpufreq_cpuinfo's 
member) a soft limit (to prevent unwanted overclocking from usual 
governors) and have another member hold the hard limit. Chipset drivers 
should calculate the hard limit based on installed processor or 
boot-time FSB.

I'm looking forward to comments and suggestions.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWCTTYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWCTTYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbWCTTYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:24:30 -0500
Received: from main.gmane.org ([80.91.229.2]:1430 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965187AbWCTTY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:24:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Wes Felter <wesley@felter.org>
Subject: Re: Dual Core on Linux questions
Date: Mon, 20 Mar 2006 13:23:32 -0600
Message-ID: <dvmvge$v43$1@sea.gmane.org>
References: <20060318082434.M33432@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pixpat.austin.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
In-Reply-To: <20060318082434.M33432@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla wrote:
> Hi,
> 
> I have a few questions about the PM Dual Core and how could it really work
> with Linux. Sorry if there are new patches on LKML about any of these things:
> 
> Could each processor or die, have it's own cpufreq scaling governor?
> 
> Is there a way to allow one die to be idle and let the other one normal?
> 
> So in other words, could we manage these processors speedstep, utilization and
> workload individually?

This depends on your hardware. I was reading the Sossaman data sheet the 
other day, and it says that the entire chip must run at the same 
frequency. You can set each core to a different frequency, but the 
hardware chooses the higher of the two. Likewise, the entire chip can 
sleep, but individual cores can only go into C1. I imagine the Core Duo 
is the same.

IIRC, the dual-core Opterons behave a little differently but the two 
cores still have to run at the same frequency.

Wes Felter - wesley@felter.org


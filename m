Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWGMNkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWGMNkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWGMNkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:40:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16836 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750881AbWGMNkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:40:08 -0400
Message-ID: <44B64CAD.5080804@redhat.com>
Date: Thu, 13 Jul 2006 09:37:49 -0400
From: Bhavana Nagendra <bnagendr@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: [discuss] Re: [PATCH] Allow all Opteron processors to change
 pstate at same time
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some results without changing frequencies on a system whose 
BIOS does not support Power Now! on MP systems:

Basically the system booted up with "nohpet, nopmtimer"i.e. using TSC as 
the GTOD time source and system stayed idle for 13 hours.   There 
appears to be drift of 20 secs in the CPU 2 readings.    This TSC drift 
will be worse when
the system is active and doing GTOD operations.

CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -108 cycles, maxerr 826 
cycles)
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -119 cycles, maxerr 845 
cycles)

*** CPUs go offline ***

*** back online ***

CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -117 cycles, maxerr 846 
cycles)
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -117 cycles, maxerr 845 
cycles)

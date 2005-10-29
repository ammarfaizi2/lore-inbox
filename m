Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbVJ2CfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVJ2CfG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 22:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVJ2CfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 22:35:06 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:23434 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751099AbVJ2CfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 22:35:04 -0400
Message-ID: <4362DFD5.2000709@bigpond.net.au>
Date: Sat, 29 Oct 2005 12:35:01 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.1.3 for 2.6.13 and 2.6.14-rc4
References: <434F01EA.6060709@bigpond.net.au>
In-Reply-To: <434F01EA.6060709@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 29 Oct 2005 02:35:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> This version contains a new scheduler, spa_svr, which is a minor 
> extension of spa_no_frills intended for use on servers.  It makes no 
> attempt to improve interactive responsiveness but includes a simplified 
> version of the throughput bonus mechanism found in Zaphod.  This 
> mechanism attempts to minimize the time tasks spend on run queues 
> waiting for CPU access when the system is moderately loaded by giving 
> tasks temporary priority bonuses based on the relationship between the 
> recent average time spent on run queues and on a cpu per cycle. 
> (Although it's effectiveness tends to disappear when the system is fully 
> loaded, it is still useful as considerable delay can be seen on systems 
> with quite low average loads due to lack of serendipity.)
> 
> A patch for 2.6.14-rc4 is available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.3-for-2.6.14-rc4.patch?download> 
> 
> 
> and a patch to upgrade the 6.1.2 version for 2.6.13 to 6.1.3 is
> available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.2-to-6.1.3-for-2.6.13.patch?download> 
> 
> 
> Very Brief Documentation:
> 
> You can select a default scheduler at kernel build time.  If you wish to
> boot with a scheduler other than the default it can be selected at boot
> time by adding:
> 
> cpusched=<scheduler>
> 
> to the boot command line where <scheduler> is one of: ingosched,
> nicksched, staircase, spa_no_frills, spa_ws, spa_svr or zaphod.  If you 
> don't change the default when you build the kernel the default scheduler 
> will be ingosched (which is the normal scheduler).
> 
> The scheduler in force on a running system can be determined by the
> contents of:
> 
> /proc/scheduler
> 
> Control parameters for the scheduler can be read/set via files in:
> 
> /sys/cpusched/<scheduler>/
> 
> Peter

A patch for the 2.6.14 official release kernel is now available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.3-for-2.6.14.patch?download>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

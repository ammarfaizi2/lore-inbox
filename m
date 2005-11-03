Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbVKCUtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbVKCUtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 15:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbVKCUtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 15:49:22 -0500
Received: from fmr22.intel.com ([143.183.121.14]:52642 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030474AbVKCUtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 15:49:22 -0500
Date: Thu, 3 Nov 2005 12:49:16 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: ashok.raj@intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: powernow-k8 schedules in atomic since sunday :-(
Message-ID: <20051103124916.A29900@unix-os.sc.intel.com>
References: <436A34C5.2060108@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <436A34C5.2060108@vc.cvut.cz>; from vandrove@vc.cvut.cz on Thu, Nov 03, 2005 at 05:03:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 05:03:17PM +0100, Petr Vandrovec wrote:
> Hello Ashok,
>    your change '[PATCH] create and destroy cpufreq sysfs entries based on cpu 
> notifiers' causes problems with powernow-k8 driver.  powernow-k8 uses 
> set_cpus_allowed() (it even calls schedule() explicitly for no reason), and when 
> you've changed code from lock_cpu_hotplug() to preempt_disable() 
> set_cpus_allowed() now complains that schedule() is not allowed while preemption 
> is disabled...
> 

Rafael noticed this, please use the new patch 

http://marc.theaimsgroup.com/?l=linux-kernel&m=113087258615780&w=2

He confirmed it works for him now.

Thanks
ashok

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWKBRX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWKBRX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWKBRX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:23:59 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:62120 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750807AbWKBRX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:23:58 -0500
Date: Thu, 2 Nov 2006 09:19:42 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, ashok.raj@intel.com
Subject: Re: [PATHC] doc: fixing cpu-hotplug document
Message-Id: <20061102091942.2654ffae.randy.dunlap@oracle.com>
In-Reply-To: <87lkmuuhxb.wl%takeuchi_satoru@jp.fujitsu.com>
References: <87lkmuuhxb.wl%takeuchi_satoru@jp.fujitsu.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2006 21:55:28 +0900 Satoru Takeuchi wrote:

> Fixing cpu-hotplug document as follows:
> 
>  - `cpucontrol' mutex no longer exists and now `cpu_bitmask_lock' is used instead.
>  - unifying the notation of CPU to `CPU' in the document
>  - decolating captions to improve readability
>  - fixing some minor typos

Good cleanup.  Thanks.
I have a few minor fixes below.


> Index: linux-2.6.19-rc4/Documentation/cpu-hotplug.txt
> ===================================================================
> --- linux-2.6.19-rc4.orig/Documentation/cpu-hotplug.txt	2006-10-31 12:37:36.000000000 +0900
> +++ linux-2.6.19-rc4/Documentation/cpu-hotplug.txt	2006-11-02 21:22:15.000000000 +0900
> @@ -83,8 +87,8 @@ upfront can save some boot time memory. 
>  in x86_64 case to keep this under check.
>  
>  cpu_online_map: Bitmap of all CPUs currently online. Its set in __cpu_up()
> -after a cpu is available for kernel scheduling and ready to receive
> -interrupts from devices. Its cleared when a cpu is brought down using
> +after a CPU is available for kernel scheduling and ready to receive
> +interrupts from devices. Its cleared when a CPU is brought down using

s/Its/It is/ (or It's)

>  __cpu_disable(), before which all OS services including interrupts are
>  migrated to another target CPU.
>  
> @@ -95,8 +99,8 @@ from the map depending on the event is h
>  no locking rules as of now. Typical usage is to init topology during boot,
>  at which time hotplug is disabled.
>  
> -You really dont need to manipulate any of the system cpu maps. They should
> -be read-only for most use. When setting up per-cpu resources almost always use
> +You really dont need to manipulate any of the system CPU maps. They should

s/dont/don't/

> +be read-only for most use. When setting up per-CPU resources almost always use
>  cpu_possible_map/for_each_possible_cpu() to iterate.
>  
>  Never use anything other than cpumask_t to represent bitmap of CPUs.
> @@ -188,21 +194,21 @@ Once the logical offline is successful, 
>  	#cat /proc/interrupts
>  
>  You should now not see the CPU that you removed. Also online file will report
> -the state as 0 when a cpu if offline and 1 when its online.
> +the state as 0 when a CPU is offline and 1 when its online.

s/its/it's/

> @@ -284,7 +290,7 @@ A: Yes, CPU notifiers are called only wh
>  		foobar_cpu_callback(&foobar_cpu_notifier, CPU_ONLINE, i);
>  	}
>  
> -Q: If i would like to develop cpu hotplug support for a new architecture,
> +Q: If i would like to develop CPU hotplug support for a new architecture,

s/ i / I /

>     what do i need at a minimum?

---
~Randy

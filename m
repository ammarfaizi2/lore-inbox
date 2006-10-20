Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946766AbWJTBBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946766AbWJTBBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 21:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946773AbWJTBBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 21:01:47 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:33686 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946766AbWJTBBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 21:01:46 -0400
Subject: Re: 2.6.18-rt6
From: john stultz <johnstul@us.ibm.com>
To: sergio@sergiomb.no-ip.org
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <1161303812.3020.15.camel@localhost.portugal>
References: <20061018083921.GA10993@elte.hu>
	 <1161303812.3020.15.camel@localhost.portugal>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 17:59:58 -0700
Message-Id: <1161305999.6961.142.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-20 at 01:23 +0100, Sergio Monteiro Basto wrote:
> I just test rt6 it in my problematic VIA Board with one PENTIUM D (DUAL)
> 
> 1. don't apply cleaning to 2.16.18.1 (on sparc arch )
> 2. I usual boot with notsc (because without it give me many lost time
> tickets)
>     I try 2.16.18.1-rt6 without notsc and freeze on boot. 
>     I try with notsc and says 
>         Time: acpi_pm clocksource has been installed.
>         Looks stable and don't show any lost timer ticket on dmesg.

Out of curiosity, does 2.6.18.1 require notsc (or booting w/
clocksource=acpi_pm) to be stable? Or is it just -rt6 that has this
problem?

> But I want also work with Nvidia dri which is a close drive from NVIDIA.
> I install that drive and I enable DRI, After a few minutes I got a
> spontaneous reboot.
> I will keep testing without nvidia close source.
> 
> And I like to know if this rt6 patch make this new clocksource (acpi_pm)
> or just found it and use it ? 

-rt6 includes a patch from Thomas Gleixner that disables the TSC if
dynticks are enabled in your config.

thanks
-john



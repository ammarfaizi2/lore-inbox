Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVHYBjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVHYBjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 21:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVHYBjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 21:39:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:2035 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932478AbVHYBjG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 21:39:06 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124932391.5527.15.camel@localhost.localdomain>
References: <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
	 <1124323379.5186.18.camel@localhost.localdomain>
	 <1124333050.5186.24.camel@localhost.localdomain>
	 <20050822075012.GB19386@elte.hu>
	 <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124749192.17515.16.camel@dhcp153.mvista.com>
	 <1124756775.5350.14.camel@localhost.localdomain>
	 <1124758291.9158.17.camel@dhcp153.mvista.com>
	 <1124760725.5350.47.camel@localhost.localdomain>
	 <1124768282.5350.69.camel@localhost.localdomain>
	 <1124908080.5604.22.camel@localhost.localdomain>
	 <1124917003.5711.8.camel@localhost.localdomain>
	 <1124932391.5527.15.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 24 Aug 2005 18:38:45 -0700
Message-Id: <1124933925.17712.31.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 21:13 -0400, Steven Rostedt wrote:
> Well, after turning off hrtimers, I keep getting one bug. A possible
> soft lockup with the ext3 code. But this didn't seem to be caused by the
> changes I made. So just to be sure, I ran my test on the vanilla
> 2.6.13-rc6-rt11 and it gave the same bug too.  So, it looks like my
> changes are now at par with what is out there with the rt11 release.
> They both give the same bug! ;-)
> 
> Attached is the test I ran. I did a 
> 
> while : ; do ./test3a_rt ; done
> 
> Where test3a_rt is a C program that does adding, deleting and reading of
> files, by different tasks that are each at a different priority.  Here's
> the soft lockup I'm getting:

I got a report of a possible softlockup with setiathome, the trace
wasn't a little garbled though . I'm not sure the checking is working
correctly . But if it is maybe these spot need some performance
analysis . Didn't you changes catch anything that stays in the kernel
for 10 seconds or more ?

Daniel


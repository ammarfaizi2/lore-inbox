Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbWGJOl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbWGJOl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWGJOl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:41:27 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:48700 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161166AbWGJOl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:41:27 -0400
Subject: Re: tasklet_unlock_wait() causes soft lockup with -rt and ieee1394
	audio
From: Daniel Walker <dwalker@mvista.com>
To: Pieter Palmers <pieterp@joow.be>
Cc: Lee Revell <rlrevell@joe-job.com>, Steven Rostedt <rostedt@goodmis.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <44B0E5E4.2090902@joow.be>
References: <1152371924.4736.169.camel@mindpipe>
	 <1152409894.32734.27.camel@localhost.localdomain>
	 <1152411169.28129.24.camel@mindpipe>  <44B0E5E4.2090902@joow.be>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 07:41:23 -0700
Message-Id: <1152542483.19929.11.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 13:17 +0200, Pieter Palmers wrote:
> > 
> > I am just posting this for Pieter - all followups should be directed to
> > him.  (I don't even have the hardware to reproduce this)
> > 
> > IIRC the problem could only be reproduced with PREEMPT_RT.  Pieter, can
> > you confirm?
> 
> It can only be reproduced with PREEMPT_RT. And the test kernel is 
> configured with irq threading, I haven't tried it without irq threading.

It's another one of those situations when a userspace real time process
gets stuck in a tight loop waiting for a bit to change. It's similar to
the issue with bit spinlocks, or yield. 

You should be able to reproduce it without PREEMPT_RT but SMP only .

Daniel


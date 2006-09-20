Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWITSeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWITSeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWITSeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:34:09 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:21839 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932225AbWITSeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:34:04 -0400
Subject: Re: 2.6.18-rt1
From: Daniel Walker <dwalker@mvista.com>
To: paulmck@us.ibm.com
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060920182553.GC1292@us.ibm.com>
References: <20060920141907.GA30765@elte.hu>
	 <200609201250.03750.gene.heskett@verizon.net>
	 <1158771639.29177.5.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20060920173858.GB1292@us.ibm.com>
	 <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20060920182553.GC1292@us.ibm.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 11:34:00 -0700
Message-Id: <1158777240.29177.16.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 11:25 -0700, Paul E. McKenney wrote:

> OK, using that instead.
> 
> I get the following at startup, which probably means that I need to use
> some machine other than a NUMA-Q.  Trying a different machine...
> 
> 						Thanx, Paul
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
>  printing eip:
> c01151ff
> *pde = 34d21001
> *pte = 00000000
> stopped custom tracer.
> Oops: 0000 [#1]
> PREEMPT SMP 
> Modules linked in:
> CPU:    2
> EIP:    0060:[<c01151ff>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.18-rt2-autokern1 #1) 
> EIP is at __wake_up_common+0x10/0x55

I get this too, it happens when HRT is off.. If you turn HRT on it will
boot .. I haven't found a fix for it, but I imagine Thomas will find it
soon.

Daniel


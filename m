Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWITUbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWITUbh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWITUbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:31:37 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:20931 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750823AbWITUbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:31:36 -0400
Subject: Re: 2.6.18-rt1
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060920201450.GA22482@elte.hu>
References: <20060920141907.GA30765@elte.hu>
	 <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20060920182553.GC1292@us.ibm.com>
	 <200609201436.47042.gene.heskett@verizon.net>
	 <20060920194650.GA21037@elte.hu>
	 <1158783590.29177.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20060920201450.GA22482@elte.hu>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 13:31:06 -0700
Message-Id: <1158784266.29177.21.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 22:14 +0200, Ingo Molnar wrote:
> >         if (up->port.sysrq) {
> >                 /* serial8250_handle_port() already took the lock */
> >                 locked = 0;


In this case it had interrupts off in the !PREEMPT_RT case, but your
change leaves them on here.. _irqsave only runs in two of the three
cases..

Daniel 


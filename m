Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWGYSCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWGYSCB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWGYSCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:02:01 -0400
Received: from alnrmhc14.comcast.net ([204.127.225.94]:2704 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751460AbWGYSCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:02:00 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Neil Horman <nhorman@tuxdriver.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org,
       Keith Packard <keithp@keithp.com>
In-Reply-To: <1153850139.8932.40.camel@laptopd505.fenrus.org>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	 <1153850139.8932.40.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: OLPC
Date: Tue, 25 Jul 2006 14:01:54 -0400
Message-Id: <1153850514.5872.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 19:55 +0200, Arjan van de Ven wrote:
> > @@ -265,6 +269,7 @@ irqreturn_t rtc_interrupt(int irq, void 
> >  
> >  	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
> >  
> > +	*count_ptr = (*count_ptr)++;
> 
> Hi,
> 
> it's a cute idea, however 3 questions:
> 1) you probably want to add a few memory barriers around this, right?
> 2) why use the rtc and not the regular timer interrupt?
> 
> (and 
> 3) this will negate the power gain you get for tickless kernels, since
> now they need to start ticking again ;( )

The field only needs to get updated if you've scheduled something to
run...
                            - Jim

> 
> Greetings,
>    Arjan van de Ven
> 
-- 
Jim Gettys
One Laptop Per Child



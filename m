Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264882AbSJVSNG>; Tue, 22 Oct 2002 14:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSJVSMK>; Tue, 22 Oct 2002 14:12:10 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:4879
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264859AbSJVSKk>; Tue, 22 Oct 2002 14:10:40 -0400
Subject: Re: [PATCH] NMI request/release
From: Robert Love <rml@tech9.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3DB59431.2090807@mvista.com>
References: <3DB4AABF.9020400@mvista.com>	<20021022021005.GA39792@compsoc.man.ac.uk>
	<3DB4B8A7.5060807@mvista.com>	<20021022025346.GC41678@compsoc.man.ac.uk> 
	<3DB54C53.9010603@mvista.com> <1035307430.1008.1476.camel@phantasy> 
	<3DB59431.2090807@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 14:16:21 -0400
Message-Id: <1035310581.3171.1485.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 14:08, Corey Minyard wrote:

> In 2.5.44, stock from kernel.org, rcu_process_callbacks() calls 
> local_irq_disable().  Is that just preemption disabling, now?

No, but rcu_process_callbacks() is for the copy update part.

Look at rcu_read_lock() and rcu_read_unlock()... those are the read
paths.

Of course, I can be very wrong about some of this, RCU grosses^Wconfuses
me.  But the read paths do just seem to call rcu_read_lock/unlock which
just do a preempt_disable/enable.  Otherwise the read path is entirely
transparent.

	Robert Love


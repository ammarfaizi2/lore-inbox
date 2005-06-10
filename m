Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFJUWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFJUWr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVFJUWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:22:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65275 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261207AbVFJUWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:22:45 -0400
Subject: Re: Attempted summary of "RT patch acceptance" thread
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
In-Reply-To: <20050610173728.GA6564@g5.random>
References: <20050608022646.GA3158@us.ibm.com>
	 <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com>
	 <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com>
	 <20050610173728.GA6564@g5.random>
Content-Type: text/plain
Organization: MontaVista
Date: Fri, 10 Jun 2005 13:22:37 -0700
Message-Id: <1118434957.27756.5.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 19:37 +0200, Andrea Arcangeli wrote:

> 
> preempt-RT _can_ do something about it but only _if_ people hacks the
> drivers properly and makes sure to call local_irq_save_nort instead of
> local_irq_save and other explicit changes like that, things that if
> missing are noticeable only during measurements with preempt-RT config
> option enabled (hence the metal-hard classification of preempt-RT and
> not ruby-hard definition).


This is no longer an issue. We did an interrupt disable conversion so
now there is only a few places that actually disable interrupts. It
hasn't been tested fully, but you should be able to used whatever
drivers you want and still get the same interrupt latency. However,
preempt latency is still and issue for these drivers.

Daniel


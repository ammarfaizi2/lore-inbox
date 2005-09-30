Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbVI3OR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbVI3OR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbVI3OR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:17:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31733 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1030312AbVI3ORz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:17:55 -0400
Subject: Re: [PATCH] RT: update rcurefs for RT
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050930083440.GA20905@elte.hu>
References: <1127845926.4004.22.camel@dhcp153.mvista.com>
	 <20050929114235.GA638@elte.hu>
	 <1128007259.11511.4.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1128041750.15115.367.camel@tglx.tec.linutronix.de>
	 <20050930083440.GA20905@elte.hu>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 07:17:52 -0700
Message-Id: <1128089872.12850.2.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 10:34 +0200, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Thu, 2005-09-29 at 08:20 -0700, Daniel Walker wrote:
> > > +static inline void init_rcurefs(void)
> > > +{
> > > +	int i;
> > > +	for (i=0; i < RCUREF_HASH_SIZE; i++) 
> > > +		__rcuref_hash[i] = SPIN_LOCK_UNLOCKED(__rcuref_hash[i]);
> > 
> > Maybe a simple 
> > 
> > 	spin_lock_init(&__rcuref_hash[i]);
> > 
> > would work all over the place ?
> 
> yep.

The patch isn't needed if you accept Nick's cmpxchg() patches ..

Daniel


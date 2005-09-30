Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbVI3IeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVI3IeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 04:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVI3IeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 04:34:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:24809 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932558AbVI3IeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 04:34:14 -0400
Date: Fri, 30 Sep 2005 10:34:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: update rcurefs for RT
Message-ID: <20050930083440.GA20905@elte.hu>
References: <1127845926.4004.22.camel@dhcp153.mvista.com> <20050929114235.GA638@elte.hu> <1128007259.11511.4.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1128041750.15115.367.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128041750.15115.367.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 2005-09-29 at 08:20 -0700, Daniel Walker wrote:
> > +static inline void init_rcurefs(void)
> > +{
> > +	int i;
> > +	for (i=0; i < RCUREF_HASH_SIZE; i++) 
> > +		__rcuref_hash[i] = SPIN_LOCK_UNLOCKED(__rcuref_hash[i]);
> 
> Maybe a simple 
> 
> 	spin_lock_init(&__rcuref_hash[i]);
> 
> would work all over the place ?

yep.

	Ingo

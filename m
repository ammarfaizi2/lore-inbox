Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVLNQSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVLNQSB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVLNQSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:18:01 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:59120 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964808AbVLNQSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:18:00 -0500
Subject: Re: [PATCH -RT] Add softirq waitqueue for CONFIG_PREEMPT_SOFTIRQ
	(was: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 ...)
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1134575022.18921.56.camel@localhost.localdomain>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
	 <1134507927.18921.26.camel@localhost.localdomain>
	 <20051214084019.GA18708@elte.hu>  <20051214084333.GA20284@elte.hu>
	 <1134568080.18921.42.camel@localhost.localdomain>
	 <1134568867.4275.7.camel@tglx.tec.linutronix.de>
	 <1134575022.18921.56.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 08:17:57 -0800
Message-Id: <1134577078.27681.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 10:43 -0500, Steven Rostedt wrote:

> I really would like to add priority inheritance to waitqueues, so things
> like this can benefit from PI as well.
> 

I submitted a generic PI patch a while back, but the design was not that
great. It had callback functions for getting the lock owner , and for
signaling when changing priorities .. 

Here it is,
http://lkml.org/lkml/2005/5/31/288

I think it may be pretty trivial to add priority sorted waitqueues by
just adding a plist .

Daniel


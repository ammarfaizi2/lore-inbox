Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWEOQ1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWEOQ1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWEOQ1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:27:36 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:27729 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932431AbWEOQ1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:27:35 -0400
Subject: Re: sched: 64-bit nr_running
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, rostedt@goodmis.org
In-Reply-To: <20060515162526.GA16095@elte.hu>
References: <1147707081.15392.66.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <20060515162526.GA16095@elte.hu>
Content-Type: text/plain
Date: Mon, 15 May 2006 09:27:25 -0700
Message-Id: <1147710445.15392.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 18:25 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > There was a conversation over the mtd redboot bug related to unsigned 
> > long vs. unsigned int . On a 64-bit machine unsigned long is 64-bits , 
> > and unsigned int is 32-bits . However, both are 32-bits on a 32-bit 
> > machine .
> > 
> > Looking over the scheduler I found a few places that use "unsigned 
> > long" for task counting variables (nr_running, nr_active, 
> > nr_interruptible) . The problem is that these variables are all bound 
> > to 29 bits (according to kernel/pid.c) , but they get expanded to 
> > 64-bits on 64-bit machines .
> 
> your point being?


We could make them unsigned int, and save the extra bits .. Or that's
what I was thinking about ..

Daniel


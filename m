Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWEOQZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWEOQZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWEOQZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:25:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:17375 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932208AbWEOQZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:25:39 -0400
Date: Mon, 15 May 2006 18:25:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, rostedt@goodmis.org
Subject: Re: sched: 64-bit nr_running
Message-ID: <20060515162526.GA16095@elte.hu>
References: <1147707081.15392.66.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147707081.15392.66.camel@c-67-180-134-207.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> There was a conversation over the mtd redboot bug related to unsigned 
> long vs. unsigned int . On a 64-bit machine unsigned long is 64-bits , 
> and unsigned int is 32-bits . However, both are 32-bits on a 32-bit 
> machine .
> 
> Looking over the scheduler I found a few places that use "unsigned 
> long" for task counting variables (nr_running, nr_active, 
> nr_interruptible) . The problem is that these variables are all bound 
> to 29 bits (according to kernel/pid.c) , but they get expanded to 
> 64-bits on 64-bit machines .

your point being?

	Ingo

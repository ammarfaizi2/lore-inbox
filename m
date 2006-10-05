Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWJEUOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWJEUOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWJEUOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:14:16 -0400
Received: from www.osadl.org ([213.239.205.134]:37772 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751200AbWJEUOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:14:14 -0400
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
	passing to IRQ handlers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <20061005124601.94ed7194.akpm@osdl.org>
References: <20061002132116.2663d7a3.akpm@osdl.org>
	 <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <18975.1160058127@warthog.cambridge.redhat.com>
	 <20061005124601.94ed7194.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 22:19:08 +0200
Message-Id: <1160079548.9060.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 12:46 -0700, Andrew Morton wrote:
> A quick survey of the wreckage:
> 
> - Dmitry's input git tree breaks a bit
> 
> - five of Greg's USB patches need fixing
> 
> - a few random -mm patches need touchups
> 
> - The hrtimer+dynticks i386 patch takes rather a hit and will need redoing.

Nothing to worry about. In fact it makes life easier. I have to store
the regs now in hrtimer_cpu_base to make them available to the
sched_tick hrtimer callback.

Push it in. 

	tglx



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWB1IfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWB1IfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 03:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWB1IfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 03:35:15 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:59543
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932069AbWB1IfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 03:35:13 -0500
Subject: Re: + fix-next_timer_interrupt-for-hrtimer.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tony Lindgren <tony@atomide.com>
Cc: akpm@osdl.org, heiko.carstens@de.ibm.com, johnstul@us.ibm.com,
       rmk@arm.linux.org.uk, schwidefsky@de.ibm.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060225185731.GA4294@atomide.com>
References: <200602250219.k1P2JLqY018864@shell0.pdx.osdl.net>
	 <1140884243.5237.104.camel@localhost.localdomain>
	 <20060225185731.GA4294@atomide.com>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 09:36:46 +0100
Message-Id: <1141115806.5237.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 10:57 -0800, Tony Lindgren wrote:
> > This is racy on SMP. nanosleep hrtimers are on the stack and can go away
> > due to a signal. posix timers can be removed and destroyed on another
> > CPU.
> 
> This should be fixed. But just as a note, we can tolerate some removed
> timer values values as it would be just an extra timer interrupt.

The problem is not the removed timer. Its the reference to a destroyed
object you hold.
 
	tglx




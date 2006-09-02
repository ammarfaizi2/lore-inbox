Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWIBSkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWIBSkn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 14:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWIBSkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 14:40:43 -0400
Received: from www.osadl.org ([213.239.205.134]:19942 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751270AbWIBSkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 14:40:42 -0400
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Frank v Waveren <fvw@var.cx>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060902110445.GC3335@var.cx>
References: <1156927468.29250.113.camel@localhost.localdomain>
	 <20060831204612.73ed7f33.akpm@osdl.org>  <20060902110445.GC3335@var.cx>
Content-Type: text/plain
Date: Sat, 02 Sep 2006 20:44:39 +0200
Message-Id: <1157222679.29250.386.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-02 at 13:04 +0200, Frank v Waveren wrote:
> Here's a different patch, which should actually sleep for the
> specified amount of time up to 2^64 seconds with a loop around the
> sleeps and a tally of how long is left to sleep. It does mean we wake
> up once every 300 years on long sleeps, but that shouldn't cause any
> huge performance problems.

Which non academic problem is solved by this patch ?

	tglx



-- 
VGER BF report: U 0.491521

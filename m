Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWIJNjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWIJNjR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWIJNjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:39:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:32222 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932160AbWIJNjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:39:17 -0400
From: Andi Kleen <ak@suse.de>
To: "Dong Feng" <middle.fengdong@gmail.com>
Subject: Re: Timer Selection
Date: Sun, 10 Sep 2006 15:51:11 +0200
User-Agent: KMail/1.9.1
Cc: "Jeremy Fitzhardinge" <jeremy@goop.org>, linux-kernel@vger.kernel.org
References: <a2ebde260609100334v65bf5e4fx754e3b00576bfb9f@mail.gmail.com>
In-Reply-To: <a2ebde260609100334v65bf5e4fx754e3b00576bfb9f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101551.11521.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 September 2006 12:34, Dong Feng wrote:
> In i386 architecture, there are five timers as candidates in the selection
> of "cur_timer." I feel among the five only two types can be used as Kernel
> base timer, HPET and PIT. Kernel base timer is the timer trigger
> timer_interrupt() periodically. Namely, the timer installed on IRQ 0 in
> i386 architecture.
>
> Is the above understanding correct? Particularly I want to confirm which
> timers can be used as Kernel base timer.

Only HPET and PIT can be interrupt 0 in the PC architecture
(HPET only if the legacy option is available), but there is no reason 
the main timer handler cannot be driven from another interval timer (e.g. 
x86-64 offers the APIC timer as a option for this)

-Andi

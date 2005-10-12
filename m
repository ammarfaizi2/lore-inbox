Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVJLGjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVJLGjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 02:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVJLGjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 02:39:49 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:65153 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932352AbVJLGjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 02:39:48 -0400
Date: Wed, 12 Oct 2005 02:33:03 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       dwalker@mvista.com, david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rc4-rt1
In-Reply-To: <20051012061455.GA16586@elte.hu>
Message-ID: <Pine.LNX.4.58.0510120230001.5830@localhost.localdomain>
References: <20051011111454.GA15504@elte.hu> <1129064151.5324.6.camel@cmn3.stanford.edu>
 <20051012061455.GA16586@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Oct 2005, Ingo Molnar wrote:

>
> i'm not sure latency traces will uncover anything useful for this bug.
> Your problems could be timer issues: timers going off too fast cause
> high keyboard repeat rates, and the same goes for the screensaver. Does
> 'sleep 1' work as expected, or is that timing out in an "accelerated"
> way too?
>

I usually recommend doing a 'sleep 10'.  It really shows you if things are
wrong.  If a sleep 1 returns 2 seconds, or 0.5 seconds later it may not be
detected.  But a sleep 10 returning 20 seconds or 5 seconds later is
obvious.

Just my 20 cents (inflation - and like my comment I multiplied by 10 ;-)

-- Steve


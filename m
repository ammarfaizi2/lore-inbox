Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWGMOll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWGMOll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWGMOll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:41:41 -0400
Received: from h155.mvista.com ([63.81.120.158]:98 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751551AbWGMOlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:41:40 -0400
Subject: Re: [PATCH] 2.6.17-rt add clockevent to ixp4xx
From: Daniel Walker <dwalker@mvista.com>
To: Milan Svoboda <msvoboda@ra.rockwell.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
In-Reply-To: <44B62624.30908@ra.rockwell.com>
References: <44B62624.30908@ra.rockwell.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 07:41:37 -0700
Message-Id: <1152801697.22049.7.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 10:53 +0000, Milan Svoboda wrote:
> Hello,
> 
> there are patches that enable clock event on ixp4xx platform. This should
> enable high resolution timers... Option for hrtimers in menuconfig is 
> also enabled.
> 
> I tested it on nanosleep test program (included in attachments) and obtained
> this results:
> 
> requested: 899000 us, got: 899159 us, diff: -159 us
> requested: 897000 us, got: 897209 us, diff: -209 us
> requested: 895000 us, got: 899803 us, diff: -4803 us
> requested: 893000 us, got: 899425 us, diff: -6425 us
> requested: 891000 us, got: 899806 us, diff: -8806 us
> requested: 889000 us, got: 890142 us, diff: -1142 us
> requested: 887000 us, got: 889873 us, diff: -2873 us
> requested: 885000 us, got: 888096 us, diff: -3096 us

I'd turn off some of the debugging options, and retest. For instance,
the pi-list debugging option will cause arbitrary latency, which you
seem to show in your results. Normally with PREEMPT_RT turned on you
would expect the timers to trigger within a constant amount of time from
when they are suppose to.

Daniel


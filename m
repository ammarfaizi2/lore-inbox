Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266068AbUAVQG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 11:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266272AbUAVQG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 11:06:58 -0500
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:5165
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S266068AbUAVQGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 11:06:55 -0500
Subject: Re: TG3: very high CPU usage
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Lincoln Dale <ltd@cisco.com>
Cc: JG <jg@cms.ac>, Andreas Hartmann <andihartmann@freenet.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
References: <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	 <20040119033527.GA11493@linux.comp> <20040119033527.GA11493@linux.comp>
	 <5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	 <5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
Content-Type: text/plain
Message-Id: <1074787587.5691.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 22 Jan 2004 11:06:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 22:57, Lincoln Dale wrote:
> At 02:19 PM 21/01/2004, Tom Sightler wrote:
> >I'm curious is the people seeing this problem happen to have preempt
> >enabled in their config.  I've noticed that my laptop, which also
> >happens to have a tg3 based 10/100/1000 card, uses tons of CPU during
> >trasfers, but only when preempt is enabled.
> 
> nope.
> i didn't use PREEMPT=y in my previous test, but i have just done so now.
> 
> the difference in CPU utilization when pushing wire-rate gig-e ttcp on this 
> system (Dual P4 Xeon) with PREEMPT=y or PREEMPT=n is just noise.
> 
> you should run oprofile and see where your cpu time is spent.

Well, it was just a tought.  As it turns out in my case it seems the
problem was related to ACPI and PREEMPT (I still don't understand what
exactly).  Everything seems normal with ACPI without PREEMPT, or without
ACPI with PREEMPT, but if I enable both ACPI and PREEMPT I get a ton of
CPU usage.  In Fedora Core top it shows up as IRQ time.

I haven't run oprofile yet but it seems this problem is something to do
with ACPI and PREEMPT on my machine (perhaps something to do with IRQ
routing when ACPI is enabled).  Sounds like that doesn't apply to any of
the systems you guys are talking about.  Sorry for the noise.

PREEMPT with ACPI is showing some other problems on my machine as well
(for example when PREEMPT is enabled my battery status applet fails
after several hours of uptime, or even shorter if a stress the
network).  I can't reproduce this if I disable PREEMPT.

Anyway, good luck in finding a common issue for your problems.

Later,
Tom



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSHHKE1>; Thu, 8 Aug 2002 06:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSHHKE1>; Thu, 8 Aug 2002 06:04:27 -0400
Received: from [196.26.86.1] ([196.26.86.1]:26305 "EHLO
	infosat-gw.realnet.co.sz") by vger.kernel.org with ESMTP
	id <S317429AbSHHKE0>; Thu, 8 Aug 2002 06:04:26 -0400
Date: Thu, 8 Aug 2002 12:25:17 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: martin@dalecki.de
Cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: bad: schedule() with irqs disabled! (+ ksymoops)
In-Reply-To: <3D523E53.2030702@evision.ag>
Message-ID: <Pine.LNX.4.44.0208081218160.24255-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Marcin Dalecki wrote:

> I can report pretty the same:
> 
> Trace; c0113f84 <try_to_wake_up+104/110>
> Trace; c0113fa6 <wake_up_process+16/20>
> Trace; c011d1f7 <do_softirq+a7/c0>

What to do? Looks like do_softirq needs some work, also reading the 
comments at the beginning of kernel/softirq.c is it preempt safe? This is 
from looking at 'cpu = smp_processor_id' usage in do_softirq.

Cheers,
	Zwane
-- 
function.linuxpower.ca


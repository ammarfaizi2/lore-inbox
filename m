Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWCWMtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWCWMtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 07:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWCWMtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 07:49:13 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:41351 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932533AbWCWMtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 07:49:12 -0500
Date: Thu, 23 Mar 2006 13:48:35 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, george@wildturkeyranch.net,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCHSET 0/10] Time: Generic Timekeeping (v.C1)
In-Reply-To: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0603231209380.17704@scrub.home>
References: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 22 Mar 2006, john stultz wrote:

> Andrew, All,
> 	Here is an updated version of the smaller, reworked and 
> improved patchset I mailed out monday. Please consider for inclusion 
> into your tree.

It looks pretty good already. :)
Give me a bit of time to rework the middle part a bit and if we can agree 
to make the new gettimeofday functions optional for an arch, IMO it would 
be ok for 2.6.17. I think the important part is to get the generic clock 
infrastructure merged, so it can be used by other kernel parts, the 
unification of performance sensitive parts can still be done on top of it 
a bit later.

One general comment: Currently clock relevant source is scattered in 
kernel/time/, drivers/clocksource and arch/... IMO it would be better to 
keep at least the first two parts a bit closer, although I'm not sure how 
to organize it better. I don't know if we can be so bold to add a toplevel 
time/ (similiar to sound/) or maybe we organize a bit like drivers/ide/. 
Anyway, maybe someone has a good idea to keep everything a bit closer 
together.

bye, Roman

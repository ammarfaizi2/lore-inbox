Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWCWNUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWCWNUn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 08:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWCWNUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 08:20:43 -0500
Received: from www.osadl.org ([213.239.205.134]:64186 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751364AbWCWNUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 08:20:42 -0500
Subject: Re: [PATCHSET 0/10] Time: Generic Timekeeping (v.C1)
From: Thomas Gleixner <tglx@linutronix.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: john stultz <johnstul@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, george@wildturkeyranch.net,
       Steven Rostedt <rostedt@goodmis.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0603231209380.17704@scrub.home>
References: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0603231209380.17704@scrub.home>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 14:20:58 +0000
Message-Id: <1143123658.28099.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 13:48 +0100, Roman Zippel wrote:
> One general comment: Currently clock relevant source is scattered in 
> kernel/time/, drivers/clocksource and arch/... IMO it would be better to 
> keep at least the first two parts a bit closer, although I'm not sure how 
> to organize it better. I don't know if we can be so bold to add a toplevel 
> time/ (similiar to sound/) or maybe we organize a bit like drivers/ide/. 
> Anyway, maybe someone has a good idea to keep everything a bit closer 
> together.

IMO it makes completely sense to move the time/timer/clocks related
generic code into kernel/time.

drivers/clocksource holds drivers which can be shared between
architectures.

The other drivers really should stay in the architecture specific files
as they are often deeply embedded in the SoC or chipset support code.

	tglx



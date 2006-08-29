Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbWH2TXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbWH2TXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 15:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWH2TXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 15:23:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:6887 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965063AbWH2TXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 15:23:15 -0400
Subject: Re: Linux time code
From: john stultz <johnstul@us.ibm.com>
To: linux@horizon.com
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org, theotso@us.ibm.com
In-Reply-To: <20060829032829.28776.qmail@science.horizon.com>
References: <20060829032829.28776.qmail@science.horizon.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 12:23:05 -0700
Message-Id: <1156879386.7748.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 23:28 -0400, linux@horizon.com wrote:
> > With the new clocksource code, we can (currently just i386, but the
> > architecture is generic and I'm working on the other arches) make use of
> > continuous clocksources for accumulating time instead of having the deal
> > with the problematic PIT (as well as the lost ticks issue).
> 
> If it's there, it's great, but what about i386EX embedded boards and
> the like?

The PIT clocksource is available for those situations, but is one of the
lowest rated clocksources, so anything else will be used if its
available.

>   It's approximately manageable on uniprocessor, but can
> I be sure there's always something (what?) better than the PIT on
> *every* SMP system?

Yea. With the exception of NUMAQ almost every i386 SMP system either can
use the TSC or has an alternative clocksource (acpi pm, hpet, cyclone).


> I need to study what you've done and see how to use it.

Let me know if you have any questions or thoughts about it.

thanks
-john



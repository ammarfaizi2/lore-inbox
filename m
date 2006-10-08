Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWJHQwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWJHQwq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 12:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWJHQwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 12:52:46 -0400
Received: from www.osadl.org ([213.239.205.134]:16572 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751275AbWJHQwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 12:52:45 -0400
Subject: Re: + clocksource-increase-initcall-priority.patch added to -mm
	tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160324288.3693.71.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610070153.k971ren4020838@shell0.pdx.osdl.net>
	 <1160294812.22911.8.camel@localhost.localdomain>
	 <1160302797.22911.37.camel@localhost.localdomain>
	 <1160319033.3693.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319234.5686.12.camel@localhost.localdomain>
	 <1160322317.3693.47.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160323127.5686.37.camel@localhost.localdomain>
	 <1160324288.3693.71.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 18:52:43 +0200
Message-Id: <1160326363.5686.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 09:18 -0700, Daniel Walker wrote:
> > Early bootup Instrumentation is really not a good argument to make that
> > fragile time related stuff even more complex. There is no problem to
> > register reliable clocksources in early bootup, but do not make this
> > mandatory. Not every system is an ARM SoC, where you can and must rely
> > on the one source which is available usually right when the CPU comes
> > up.
> 
> It's not mandatory, it's just preferred.. As I said above, to avoid
> churn. I don't like the churn at boot up, and I tried to make sure there
> was none added in the patch set. 

What churn at bootup ? The clocksources _can_ be switched and it does
not matter, when this is done. We had the trouble with the early
registration a couple of month ago, and there is no reason to
reintroduce it. On systems which have exactly one clocksource, you can
register them early in bootup, but please do not touch the x86 setup for
no good reason.

	tglx



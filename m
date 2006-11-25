Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935085AbWKXVmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935085AbWKXVmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935073AbWKXVmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:42:44 -0500
Received: from mail.gmx.de ([213.165.64.20]:13489 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S934494AbWKXVmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:42:43 -0500
X-Authenticated: #14349625
Subject: Re: [patch] PM: suspend/resume debugging should depend on
	SOFTWARE_SUSPEND
From: Mike Galbraith <efault@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611240959170.6991@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	 <20061123133904.GD5561@ucw.cz> <1164317804.6222.11.camel@Homer.simpson.net>
	 <200611232236.58444.rjw@sisk.pl>
	 <1164350350.6128.9.camel@Homer.simpson.net>
	 <Pine.LNX.4.64.0611240959170.6991@woody.osdl.org>
Content-Type: text/plain
Date: Sat, 25 Nov 2006 01:22:51 +0100
Message-Id: <1164414171.6010.32.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-24 at 10:08 -0800, Linus Torvalds wrote:

> One thing that is often worth testing is to try with APIC support if you 
> don't have it already, or if you do have it, try _without_ APIC support. 
> The firmware generally is only tested against MS operating systems, so 
> it's only ever been tested for the particular irq setup that Windows tends 
> to use, and as a result sometimes things work better in one more or 
> another.

I'll try noapic.  (though I value my apic more than s2ram;)

> Based on the "fasteoi", you're obviously right now using the APIC, and 
> that's _usually_ the mode that works better. But just in case, try booting 
> with "noapic".
> 
> Also, can you send out the boot log with APIC information ("apic=debug"). 
> Of course, don't disable the apic for that case, or it won't be very 
> useful ;)

Will do.  (not tomorrow though, helping friend with home construction)

I found the driver that was causing my panic problem with vanilla, it
was my Sat TV card.  I haven't ever used it with Linux, and haven't used
it with that other OS but a couple of times to try it out(stupid stupid
purchase), so I tossed it.

Box still paniced though, apparently after restoring all drivers (last
trace mark was end of function marker).  I disabled trace, and enabled
the "leave console active, danger danger" option in hopes of capturing
the panic, and what do you know, for the first time ever, box restored
all the way into X... only to panic about two seconds later.  Nothing
whatsoever got to my serial console.  Switching to a text console before
suspend didn't help either, the panic is invisible.  Drat.

I'll toss rocks at it.

	-Mike


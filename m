Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWENAOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWENAOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 20:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWENAOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 20:14:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:28839 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964816AbWENAOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 20:14:48 -0400
Subject: Re: [linux-pm] Re: [PATCH/rfc] schedule /sys/device/.../power for
	removal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200605120652.55658.david-b@pacbell.net>
References: <20060512100544.GA29010@elf.ucw.cz>
	 <20060512031151.76a9d226.akpm@osdl.org>
	 <200605120652.55658.david-b@pacbell.net>
Content-Type: text/plain
Date: Sun, 14 May 2006 10:13:51 +1000
Message-Id: <1147565632.21291.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 06:52 -0700, David Brownell wrote:
> On Friday 12 May 2006 3:11 am, Andrew Morton wrote:
> > 
> > What will be impacted by this?
> 
> Driver suspend/resume testing ... impact is strongly negative.
> 
> Without this interface, there is NO way to test individual drivers for
> correct handling of suspend/resume calls; the only way to test drivers
> is to suspend/resume the whole system, along with all other drivers in
> the system.  Which means that ALL the drivers must work sanely before
> tests for any one of them can succeed ... a losing model when you're
> testing PM on new platforms.
> 
> Which IMO makes removing this a Bad Thing.  It needs to have some
> kind of replacement in place before the "magic numbers" go away.

And that's why Pavel is not proposing to remove it right away... but to
schedule it's removal so that developpers know right now that building a
whole new kernel<->user interface based on that is not the smartest
thing to do.

> (The magic numbers are bad, and should go away -- yes.  Nobody has
> really shown that userspace needs this mechanism for any purpose
> other than driver testing.  Userspace device-specific power management
> tools would need knowledge that's not yet exposed though sysfs.)
> 
> I think both Patrick Mochel and Alan Stern have sent patches at
> various times to let individual drivers provide a list of named
> states they support,  In some cases (like PCI) those lists could
> be delegated to bus-specific code.
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWCFPnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWCFPnP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWCFPnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:43:15 -0500
Received: from xenotime.net ([66.160.160.81]:11481 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750836AbWCFPnO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:43:14 -0500
Date: Mon, 6 Mar 2006 07:44:43 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Raul <raul_baena@ya.com>
Cc: rostedt@goodmis.org, jonathan@jonmasters.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Doubt about scheduler
Message-Id: <20060306074443.fb6b8afb.rdunlap@xenotime.net>
In-Reply-To: <440BF854.1050201@ya.com>
References: <4407584A.60301@ya.com>
	<35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com>
	<440AE3F3.3090404@ya.com>
	<440AE7E3.4060500@yahoo.com.au>
	<440B01E1.8080102@ya.com>
	<35fb2e590603051330o1dfa6951le3e7f14cda0c0eaa@mail.gmail.com>
	<Pine.LNX.4.58.0603060218540.17802@gandalf.stny.rr.com>
	<440BF854.1050201@ya.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2006 09:52:36 +0100 Raul wrote:

> Steven Rostedt wrote:
> 
> >On Sun, 5 Mar 2006, Jon Masters wrote:
> >
> >  
> >
> >>On 3/5/06, Raúl Baena <raul_baena@ya.com> wrote:
> >>
> >>    
> >>
> >>>I thought that to make the module about the new O(k) scheduler would be
> >>>a good idea. I think that it´s not enough for me schedstats, because I
> >>>want to make a visual scheduler, I mean, using GTK+ , a module and
> >>>something else to make a visual scheduler monitor, how the tasks move
> >>>between "active" and "expired", where the task are in prio_array with
> >>>the bitmap fields...this module isn´t usefull, only in a didactic way.
> >>>      
> >>>
> >>If you're seriously interested in this then cool. Let me know how you get on.
> >>
> >>I looked at hacking something into gtop etc. previously to use
> >>/proc/kcore and pull out task information - I'd certainly like to see
> >>a visual process monitor that could pull all of this stuff out and
> >>display it for educational interest (page tables, vmas, other
> >>resources). But then, it's probably been done - I didn't look to see
> >>what else is out there.
> >>
> >>    
> >>
> >
> >Raul, Also take a look at relayfs. It's a fast way to record data in the
> >kernel and pass it back to a userland process.  You'll have to patch the
> >kernel as it is said that the data needed is private to sched.c
> >
> >Look into Documentation/filesystems/relayfs.txt
> >
> >relayfs entered the kernel in 2.6.14.
> >
> >-- Steve
> >
> >  
> >
> Thank you very much, I'll see it. I'll tell you my progress!!!

note that in recent kernels it has changed to:

config RELAY
	bool "Kernel->user space relay support (formerly relayfs)"
	help
	  This option enables support for relay interface support in
	  certain file systems (such as sysfs, and trivially debugfs).
	  It is designed to provide an efficient mechanism for tools and
	  facilities to relay large amounts of data from kernel space to
	  user space.



---
~Randy

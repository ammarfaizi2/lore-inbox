Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751947AbWCFH34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbWCFH34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWCFH34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:29:56 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:53698 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751947AbWCFH3z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:29:55 -0500
Date: Mon, 6 Mar 2006 02:29:49 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: jonathan@jonmasters.org
cc: =?ISO-8859-1?Q?Ra=FAl_Baena?= <raul_baena@ya.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Doubt about scheduler
In-Reply-To: <35fb2e590603051330o1dfa6951le3e7f14cda0c0eaa@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0603060218540.17802@gandalf.stny.rr.com>
References: <4407584A.60301@ya.com>  <35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com>
  <440AE3F3.3090404@ya.com> <440AE7E3.4060500@yahoo.com.au>  <440B01E1.8080102@ya.com>
 <35fb2e590603051330o1dfa6951le3e7f14cda0c0eaa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 5 Mar 2006, Jon Masters wrote:

> On 3/5/06, Raúl Baena <raul_baena@ya.com> wrote:
>
> > I thought that to make the module about the new O(k) scheduler would be
> > a good idea. I think that it´s not enough for me schedstats, because I
> > want to make a visual scheduler, I mean, using GTK+ , a module and
> > something else to make a visual scheduler monitor, how the tasks move
> > between "active" and "expired", where the task are in prio_array with
> > the bitmap fields...this module isn´t usefull, only in a didactic way.
>
> If you're seriously interested in this then cool. Let me know how you get on.
>
> I looked at hacking something into gtop etc. previously to use
> /proc/kcore and pull out task information - I'd certainly like to see
> a visual process monitor that could pull all of this stuff out and
> display it for educational interest (page tables, vmas, other
> resources). But then, it's probably been done - I didn't look to see
> what else is out there.
>

Raul, Also take a look at relayfs. It's a fast way to record data in the
kernel and pass it back to a userland process.  You'll have to patch the
kernel as it is said that the data needed is private to sched.c

Look into Documentation/filesystems/relayfs.txt

relayfs entered the kernel in 2.6.14.

-- Steve


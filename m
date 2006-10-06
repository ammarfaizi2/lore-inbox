Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWJFBer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWJFBer (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 21:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWJFBer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 21:34:47 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:31729 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932555AbWJFBeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 21:34:46 -0400
Date: Thu, 5 Oct 2006 21:29:37 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, fche@redhat.com,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] The New and Improved Logdev (now with kprobes!)
Message-ID: <20061006012936.GA19300@Krystal>
References: <1160025104.6504.30.camel@localhost.localdomain> <20061005143133.GA400@Krystal> <Pine.LNX.4.58.0610051054300.28606@gandalf.stny.rr.com> <20061005170132.GA11149@Krystal> <Pine.LNX.4.58.0610051309090.30291@gandalf.stny.rr.com> <20061005205055.GB1865@Krystal> <Pine.LNX.4.58.0610051659590.1011@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0610051659590.1011@gandalf.stny.rr.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 21:26:41 up 43 days, 22:35,  3 users,  load average: 0.06, 0.08, 0.09
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt (rostedt@goodmis.org) wrote:
 >
> > Please don't :) Defining a new event would be to say :
> >
> > I want to create an event named "schedchange", which belongs to the "kernel"
> > subsystem. In its definition, I say that it will take two integers and a long,
> > respectively names "prev_pid", "next_pid" and "state".
> >
> > We can think of various events for various subsystems, and even for modules. It
> > becomes interesting to have dynamically loadable event definitions which gets
> > loaded with kernel modules. The "description" of the events is saved in the
> > trace, in a special low traffic channel (small buffers with a separate file).
> >
> 
> But these events still need the marker in the source code right?
> 

Yes, but not necessarily. But it could also be a kernel module built
on-the-fly by a generator like SystemTAP which defines new events.

> 
> That should definitely be a step. If I'm understanding this (which I may
> not be), you can have a dynamic event added with also using dynamic
> trace points like kprobes.
> 

Yes, we could use a kprobes based approach with only one data type (string is
always a good example), but we could also define one specific event and its
associates data types for each probes.


> No prob, I should read the rest of the thread, and try to catch up more,
> before posting more comments.
> 

No problem, constructive comments and ideas are always welcome.


Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

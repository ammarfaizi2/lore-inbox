Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWEOOFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWEOOFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWEOOFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:05:19 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:20872 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964923AbWEOOFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:05:17 -0400
Date: Mon, 15 May 2006 10:05:08 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Daniel Walker <dwalker@mvista.com>
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] scheduling while atomic in fs/file.c
In-Reply-To: <1147701098.15392.49.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Message-ID: <Pine.LNX.4.58.0605151004040.16618@gandalf.stny.rr.com>
References: <200605141545.k4EFj6Cv001901@dwalker1.mvista.com> 
 <Pine.LNX.4.58.0605141241320.25158@gandalf.stny.rr.com> 
 <1147627976.15392.39.camel@c-67-180-134-207.hsd1.ca.comcast.net> 
 <Pine.LNX.4.58.0605150239570.6512@gandalf.stny.rr.com> 
 <Pine.LNX.4.58.0605150254440.6512@gandalf.stny.rr.com>
 <1147701098.15392.49.camel@c-67-180-134-207.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 May 2006, Daniel Walker wrote:

> On Mon, 2006-05-15 at 03:04 -0400, Steven Rostedt wrote:
>
> >
> > Just to clarify, although fdtable_defer_list_init(int cpu) creates a timer
> > for each CPU but sets them to the same CPU.  The mod_timer in the changed
> > function is what is used to spread the timers out.
>
> Your right , it could migrate with my change only .. But I don't think
> that a problem .. It's probably better ..

My only concern is that this makes things less deterministic, but I'm
probably being paranoid here.

-- Steve

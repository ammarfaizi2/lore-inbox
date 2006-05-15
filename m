Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWEONvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWEONvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWEONvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:51:42 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:42472 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S964874AbWEONvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:51:41 -0400
Subject: Re: [PATCH -rt] scheduling while atomic in fs/file.c
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0605150254440.6512@gandalf.stny.rr.com>
References: <200605141545.k4EFj6Cv001901@dwalker1.mvista.com>
	 <Pine.LNX.4.58.0605141241320.25158@gandalf.stny.rr.com>
	 <1147627976.15392.39.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <Pine.LNX.4.58.0605150239570.6512@gandalf.stny.rr.com>
	 <Pine.LNX.4.58.0605150254440.6512@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 06:51:37 -0700
Message-Id: <1147701098.15392.49.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 03:04 -0400, Steven Rostedt wrote:

> 
> Just to clarify, although fdtable_defer_list_init(int cpu) creates a timer
> for each CPU but sets them to the same CPU.  The mod_timer in the changed
> function is what is used to spread the timers out.

Your right , it could migrate with my change only .. But I don't think
that a problem .. It's probably better ..

Daniel


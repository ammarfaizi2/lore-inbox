Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUBDBmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 20:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUBDBmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 20:42:14 -0500
Received: from dp.samba.org ([66.70.73.150]:59024 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266210AbUBDBmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 20:42:08 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core 
In-reply-to: Your message of "Tue, 03 Feb 2004 04:26:33 CDT."
             <Pine.LNX.4.58.0402030418310.22596@devserv.devel.redhat.com> 
Date: Wed, 04 Feb 2004 11:19:21 +1100
Message-Id: <20040204014222.514C62C2AC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.58.0402030418310.22596@devserv.devel.redhat.com> you write:
> > introduce a SIGRECONF (default ignored).  But AFAICT, introducing a new
> > signal isn't possible (at least on x86) without breaking glibc.
> 
> you can introduce a variable RT signal for this purpose no problem - and
> one would want to have a queued signal for this anyway. Ie. by default the
> notification is disabled, but a new syscall sets up the process to be
> notified of CPU up/down events, on a signal # picked by the app. But this
> this indeed is dbus domain ...

Yeah, this workaround because we can't add a new signal isn't very
good, though ("I can't add a new signal, so you choose!").  In
practice, it sucks for libraries and it sucks for children.

As you point out, DBUS is a better solution anyway.  Of course,
proposing that something which doesn't yet exist will solve all our
problems is usually a sign of laziness or optimism 8).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

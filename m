Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264495AbSIVTWU>; Sun, 22 Sep 2002 15:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264497AbSIVTWU>; Sun, 22 Sep 2002 15:22:20 -0400
Received: from ns.suse.de ([213.95.15.193]:65036 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264495AbSIVTWT>;
	Sun, 22 Sep 2002 15:22:19 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
References: <Pine.LNX.4.44.0209221830400.8911-100000@serv.suse.lists.linux.kernel> <Pine.LNX.4.44.0209221130060.1455-100000@home.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Sep 2002 21:27:29 +0200
In-Reply-To: Linus Torvalds's message of "22 Sep 2002 20:36:41 +0200"
Message-ID: <p734rchu8ny.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> 
> I suspect we'll want to have some form of event tracing eventually, but
> I'm personally pretty convinced that it needs to be a per-CPU thing, and 
> the core mechanism would need to be very lightweight. It's easier to build 
> up complexity on top of a lightweight interface than it is to make a 
> lightweight interface out of a heavy one.

There is an old patch around from SGI that does exactly this. It is a
very lightweight binary value tracer that has per CPU buffers. It
traces using macros that you can easily add. It's called ktrace (not
to be confused with Ingo's ktrace). I've been porting it for some time
for my own tracing needs (adding tracing macros as needed but never submitting
them). If you're interested I can submit it for 2.5 (without any hooks, people
should just add them as needed and then remove them again) 

-Andi

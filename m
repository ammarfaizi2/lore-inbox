Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318720AbSIHPhy>; Sun, 8 Sep 2002 11:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318731AbSIHPhy>; Sun, 8 Sep 2002 11:37:54 -0400
Received: from [63.209.4.196] ([63.209.4.196]:54790 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318720AbSIHPhy>; Sun, 8 Sep 2002 11:37:54 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Sun, 8 Sep 2002 08:45:26 -0700
Message-Id: <200209081545.g88FjQZ10714@penguin.transmeta.com>
To: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: Performance issue in 2.5.32+
Newsgroups: linux.dev.kernel
In-Reply-To: <Mutt.LNX.4.44.0209082131140.20784-100000@blackbird.intercode.com.au>
Organization: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks ridiculous, a 1000 us latency is one millisecond, which would
seem to imply that something is getting synchronized with the timer
interrupt for some reason.

You also have a few other outliers (TCP latency and file delete), AND
your memory performance also went down a lot.

Quite frankly, the memory performance thing has nothing to do with the
OS, so there's something else going on on your machine.  That "something
else" may be some process that is constantly running one one CPU or
something. 

Maybe something got confused by the kernel change, and is now getting
stuck in the background? 

		Linus

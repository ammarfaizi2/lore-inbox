Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSGKVDt>; Thu, 11 Jul 2002 17:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSGKVDt>; Thu, 11 Jul 2002 17:03:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35853 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310190AbSGKVDs>; Thu, 11 Jul 2002 17:03:48 -0400
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as
To: george@mvista.com (george anzinger)
Date: Thu, 11 Jul 2002 22:29:03 +0100 (BST)
Cc: mbs@mc.com (mbs), dank@kegel.com,
       linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3D2DE9B2.70A21F7E@mvista.com> from "george anzinger" at Jul 11, 2002 01:25:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17SlUl-0001ai-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> First blush is HELL YES!  The issue is accounting.  When you
> ask how long a program ran, you are looking at the
> accounting that happens on a tick.  This is where one of two

Thats also an implementation issue. Note that the current code is also
wildly inaccurate. Mr Shannon says we are good to at best 50 run/sleep
changes a second.  I've got "100% busy" workloads that are 99% asleep.

Tracking cpu usage at task switch works a lot better for newer processors
which as well as having rdtsc also have performance counters. In fact you
can do much more interesting things on modern PC class platforms like
scheduling using pre-emption interrupts based on instructions executed,
memory accesses and more.

Alan

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261631AbSI0FGt>; Fri, 27 Sep 2002 01:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261632AbSI0FGt>; Fri, 27 Sep 2002 01:06:49 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:16140 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S261631AbSI0FGt>; Fri, 27 Sep 2002 01:06:49 -0400
Date: Fri, 27 Sep 2002 00:11:58 -0500 (CDT)
Message-Id: <200209270511.g8R5Bwj14803@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: ajm@sgi.com (Alan Mayer)
Subject: Re: [PATCH] Cirqs on large machines
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.3.96.1020925140516.102141H-100000@fergus.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked at this patch again, and it makes no sense.

It would simply sum the unrelated IRQ % IRQvec irqs into a meaningless number.

If you don't want the space taken up in kstat, then you should expand on the
three ifdefs to something like this:

< #if !define(CONFIG_ARCH_S390) 
--
> #if !define(CONFIG_ARCH_S390) && !defined(CONFIG_YOUR_BIG_NUMA)


PS: sparc and sparc64 appear to have sparse irq space too: see __irq_itoa

milton

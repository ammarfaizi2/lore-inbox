Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318546AbSGaXRS>; Wed, 31 Jul 2002 19:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318562AbSGaXRS>; Wed, 31 Jul 2002 19:17:18 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:40445 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318546AbSGaXRR>; Wed, 31 Jul 2002 19:17:17 -0400
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org
In-Reply-To: <200207311914.g6VJEG5308283@saturn.cs.uml.edu>
References: <200207311914.g6VJEG5308283@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 01:37:17 +0100
Message-Id: <1028162237.13008.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 20:14, Albert D. Cahalan wrote:
> Alan Cox writes:
> > On Wed, 2002-07-31 at 13:59, David Luyer wrote:
> 
> >>   printf("%d\n", sysconf(_SC_NPROCESSORS_CONF));
> >> }
> >> luyer@praxis8:~$ ./cpus
> >> 4
> >> luyer@praxis8:~$ grep 'processor        ' /proc/cpuinfo
> >> processor       : 0
> >> processor       : 1
> >
> > In which case I suggest you file a glibc bug. sysconf looks at the /proc
> > stuff as I understand it
> 
> First you blame ps. Then you blame libc. How about you
> place the fault right where it belongs?

ps is certainly buggy. HZ is 100. ps grovelling around in /proc is bogus
to say the least. That code wasn't exactly well written.

> Counting processors in /proc/cpuinfo is a joke of an ABI.
> 
> Add a proper ABI now, and userspace can transition to it
> over the next 4 years.

Which is what I've been talking to Ulrich about.


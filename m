Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318564AbSHAALK>; Wed, 31 Jul 2002 20:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318569AbSHAALK>; Wed, 31 Jul 2002 20:11:10 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:6142 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318564AbSHAALD>; Wed, 31 Jul 2002 20:11:03 -0400
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@suse.de>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20020801014925.L10436@suse.de>
References: <200207311914.g6VJEG5308283@saturn.cs.uml.edu>
	<1028162237.13008.26.camel@irongate.swansea.linux.org.uk> 
	<20020801014925.L10436@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 02:30:57 +0100
Message-Id: <1028165457.13346.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 00:49, Dave Jones wrote:
> On Thu, Aug 01, 2002 at 01:37:17AM +0100, Alan Cox wrote:
>  > > Add a proper ABI now, and userspace can transition to it
>  > > over the next 4 years.
>  > 
>  > Which is what I've been talking to Ulrich about.
> 
> I thought this was the idea behind sysconf(__SC_NPROCESSORS_CONF) ?

sysconf is implemented in glibc. Right now this is done by poking around
in /proc/cpuinfo. The kernel doesn't export the data very nicely. With
2.5 and Rusty's hot swappable processors we need to export the data even
more explicitly.


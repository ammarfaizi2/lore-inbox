Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWFQC5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWFQC5D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 22:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWFQC5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 22:57:03 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:36245 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750702AbWFQC5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 22:57:02 -0400
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
From: Lee Revell <rlrevell@joe-job.com>
To: Voluspa <lista1@comhem.se>
Cc: randy.dunlap@oracle.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       len.brown@intel.com, rdreier@cisco.com, mingo@elte.hu
In-Reply-To: <20060616112346.1d2050d0.lista1@comhem.se>
References: <20060615010850.3d375fa9.lista1@comhem.se>
	 <4490B48E.5060304@oracle.com> <20060615130336.176f527c.lista1@comhem.se>
	 <1150388824.2925.105.camel@mindpipe>
	 <20060616112346.1d2050d0.lista1@comhem.se>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 22:57:08 -0400
Message-Id: <1150513028.26252.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-16 at 11:23 +0200, Voluspa wrote:
> On Thu, 15 Jun 2006 12:27:03 -0400 Lee Revell wrote:
> > On Thu, 2006-06-15 at 13:03 +0200, Voluspa wrote:
> > > On Wed, 14 Jun 2006 18:14:54 -0700 Randy Dunlap wrote:
> > > > updated version:
> > > 
> > > As a user, it's great if this fixes people's keyboards and mice. But it's
> > > not a panacea. Gkrellm reads CPU temperatures from
> > > /proc/acpi/thermal_zone/*/temperature and that disturbs a time-critical
> > > application like mplayer, both when reading normal video and hacked mms:
> > > sound streams (ogg sound is OK, though):
> > > 
> > 
> > It would be helpful to analyze this with Ingo's latency tracing patch.
> 
> Do you mean proper in relation to ubuntu-patched, or just proper?

Not sure, I'm not familiar with the exact reason that reading CPU
temperatures would cause long latencies like this.  The latency tracer
can tell you the exact code path responsible.

>  And, hmmm,
> I do read a lot of archived lkml threads, but latency tracing patch... Is
> it buried in the -rt set?

It's part of the -rt set and also available broken out for 2.6.16:

http://people.redhat.com/mingo/latency-tracing-patches/latency-tracing-v2.6.16.patch

Lee


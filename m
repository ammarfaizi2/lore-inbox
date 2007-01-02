Return-Path: <linux-kernel-owner+w=401wt.eu-S1752877AbXABXrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbXABXrU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbXABXrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:47:20 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:59202
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbXABXrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:47:19 -0500
Date: Tue, 2 Jan 2007 15:47:12 -0800
To: "Chen, Tim C" <tim.c.chen@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] lock stat for -rt 2.6.20-rc2-rt2 [was Re: 2.6.19-rt14 slowdown compared to 2.6.19]
Message-ID: <20070102234712.GA22822@gnuppy.monkey.org>
References: <20061229232618.GA11239@gnuppy.monkey.org> <9D2C22909C6E774EBFB8B5583AE5291C019FA2B5@fmsmsx414.amr.corp.intel.com> <20070102231234.GA22627@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102231234.GA22627@gnuppy.monkey.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 03:12:34PM -0800, Bill Huey wrote:
> On Tue, Jan 02, 2007 at 02:51:05PM -0800, Chen, Tim C wrote:
> > Bill,
> > 
> > I'm having some problem getting this patch to run stablely.  I'm
> > encoutering errors like that in the trace that follow:
> 
> It might the case that the lock isn't know to the lock stats code yet.
> It's got some technical overlap with lockdep in that a lock might not be
> known yet and is causing a crashing.

The stack trace and code examination reveals, if that structure in the
timer code is used before it's initialized by the CPU bringup, it'll
cause problems like that crash. I'll look at it later on tonight.

bill


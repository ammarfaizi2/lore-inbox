Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269291AbUJKWIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbUJKWIL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269285AbUJKWF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:05:56 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:58600 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269298AbUJKWFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:05:12 -0400
Subject: Re: voluntary-preempt T3 latency spikes with fan speed change
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Rodland <arodland@entermail.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <ckeec5$id4$1@sea.gmane.org>
References: <20041009104702.GA14649@mobilat.informatik.uni-bremen.de>
	 <ckeec5$id4$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1097531790.1453.55.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 17:56:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 13:03, Andrew Rodland wrote:
> torbenh@gmx.de wrote:
> 
> > 
> > hi...
> > 
> > i am seeing latency spikes (ie jack xruns) when the fan of my
> > asus l3d laptop changes speed.
> > 
> > is there any chance to fix this ?
> > i have turned off acpi in the kernel, as this gives me latency spikes
> > all over.
> > 
> > i am quite new to the VP patches, and want to help where i can.
> > 
> > i also got a quite strange latency trace here:
> > 
> > could someone sched some light on this please ?
> > 
> 
> I can't say for certain, but I'm guessing that your laptop has a deeply
> broken BIOS that implements ACPI and suchlike by using SMM, which blocks
> out interrupts, and there's nothing, I believe, you can do about it.
> Disabling ACPI seems sensible; at least you can avoid causing these delays
> intentionally, but if some sensor interrupt triggers a flip into SMM to
> enable the fan, you're just screwed for a number of milliseconds.
> 

Many, many people are seeing this problem (weird, often periodic latency
spikes on laptops that go away when ACPI is disabled).  This would
explain a lot of weird bug reports.  So are most laptops just
incompatible with low latency applications, or are we talking about a
small minority of broken hardware?

Is there any way to tell a priori whether a machine will have this
problem?

Lee


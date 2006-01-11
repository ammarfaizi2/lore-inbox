Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbWAKXpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWAKXpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbWAKXpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:45:00 -0500
Received: from hera.kernel.org ([140.211.167.34]:55691 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932639AbWAKXo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:44:59 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Date: Wed, 11 Jan 2006 15:44:55 -0800
Organization: OSDL
Message-ID: <20060111154455.19238c7f@dxpl.pdx.osdl.net>
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net>
	<200601110227.30461.ak@suse.de>
	<20060111145704.2cfbd44a@dxpl.pdx.osdl.net>
	<200601120036.26026.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1137023095 22626 10.8.0.74 (11 Jan 2006 23:44:55 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 11 Jan 2006 23:44:55 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 00:36:25 +0100
Andi Kleen <ak@suse.de> wrote:

> On Wednesday 11 January 2006 23:57, Stephen Hemminger wrote:
> > On Wed, 11 Jan 2006 02:27:30 +0100
> > Andi Kleen <ak@suse.de> wrote:
> > 
> > > On Wednesday 11 January 2006 01:54, Stephen Hemminger wrote:
> > > 6
> > > > [   37.047264] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)[   37.070722] CPU: L2 Cache: 1024K (64 bytes/line)
> > > > [   37.085894] mtrr: v2.0 (20020519)
> > > > [   37.350186] Using local APIC timer interrupts.
> > > > [   37.414873] Detected 12.464 MHz APIC timer.
> > > > [   37.428717] Booting processor 1/2 APIC 0x1
> > > > 
> > > > Machine then goes blank and reboots...
> > > 
> > > Don't know what it could be - I didn't merge anything. Maybe revert the kexec patches? 
> > > Does the -git6 snapshot still work?  Possibly do a binary search to narrow
> > > it down.
> > > 
> > > -Andi
> > That was not the bad config. It turns out the problem is the new code
> > for kdump. If CONFIG_KDUMP is turned on it crashes.
> 
> Ok thanks. I took a quick look and didn't saw anything obvious
> below arch/x86_64 that could cause it. Maybe will try later again in a simulator 
> or Vivek will probably fix it when he wakes up again.
> 

Could the PHYSICAL_START default be wrong for SMP on x86_64?
Never looked inside the boot startup code to check.
-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger

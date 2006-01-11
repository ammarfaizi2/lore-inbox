Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932631AbWAKXhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbWAKXhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWAKXhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:37:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:62618 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932631AbWAKXhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:37:00 -0500
From: Andi Kleen <ak@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Date: Thu, 12 Jan 2006 00:36:25 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net> <200601110227.30461.ak@suse.de> <20060111145704.2cfbd44a@dxpl.pdx.osdl.net>
In-Reply-To: <20060111145704.2cfbd44a@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120036.26026.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 January 2006 23:57, Stephen Hemminger wrote:
> On Wed, 11 Jan 2006 02:27:30 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > On Wednesday 11 January 2006 01:54, Stephen Hemminger wrote:
> > 6
> > > [   37.047264] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)[   37.070722] CPU: L2 Cache: 1024K (64 bytes/line)
> > > [   37.085894] mtrr: v2.0 (20020519)
> > > [   37.350186] Using local APIC timer interrupts.
> > > [   37.414873] Detected 12.464 MHz APIC timer.
> > > [   37.428717] Booting processor 1/2 APIC 0x1
> > > 
> > > Machine then goes blank and reboots...
> > 
> > Don't know what it could be - I didn't merge anything. Maybe revert the kexec patches? 
> > Does the -git6 snapshot still work?  Possibly do a binary search to narrow
> > it down.
> > 
> > -Andi
> That was not the bad config. It turns out the problem is the new code
> for kdump. If CONFIG_KDUMP is turned on it crashes.

Ok thanks. I took a quick look and didn't saw anything obvious
below arch/x86_64 that could cause it. Maybe will try later again in a simulator 
or Vivek will probably fix it when he wakes up again.

-Andi



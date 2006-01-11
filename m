Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWAKW5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWAKW5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWAKW5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:57:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932486AbWAKW5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:57:10 -0500
Date: Wed, 11 Jan 2006 14:57:04 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Message-ID: <20060111145704.2cfbd44a@dxpl.pdx.osdl.net>
In-Reply-To: <200601110227.30461.ak@suse.de>
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net>
	<200601110227.30461.ak@suse.de>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 02:27:30 +0100
Andi Kleen <ak@suse.de> wrote:

> On Wednesday 11 January 2006 01:54, Stephen Hemminger wrote:
> 6
> > [   37.047264] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)[   37.070722] CPU: L2 Cache: 1024K (64 bytes/line)
> > [   37.085894] mtrr: v2.0 (20020519)
> > [   37.350186] Using local APIC timer interrupts.
> > [   37.414873] Detected 12.464 MHz APIC timer.
> > [   37.428717] Booting processor 1/2 APIC 0x1
> > 
> > Machine then goes blank and reboots...
> 
> Don't know what it could be - I didn't merge anything. Maybe revert the kexec patches? 
> Does the -git6 snapshot still work?  Possibly do a binary search to narrow
> it down.
> 
> -Andi
That was not the bad config. It turns out the problem is the new code
for kdump. If CONFIG_KDUMP is turned on it crashes.


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger

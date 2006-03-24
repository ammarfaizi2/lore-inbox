Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422962AbWCXBM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422962AbWCXBM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422964AbWCXBM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:12:57 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:1667 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422962AbWCXBM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:12:56 -0500
Subject: Re: 2.6.16-mm1
From: john stultz <johnstul@us.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200603240204.43294.rjw@sisk.pl>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	 <20060323160426.153fbea9.akpm@osdl.org>
	 <1143161390.2299.36.camel@leatherman>  <200603240204.43294.rjw@sisk.pl>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 17:12:43 -0800
Message-Id: <1143162763.2299.50.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 02:04 +0100, Rafael J. Wysocki wrote:
> On Friday 24 March 2006 01:49, john stultz wrote:
> > On Thu, 2006-03-23 at 16:04 -0800, Andrew Morton wrote:
> > > "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl> wrote:
> > > >
> > > > On Thursday 23 March 2006 10:40, Andrew Morton wrote:
> > > > > 
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/
> > > > 
> > > > On a uniprocessor AMD64 w/ CONFIG_SMP unset (2.6.16-rc6-mm2 works on this box
> > > > just fine, .config attached):
> > > 
> > > hm, uniproc x86_64 seems to cause problems sometimes.  I should test it more.
> > > 
> > > > }-- snip --{
> > > > PID hash table entries: 4096 (order: 12, 32768 bytes)
> > > > time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
> > > > time.c: Detected 1795.400 MHz processor.
> > > > disabling early console
> > > > Console: colour dummy device 80x25
> > > > time.c: Lost 103 timer tick(s)! rip 10:start_kernel+0x121/0x220
> > > > last cli 0x0
> > > > last cli caller 0x0
> > > > time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
> > > > last cli 0x0
> > > > last cli caller 0x0
> > > > time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
> > 
> > It seems report_lost_ticks has been set to one w/ 2.6.16-mm1, thus these
> > debug messages will be shown.
> > 
> > Rafael: To properly compare, could you boot 2.6.16-rc6-mm2 w/ the
> > "report_lost_ticks" boot option and see if the same sort of messages do
> > not appear?
> 
> It looks similar but not the same:

Yea, I think thats due to some new code from Andi.

The lost tick issue should be looked into (might be hardware SMIs), but
it seems this is not caused by my patches.

thanks
-john


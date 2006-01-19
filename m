Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbWASIAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbWASIAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 03:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWASIAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 03:00:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2406 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1161256AbWASIAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 03:00:40 -0500
Date: Thu, 19 Jan 2006 09:02:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@gmail.com>,
       jeffrey.t.kirsher@intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] e1000 C style badness
Message-ID: <20060119080200.GA4349@suse.de>
References: <20060118080738.GD3945@suse.de> <20060118083721.GA4222@suse.de> <9e4733910601180953i11963df9n232cd8980c4bf7f2@mail.gmail.com> <43CE8567.5040205@pobox.com> <20060118182012.GR4222@suse.de> <4807377b0601181110y72e1e4f2w8337c559713f2da4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4807377b0601181110y72e1e4f2w8337c559713f2da4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18 2006, Jesse Brandeburg wrote:
> On 1/18/06, Jens Axboe <axboe@suse.de> wrote:
> > On Wed, Jan 18 2006, Jeff Garzik wrote:
> > > We'll get it fixed ASAP, even if it means reverting all those patches.
> >
> > Thanks, it is rather critical. At least it didn't get included in -rc1,
> > that would have been a disaster :-)
> 
> just FYI, I have a patch for the e1000 breakage which will be out as
> soon as I can generate it.

Newest -git works for me. Well sort of, I get a lot of these:

e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  Tx Queue             <0>
  TDH                  <72>
  TDT                  <e5>
  next_to_use          <e5>
  next_to_clean        <6f>
buffer_info[next_to_clean]
  time_stamp           <10000160a>
  next_to_watch        <72>
  jiffies              <100001e09>
  next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  Tx Queue             <0>
  TDH                  <72>
  TDT                  <e5>
  next_to_use          <e5>
  next_to_clean        <6f>
buffer_info[next_to_clean]
  time_stamp           <10000160a>
  next_to_watch        <72>
  jiffies              <1000025da>
  next_to_watch.status <0>
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  Tx Queue             <0>
  TDH                  <72>
  TDT                  <e5>
  next_to_use          <e5>
  next_to_clean        <6f>
buffer_info[next_to_clean]
  time_stamp           <10000160a>
  next_to_watch        <72>
  jiffies              <10000357b>
  next_to_watch.status <0>
NETDEV WATCHDOG: eth0: transmit timed out
e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex


-- 
Jens Axboe


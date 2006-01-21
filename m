Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWAUGwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWAUGwg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 01:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWAUGwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 01:52:36 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:30852 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750913AbWAUGwf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 01:52:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nC8gV4PlYEKl3CQVaHkxLdruq83gNm36Xc0isXZgMLjG/atmZb6tHJDf/xRGWcc17BDW+CSkfoLCNZ3S3/0BMJ6w6jwOJ+ERtqREoEacKI0W4Ga0PzHmA6BSpv2mOr43Gd9nUzJdUXyT/cXxQ6S9ncgVO7hZFRLXOFZXWho3fFA=
Message-ID: <4807377b0601202252p5fde62dbx194006441e94666a@mail.gmail.com>
Date: Fri, 20 Jan 2006 22:52:35 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] e1000 C style badness
Cc: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@gmail.com>,
       jeffrey.t.kirsher@intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060119080200.GA4349@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060118080738.GD3945@suse.de> <20060118083721.GA4222@suse.de>
	 <9e4733910601180953i11963df9n232cd8980c4bf7f2@mail.gmail.com>
	 <43CE8567.5040205@pobox.com> <20060118182012.GR4222@suse.de>
	 <4807377b0601181110y72e1e4f2w8337c559713f2da4@mail.gmail.com>
	 <20060119080200.GA4349@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/06, Jens Axboe <axboe@suse.de> wrote:
> On Wed, Jan 18 2006, Jesse Brandeburg wrote:
> > just FYI, I have a patch for the e1000 breakage which will be out as
> > soon as I can generate it.
>
> Newest -git works for me. Well sort of, I get a lot of these:
>
> e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
> e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
>   Tx Queue             <0>
>   TDH                  <72>
>   TDT                  <e5>
>   next_to_use          <e5>
>   next_to_clean        <6f>
> buffer_info[next_to_clean]
>   time_stamp           <10000160a>
>   next_to_watch        <72>
>   jiffies              <100001e09>
>   next_to_watch.status <0>
> e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
>   Tx Queue             <0>
>   TDH                  <72>
>   TDT                  <e5>
>   next_to_use          <e5>
>   next_to_clean        <6f>
> buffer_info[next_to_clean]
>   time_stamp           <10000160a>
>   next_to_watch        <72>
>   jiffies              <1000025da>
>   next_to_watch.status <0>
> e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
>   Tx Queue             <0>
>   TDH                  <72>
>   TDT                  <e5>
>   next_to_use          <e5>
>   next_to_clean        <6f>
> buffer_info[next_to_clean]
>   time_stamp           <10000160a>
>   next_to_watch        <72>
>   jiffies              <10000357b>
>   next_to_watch.status <0>
> NETDEV WATCHDOG: eth0: transmit timed out
> e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex

where it didn't happen with the previous driver?  I guess thats a good
thing, kinda as we made the problem more frequent, hopefully we can
help fix it?

you don't happen to have TSO enabled do you?

please reply over at netdev at vger.kernel.org with the standard set
of information, lspci, dmesg, etc etc.

Thanks,
  Jesse

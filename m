Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266737AbSKLORg>; Tue, 12 Nov 2002 09:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266767AbSKLORg>; Tue, 12 Nov 2002 09:17:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5281 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266737AbSKLORf>;
	Tue, 12 Nov 2002 09:17:35 -0500
Date: Tue, 12 Nov 2002 15:23:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Andrew Morton <akpm@digeo.com>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
Message-ID: <20021112142354.GC832@suse.de>
References: <1037057498.3dd03dda5a8b9@kolivas.net> <20021112030453.GB15812@vitelus.com> <3DD0E037.1FC50147@digeo.com> <20021112142014.GC15812@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112142014.GC15812@vitelus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12 2002, Aaron Lehmann wrote:
> On Tue, Nov 12, 2002 at 03:04:23AM -0800, Andrew Morton wrote:
> > It will never be stunningly better than 2.4 for normal workloads on
> > normal machines, because 2.4 just ain't that bad.
> 
> Actually, I am having serious problems with 2.4 (.20-pre5). Copying a
> file from hda to hdc without really doing anything else goes very
> slowly and lags the whole system ruthlessly. The load average rises to
> about three. Any app which tries to touch the disk will hang for
> several seconds. Yes, DMA is on on both drives (udma5), as well as
> 32-bit I/O and unmaskirq. Bad IDE controller or driver? I don't know.
> It's a ServerWorks CSB5. I've been meaning to try 2.5-mm to see if it
> improves this.

Testing 2.5 for this would be interesting too indeed, but you should
also try 2.4.20-rc1. Between -pre3 and -pre8 (iirc) you could have
awfully slow io. And you should probably do

# elvtune -r512 /dev/hd{a,c}

too, in 2.4.20-rc1

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267630AbUG3GKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267630AbUG3GKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 02:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUG3GKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 02:10:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57769 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267630AbUG3GKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 02:10:13 -0400
Date: Fri, 30 Jul 2004 08:10:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@ximian.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
Message-ID: <20040730061005.GF18347@suse.de>
References: <20040728065319.GD11690@suse.de> <20040728145228.GA9316@redhat.com> <20040728145543.GB18846@devserv.devel.redhat.com> <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de> <1091051858.13651.1.camel@camp4.serpentine.com> <20040729084928.GR10377@suse.de> <1091166553.1982.9.camel@localhost> <20040730055333.GC7925@suse.de> <1091167031.1982.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091167031.1982.13.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30 2004, Robert Love wrote:
> On Fri, 2004-07-30 at 07:53 +0200, Jens Axboe wrote:
> 
> > read-ahead doesn't matter on ripping audio, just for fs work.
> 
> This isn't ripping, just playing.

Strange, something else must be accessing the drive at the same time.

> > The audio problems might be fixed in 2.6.8-rc1-mm1 + the bounce patch
> > posted a few times (unfortunately 2.6.8-rc2-mm1 drops the patch for some
> > reason).
> 
> Yah, I will retest with 2.6.8-rc2-mm1.

If it's just playback, don't bother.

> > > [1] 
> > > hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> > > hdc: command error: error=0x54
> > > end_request: I/O error, dev hdc, sector 8
> > > Buffer I/O error on device hdc, logical block 1
> > 
> > So this happens during ripping, or?
> 
> During playback.  Or any poking of the drive whatsoever, actually.
> 
> There will be multiple errors on different blocks, until ultimately IDE
> times out and does an ATAPI reset.

So the question is - what else is accessing the drive?

-- 
Jens Axboe


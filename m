Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267621AbUG3FyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267621AbUG3FyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 01:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUG3FyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 01:54:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29862 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267621AbUG3Fxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 01:53:40 -0400
Date: Fri, 30 Jul 2004 07:53:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@ximian.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
Message-ID: <20040730055333.GC7925@suse.de>
References: <20040728053107.GB11690@suse.de> <c93051e8040727235123a6ed67@mail.gmail.com> <20040728065319.GD11690@suse.de> <20040728145228.GA9316@redhat.com> <20040728145543.GB18846@devserv.devel.redhat.com> <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de> <1091051858.13651.1.camel@camp4.serpentine.com> <20040729084928.GR10377@suse.de> <1091166553.1982.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091166553.1982.9.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30 2004, Robert Love wrote:
> On Thu, 2004-07-29 at 10:49 +0200, Jens Axboe wrote:
> 
> > Looks pretty perfect, maybe it's read-ahead screwing it up. Try if
> > setting hdparm -a0 /dev/hdc makes a difference.
> 
> I am seeing similar errors[1] on later 2.6, too, with about 50% of my
> audio CD collection.  Some work, some do not.  I see no pattern.
> 
> Already tried disabling read-ahead, does not matter.  Also tried a
> different drive.

read-ahead doesn't matter on ripping audio, just for fs work.

The audio problems might be fixed in 2.6.8-rc1-mm1 + the bounce patch
posted a few times (unfortunately 2.6.8-rc2-mm1 drops the patch for some
reason).

> 	Robert Love
> 
> [1] 
> hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: command error: error=0x54
> end_request: I/O error, dev hdc, sector 8
> Buffer I/O error on device hdc, logical block 1

So this happens during ripping, or? The problem with the errors like the
above is that they don't indicate a specific problem. I can't just look
at the error and see what causes it, it could be a million things.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUG3F5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUG3F5Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 01:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267622AbUG3F5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 01:57:15 -0400
Received: from peabody.ximian.com ([130.57.169.10]:22973 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267619AbUG3F5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 01:57:13 -0400
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
From: Robert Love <rml@ximian.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040730055333.GC7925@suse.de>
References: <20040728053107.GB11690@suse.de>
	 <c93051e8040727235123a6ed67@mail.gmail.com>
	 <20040728065319.GD11690@suse.de> <20040728145228.GA9316@redhat.com>
	 <20040728145543.GB18846@devserv.devel.redhat.com>
	 <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de>
	 <1091051858.13651.1.camel@camp4.serpentine.com>
	 <20040729084928.GR10377@suse.de> <1091166553.1982.9.camel@localhost>
	 <20040730055333.GC7925@suse.de>
Content-Type: text/plain
Date: Fri, 30 Jul 2004 01:57:11 -0400
Message-Id: <1091167031.1982.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 07:53 +0200, Jens Axboe wrote:

> read-ahead doesn't matter on ripping audio, just for fs work.

This isn't ripping, just playing.

> The audio problems might be fixed in 2.6.8-rc1-mm1 + the bounce patch
> posted a few times (unfortunately 2.6.8-rc2-mm1 drops the patch for some
> reason).

Yah, I will retest with 2.6.8-rc2-mm1.

> > [1] 
> > hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> > hdc: command error: error=0x54
> > end_request: I/O error, dev hdc, sector 8
> > Buffer I/O error on device hdc, logical block 1
> 
> So this happens during ripping, or?

During playback.  Or any poking of the drive whatsoever, actually.

There will be multiple errors on different blocks, until ultimately IDE
times out and does an ATAPI reset.

> The problem with the errors like the above is that they don't
> indicate a specific problem. I can't just look at the error and see
> what causes it, it could be a million things.

I know :P

	Robert Love





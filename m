Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbUCTJ6c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 04:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbUCTJ6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 04:58:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14305 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263293AbUCTJ62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 04:58:28 -0500
Date: Sat, 20 Mar 2004 10:58:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040320095820.GC2711@suse.de>
References: <20040319153554.GC2933@suse.de> <200403200140.59543.bzolnier@elka.pw.edu.pl> <405B936C.50200@pobox.com> <200403200224.14055.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403200224.14055.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20 2004, Bartlomiej Zolnierkiewicz wrote:
> > >>All drives that support flush-cache list the relevant bits in
> > >>identify-device, even on pre-ATA-6 devices.  Whether the feature was
> > >>optional or mandantory, we can check the feature bits.
> > >
> > > Hm. so this is undocumented in the spec?
> >
> > ?  When it was optional, there was a feature bit to test.  When it
> > became mandantory, the feature bit to test stayed in there.  The feature
> > bit is zero, otherwise.  Makes it possible to use "just test the bit"
> > and have things Just Work(tm).  :)
> 
> I wish it was so simple.  Here is an example to make it clear:
> 
> model: WDC WD800JB-00CRA1 firmware: 17.07W77
> word 0x83 is 4b01, word 0x86 is 0x0801
> 
> and drive of course supports CACHE FLUSH command.

I agree with Bart, it's usually never that clear. Quit harping the
stupid LG issue, they did something brain dead in the firmware and I
almost have to say that they got what they deserved for doing something
as _stupid_ as that.

Jeff, it's wonderful to think that you can always rely on checking spec
bits, but in reality it never really 'just works out' for any given set
of hardware.

-- 
Jens Axboe


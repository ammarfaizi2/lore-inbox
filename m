Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261167AbREXKTx>; Thu, 24 May 2001 06:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261173AbREXKTn>; Thu, 24 May 2001 06:19:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25359 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261167AbREXKTa>;
	Thu, 24 May 2001 06:19:30 -0400
Date: Thu, 24 May 2001 12:19:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Dying disk and filesystem choice.
Message-ID: <20010524121936.I12470@suse.de>
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au> <200105240658.f4O6wEWq031945@webber.adilger.int> <20010524103145.A9521@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010524103145.A9521@gruyere.muc.suse.de>; from ak@suse.de on Thu, May 24, 2001 at 10:31:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24 2001, Andi Kleen wrote:
> On Thu, May 24, 2001 at 12:58:14AM -0600, Andreas Dilger wrote:
> > Well reiserfs is probably a very bad choice at this point.  It
> > does not have any bad blocks support (yet), so as soon as you have
> > a bad block you are stuck.
> 
> reiserfs doesn't, but the HD usually has transparently in its firmware.
> So it hits a bad block; you see an IO error and the next time you hit
> the block the firmware has mapped in a fresh one from its internal
> reserves.

In fact you will typically only see an I/O error if the drive _can't_
remap the sector anymore, because it has run out. No point in reporting
a condition that was recovered.

I'd still say, that if you get bad block errors reported from your disk
it's long overdue for replacement.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263415AbREXIdD>; Thu, 24 May 2001 04:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263414AbREXIcx>; Thu, 24 May 2001 04:32:53 -0400
Received: from ns.suse.de ([213.95.15.193]:3858 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263413AbREXIcn>;
	Thu, 24 May 2001 04:32:43 -0400
Date: Thu, 24 May 2001 10:31:45 +0200
From: Andi Kleen <ak@suse.de>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: monkeyiq <monkeyiq@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: Dying disk and filesystem choice.
Message-ID: <20010524103145.A9521@gruyere.muc.suse.de>
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au> <200105240658.f4O6wEWq031945@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105240658.f4O6wEWq031945@webber.adilger.int>; from adilger@turbolinux.com on Thu, May 24, 2001 at 12:58:14AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 12:58:14AM -0600, Andreas Dilger wrote:
> Well reiserfs is probably a very bad choice at this point.  It
> does not have any bad blocks support (yet), so as soon as you have
> a bad block you are stuck.

reiserfs doesn't, but the HD usually has transparently in its firmware.
So it hits a bad block; you see an IO error and the next time you hit
the block the firmware has mapped in a fresh one from its internal
reserves.

-Andi

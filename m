Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284316AbRLBUax>; Sun, 2 Dec 2001 15:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282920AbRLBUae>; Sun, 2 Dec 2001 15:30:34 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:34688 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S282922AbRLBUac>;
	Sun, 2 Dec 2001 15:30:32 -0500
Date: Tue, 27 Nov 2001 02:39:24 +0000
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011127023923.A38@toy.ucw.cz>
In-Reply-To: <20011125133020.C1811@emma1.emma.line.org> <20011125150433.CEAE889CAD@pobox.com> <20011125173125.A13119@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011125173125.A13119@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Sun, Nov 25, 2001 at 05:31:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > "Power off during write operations may make an incomplete sector which
> > will report hard data error when read. The sector can be recovered by a
> > rewrite operation."
> 
> So the proper defect management would be to simply initialize the broken
> sector once a fsck hits it (still, I've never seen disks develop so many
> bad blocks so quickly as those failed DTLA-307045 drives I had).
> 
> Note, the specifications say that the write cache setting is ignored
> when the drive runs out of spare blocks for reassignment after defects
> (so that the drive can return the error code right away when it cannot
> guarantee the write actually goes to disk).

They should turn off write-back after number-of-spare-block < cache-size,
otherwise they are not safe.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


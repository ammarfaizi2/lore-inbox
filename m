Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbRACJJC>; Wed, 3 Jan 2001 04:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRACJIx>; Wed, 3 Jan 2001 04:08:53 -0500
Received: from box-154.rosh.inter.net.il ([213.8.204.154]:37639 "EHLO
	callisto.yi.org") by vger.kernel.org with ESMTP id <S129507AbRACJIi>;
	Wed, 3 Jan 2001 04:08:38 -0500
Date: Wed, 3 Jan 2001 10:29:47 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in prune_dcache (2.4.0-prerelease)
In-Reply-To: <Pine.LNX.4.10.10101021946310.1024-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101031022200.6614-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, Linus Torvalds wrote:

> On Wed, 3 Jan 2001, Udo A. Steinberg wrote:
> > 
> > While under massive disk and cpu load, 2.4.0-prerelease produced
> > the following oops (decode see below)

[..]

> Now, I assume this machine has been historically stable, with no history
> of memory corruption problems.. It's entirely possible (and likely) that
> the one-bit error is due to some wild kernel pointer. Which makes this
> _really_ hard to debug.

After a bit of few code reviewing, it looks like the only code that
assigns stuff to ->d_op in a nonstandard way is in fs/vfat/namei.c. 

Udo, are you using vfat?

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBGX5V>; Wed, 7 Feb 2001 18:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBGX5C>; Wed, 7 Feb 2001 18:57:02 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:32783 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129027AbRBGX47>; Wed, 7 Feb 2001 18:56:59 -0500
Date: Wed, 07 Feb 2001 18:56:40 -0500
From: Chris Mason <mason@suse.com>
To: Jeff.McWilliams@acetechnologies.net, linux-kernel@vger.kernel.org
Subject: Re: reiserfs - problems mounting after power outage
Message-ID: <816580000.981590200@tiny>
In-Reply-To: <20010207173143.7AC5E1805F@mail.acetechnologies.net>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, February 07, 2001 12:31:43 PM -0500 Jeff McWilliams <Jeff.McWilliams@acetechnologies.net> wrote:

> I'm having difficulty mounting a reiserfs partition after a power outage.
> 
> This is 2.4.0-test9 compiled with reiserfs as a module, and 

Which reiserfs version is this?  Upgrading to the reiserfs included in 2.4.1 would be a good plan, there have been a few bug fixes since test9 times (none specfically related to this).

> the ide.2.4.0-t9-6.task.0923.path IDE patch - mostly to get updated support for
> the 3WARE IDE RAID controller.  
> 

If this raid controller has writeback cache, make sure you either have a battery backup for the cache, or have writeback turned off.

> /dev/sda is the 3ware escalade raid mirror - two Maxtor 20 gig drives.
> 
> reiserfs is compiled as a module, the distribution is Debian Linux 
> "Potato"
> 
[ ... ]

> The partition I'm having trouble with is /dev/sda7.  /dev/sda6 recovered okay.
> /dev/sda7 doesn't have a lot of data on it, and I CAN deal with the lost data,
> but it doesn't leave me with a very good feeling of confidence in reiserfs
> if I can't successfully recover from a power failure.
> 
> 
> What happens when I type mount /dev/sda7 is this:
> 
> reiserfs: using 3.5.x disk format
> reiserfs: checking transaction log (device 08:07) ...
> 
> and then it hangs.  I then have to hit the reset button to reboot.
> 

How hung is it?  Does the whole system stop, or does this mount just block forever?

> I've tried running reiserfsck with --check, --correct-bitmap, 
> --rebuild-sb, and --rebuild-tree.  NO luck there.
> 

These programs also hang?  Does reiserfsck (which version BTW) give any output at all?

-chris


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

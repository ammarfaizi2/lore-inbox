Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293184AbSBQQqD>; Sun, 17 Feb 2002 11:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293186AbSBQQpx>; Sun, 17 Feb 2002 11:45:53 -0500
Received: from peace.netnation.com ([204.174.223.2]:26560 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S293184AbSBQQph>; Sun, 17 Feb 2002 11:45:37 -0500
Date: Sun, 17 Feb 2002 08:45:31 -0800
From: Simon Kirby <sim@netnation.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fsync delays for a long time.
Message-ID: <20020217164531.GA19111@netnation.com>
In-Reply-To: <20020215172436.GA6842@netnation.com> <Pine.LNX.3.96.1020217074231.30060G-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020217074231.30060G-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2002 at 07:47:38AM -0500, Bill Davidsen wrote:

> On Fri, 15 Feb 2002, Simon Kirby wrote:
> 
> > On Thu, Feb 14, 2002 at 12:51:14PM -0800, Andrew Morton wrote:
> > Not sure if this is related, but I still can't get 2.4 or 2.5 kernels to
> > actually read and write at the same time during a large file copy between
> > two totally separate devices (eg: from hda1 to hdc1).  "vmstat 1" shows
> > reads with no writing for about 6-8 seconds followed by writes with no
> > reading for about 5-6 seconds, repeat.
> 
> You don't have enough memory... you can probably tune bdflush to make the
> system flush writes more aggressively, but one cause is that you fill all
> available memory before bdflush even runs. Try setting the time way down,
> say one sec, and see if things change.
> 
> Note that this may not make the system run faster in any significant way,
> it may just get all the drive lights blinking.

This is happening on boxes with 1 GB of memory, etc... Besides that,
bdflush's first argument is a percentage, and that's what I was
adjusting.  And yes, I've set the percentage way down and it has
increased the rate at which it switches back and forth to make it look
like it's reading and writing at the same time, but it's not.  Throughput
never goes up.

This sort of thing works fine in 2.2 kernels...

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290215AbSBORZL>; Fri, 15 Feb 2002 12:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290228AbSBORZB>; Fri, 15 Feb 2002 12:25:01 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:7580 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S290215AbSBORYw>;
	Fri, 15 Feb 2002 12:24:52 -0500
Date: Fri, 15 Feb 2002 09:24:36 -0800
From: Simon Kirby <sim@netnation.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: fsync delays for a long time.
Message-ID: <20020215172436.GA6842@netnation.com>
In-Reply-To: <Pine.SGI.4.31.0202140951330.3076325-100000@fsgi03.fnal.gov> <E16bPqi-0000c5-00@the-village.bc.nu> <3C6C2342.5044B738@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6C2342.5044B738@zip.com.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 12:51:14PM -0800, Andrew Morton wrote:

> Alan Cox wrote:
> > 
> > > run my gdbm application and bonnie test on the same device.
> > > When gdbm comes to the point when it calls fsync it delays for a long
> > > time.
> > 
> > fsync on a very large file is very slow on the 2.2 kernels
> 
> This could very well be due to request allocation starvation.
> fsync is sleeping in __get_request_wait() while bonnie keeps
> on stealing all the requests.
> 
> Recall that patch you dropped on Tuesday? :)

Not sure if this is related, but I still can't get 2.4 or 2.5 kernels to
actually read and write at the same time during a large file copy between
two totally separate devices (eg: from hda1 to hdc1).  "vmstat 1" shows
reads with no writing for about 6-8 seconds followed by writes with no
reading for about 5-6 seconds, repeat.

Is there a patch available that could fix this?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]

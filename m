Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131831AbRA3CTj>; Mon, 29 Jan 2001 21:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131946AbRA3CT3>; Mon, 29 Jan 2001 21:19:29 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:37024 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131831AbRA3CTV>; Mon, 29 Jan 2001 21:19:21 -0500
Date: Tue, 30 Jan 2001 02:18:47 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: List User <lists@chaven.com>
cc: Chris Evans <chris@scary.beasts.org>, Tony.Young@ir.com, slug@slug.org.au,
        csa@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Disk Performance/File IO per process
In-Reply-To: <037d01c08a44$9bb9ace0$160912ac@stcostlnds2zxj>
Message-ID: <Pine.SOL.4.21.0101300215050.21740-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, List User wrote:

> Just wanted to 'chime' in here.  Yes this would be noisy and will have
> an affect on system performance however these statistics are what are
> used in conjunction with several others to size systems as well as to
> plan on growth.  If Linux is to be put into an enterprise environment
> these types of statistics will be needed.
> 
> When you start hooking up 100's of 'physical volumes' (be it real
> disks or raided logical drives) this data helps you pin-point
> problems.  I think the idea of having the ability to turn such
> accounting on/off via /proc entry a very nice method of doing things.

Question: how will the extra overhead of checking this configuration
compare with just doing it anyway?

If the code ends up as:

if (stats_enabled)
  counter++;

then you'd be better off keeping stats enabled all the time...

Obviously it'll be a bit more complex, but will the stats code be able to
remove itself completely when disabled, even at runtime??

Might be possible with IBM's dprobes, perhaps...?

> That way you can leave it off for normal run-time but when users
> complain or DBA's et al you can turn it on get some stats for a couple
> hours/days whatever, then turn it back off and plan an upgrade or
> re-create a logical volume or stripping set.

NT allows boot-time (en|dis)abling of stats; they quote a percentage for
the performance hit caused - 4%, or something like that?? Of course, they
don't say whether that's a 486 on a RAID array or a quad Xeon on IDE, so
the accuracy of that figure is a bit questionable...


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

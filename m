Return-Path: <linux-kernel-owner+w=401wt.eu-S1030188AbXALT4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbXALT4F (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 14:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbXALT4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 14:56:04 -0500
Received: from lucidpixels.com ([66.45.37.187]:45696 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030188AbXALT4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 14:56:03 -0500
Date: Fri, 12 Jan 2007 14:56:00 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Al Boldi <a1426z@gawab.com>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: Linux Software RAID 5 Performance Optimizations: 2.6.19.1:
 (211MB/s read & 195MB/s write)
In-Reply-To: <200701122235.30288.a1426z@gawab.com>
Message-ID: <Pine.LNX.4.64.0701121455550.6844@p34.internal.lan>
References: <Pine.LNX.4.64.0701111832080.3673@p34.internal.lan>
 <Pine.LNX.4.64.0701120934260.21164@p34.internal.lan>
 <Pine.LNX.4.64.0701121236470.3840@p34.internal.lan> <200701122235.30288.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2007, Al Boldi wrote:

> Justin Piszcz wrote:
> > RAID 5 TWEAKED: 1:06.41 elapsed @ 60% CPU
> >
> > This should be 1:14 not 1:06(was with a similarly sized file but not the
> > same) the 1:14 is the same file as used with the other benchmarks.  and to
> > get that I used 256mb read-ahead and 16384 stripe size ++ 128
> > max_sectors_kb (same size as my sw raid5 chunk size)
> 
> max_sectors_kb is probably your key. On my system I get twice the read 
> performance by just reducing max_sectors_kb from default 512 to 192.
> 
> Can you do a fresh reboot to shell and then:
> $ cat /sys/block/hda/queue/*
> $ cat /proc/meminfo
> $ echo 3 > /proc/sys/vm/drop_caches
> $ dd if=/dev/hda of=/dev/null bs=1M count=10240
> $ echo 192 > /sys/block/hda/queue/max_sectors_kb
> $ echo 3 > /proc/sys/vm/drop_caches
> $ dd if=/dev/hda of=/dev/null bs=1M count=10240
> 
> 
> Thanks!
> 
> --
> Al
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Ok. sec

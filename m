Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267237AbTAaOJf>; Fri, 31 Jan 2003 09:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267737AbTAaOJf>; Fri, 31 Jan 2003 09:09:35 -0500
Received: from mail018.syd.optusnet.com.au ([210.49.20.176]:44961 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S267237AbTAaOJd> convert rfc822-to-8bit; Fri, 31 Jan 2003 09:09:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: "Mike A. Harris" <mharris@redhat.com>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
Date: Sat, 1 Feb 2003 01:18:48 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301310907250.893-100000@devel.capslock.lan>
In-Reply-To: <Pine.LNX.4.44.0301310907250.893-100000@devel.capslock.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302010118.48446.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 Feb 2003 1:09 am, Mike A. Harris wrote:
> On Sat, 1 Feb 2003, Con Kolivas wrote:
> >Using the osdl hardware (http://www.osdl.org) with contest
> >(http://contest.kolivas.net) I've conducted a set of benchmarks with
> >different filesystems. Note that contest does not claim to be a throughput
> >benchmark.
> >
> >All of these use kernel 2.5.59
> >
> >First a set of contest benchmarks with the io load on a different hard
> > disk containing each of the four filesystems:
> >
> >io_other:
> >Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
> >2559ext3    3   89      84.3    2       5.5     1.13
> >2559reiser  3   87      86.2    2       5.7     1.10
> >2559jfs     3   87      86.2    3       5.7     1.10
> >2559xfs     3   87      86.2    2       4.5     1.10
> >
> >I found it interesting that there is virtually no difference in kernel
> >compilation time with all fs. However jfs consistently wrote more during
> > the io load than the other fs.
> >
> >
> >This is a set of benchmarks with the kernel compilation and load all
> > performed on each of the fs:
>
> Compilation is inherently CPU bound, not disk I/O bound, so
> compiling the kernel (or anything for that matter) isn't going to
> show any difference really because the CPU Mhz and L1/L2 cache
> are the bottleneck.

When the io load is on another hard disk yes, however the results do show 
differences when the load is on the same hard disk - these are two different 
tests. There is more to kernel compilation than just cpu usage.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbTAaN7G>; Fri, 31 Jan 2003 08:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267158AbTAaN7G>; Fri, 31 Jan 2003 08:59:06 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34183 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266473AbTAaN7F>; Fri, 31 Jan 2003 08:59:05 -0500
Date: Fri, 31 Jan 2003 09:09:04 -0500 (EST)
From: "Mike A. Harris" <mharris@redhat.com>
X-X-Sender: mharris@devel.capslock.lan
To: Con Kolivas <conman@kolivas.net>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
In-Reply-To: <200302010020.34119.conman@kolivas.net>
Message-ID: <Pine.LNX.4.44.0301310907250.893-100000@devel.capslock.lan>
Organization: Red Hat Inc.
X-Unexpected-Header: The Spanish Inquisition
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Feb 2003, Con Kolivas wrote:

>Using the osdl hardware (http://www.osdl.org) with contest 
>(http://contest.kolivas.net) I've conducted a set of benchmarks with 
>different filesystems. Note that contest does not claim to be a throughput 
>benchmark.
>
>All of these use kernel 2.5.59
>
>First a set of contest benchmarks with the io load on a different hard disk 
>containing each of the four filesystems:
>
>io_other:
>Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
>2559ext3    3   89      84.3    2       5.5     1.13
>2559reiser  3   87      86.2    2       5.7     1.10
>2559jfs     3   87      86.2    3       5.7     1.10
>2559xfs     3   87      86.2    2       4.5     1.10
>
>I found it interesting that there is virtually no difference in kernel 
>compilation time with all fs. However jfs consistently wrote more during the 
>io load than the other fs.
>
>
>This is a set of benchmarks with the kernel compilation and load all performed 
>on each of the fs:

Compilation is inherently CPU bound, not disk I/O bound, so 
compiling the kernel (or anything for that matter) isn't going to 
show any difference really because the CPU Mhz and L1/L2 cache 
are the bottleneck.


-- 
Mike A. Harris     ftp://people.redhat.com/mharris
OS Systems Engineer - XFree86 maintainer - Red Hat


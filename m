Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316976AbSFWGIT>; Sun, 23 Jun 2002 02:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316977AbSFWGIS>; Sun, 23 Jun 2002 02:08:18 -0400
Received: from spruce.woods.net ([166.70.175.33]:11192 "EHLO a.smtp.woods.net")
	by vger.kernel.org with ESMTP id <S316976AbSFWGIR>;
	Sun, 23 Jun 2002 02:08:17 -0400
Date: Sun, 23 Jun 2002 00:00:01 -0600 (MDT)
From: "Christopher E. Brown" <cbrown@woods.net>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Andrew Morton'" <akpm@zip.com.au>, <mgross@unix-os.sc.intel.com>,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
In-Reply-To: <20020623043310.GL22411@clusterfs.com>
Message-ID: <Pine.LNX.4.44.0206222350070.30350-100000@spruce.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2002, Andreas Dilger wrote:

> On Jun 22, 2002  22:02 -0600, Christopher E. Brown wrote:
> > On Thu, 20 Jun 2002, Griffiths, Richard A wrote:
> >
> > > I should have mentioned the throughput we saw on 4 adapters 6 drives was
> > > 126KB/s.  The max theoretical bus bandwith is 640MB/s.
> >
> > This is *NOT* correct.  Assuming a 64bit 66Mhz PCI bus your MAX is
> > 503MB/sec minus PCI overhead...
>
> Assuming you only have a single PCI bus...


Yes, we could (for example) assume a DP264 board, it features 2/4/8
way memory interleave, dual 21264 CPUs, and 2 separate PCI 64bit 66Mhz
buses.

However, multiple busses are *rare* on x86.  There are alot of chained
busses via PCI to PCI bridge, but few systems with 2 or more PCI
busses of any type with parallel access to the CPU.


 --
I route, therefore you are.


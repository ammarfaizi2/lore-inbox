Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSFTP0e>; Thu, 20 Jun 2002 11:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSFTP0d>; Thu, 20 Jun 2002 11:26:33 -0400
Received: from chfdns02.ch.intel.com ([143.182.246.25]:37883 "EHLO
	melete.ch.intel.com") by vger.kernel.org with ESMTP
	id <S315119AbSFTP0d>; Thu, 20 Jun 2002 11:26:33 -0400
Message-ID: <01BDB7EEF8D4D3119D95009027AE99951B0E63E4@fmsmsx33.fm.intel.com>
From: "Griffiths, Richard A" <richard.a.griffiths@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>
Cc: mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>
Subject: RE: ext3 performance bottleneck as the number of spindles gets la
	rge
Date: Thu, 20 Jun 2002 08:26:23 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We ran without highmem enabled so the Kernel only saw 1GB of memory.

Richard

-----Original Message-----
From: Jens Axboe [mailto:axboe@suse.de]
Sent: Wednesday, June 19, 2002 11:05 PM
To: Andrew Morton
Cc: mgross@unix-os.sc.intel.com; Linux Kernel Mailing List;
lse-tech@lists.sourceforge.net; richard.a.griffiths@intel.com
Subject: Re: ext3 performance bottleneck as the number of spindles gets
large


On Wed, Jun 19 2002, Andrew Morton wrote:
> mgross wrote:
> > 
> > We've been doing some throughput comparisons and benchmarks of block I/O
> > throughput for 8KB writes as the number of SCSI addapters and drives per
> > adapter is increased.
> > 
> > The Linux platform is a dual processor 1.2GHz PIII, 2Gig or RAM, 2U box.
> > Similar results have been seen with both 2.4.16 and 2.4.18 base kernel,
as
> > well as one of those patched up O(1) 2.4.18 kernels out there.
> 
> umm.  Are you not using block-highmem?  That is a must-have.
> 
>
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre9
aa2/00_block-highmem-all-18b-12.gz

please use

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.4/2.4.19-pre1
0/block-highmem-all-19.bz2

-- 
Jens Axboe

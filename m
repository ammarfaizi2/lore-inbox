Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263288AbSITR0V>; Fri, 20 Sep 2002 13:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263298AbSITR0V>; Fri, 20 Sep 2002 13:26:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58050 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263288AbSITR0U>;
	Fri, 20 Sep 2002 13:26:20 -0400
Date: Fri, 20 Sep 2002 19:31:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Mike Anderson <andmike@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Bond, Andrew" <Andrew.Bond@hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: TPC-C benchmark used standard RH kernel
Message-ID: <20020920173103.GK936@suse.de>
References: <45B36A38D959B44CB032DA427A6E106402D09E43@cceexc18.americas.cpqcorp.net> <3D8A3654.50201@us.ibm.com> <20020920172041.GB1944@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020920172041.GB1944@beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20 2002, Mike Anderson wrote:
> 
> Dave Hansen [haveblue@us.ibm.com] wrote:
> > Bond, Andrew wrote:
> > > This isn't as recent as I would like, but it will give you an idea.
> > > Top 75 from readprofile.  This run was not using bigpages though.
> > >
> > > 00000000 total                                      7872   0.0066
> > > c0105400 default_idle                               1367  21.3594
> > > c012ea20 find_vma_prev                               462   2.2212
> 
> > > c0142840 create_bounce                               378   1.1250
> > > c0142540 bounce_end_io_read                          332   0.9881
> 
> .. snip..
> > 
> > Forgive my complete ignorane about TPC-C...  Why do you have so much 
> > idle time?  Are you I/O bound? (with that many disks, I sure hope not 
> > :) )  Or is it as simple as leaving profiling running for a bit before 
> > or after the benchmark was run?
> 
> The calls to create_bounce and bounce_end_io_read are indications that
> some of your IO is being bounced and will not be running a peak
> performance. 
> 
> This is avoided by using the highmem IO changes which I believe are not
> in the standard RH kernel. Unknown if that would address your idle time
> question.

They benched RHAS iirc, and that has the block-highmem patch. They also
had more than 4GB of memory, alas, there is bouncing. That doesn't work
on all hardware, and all drivers.

-- 
Jens Axboe


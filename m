Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbSITROn>; Fri, 20 Sep 2002 13:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263212AbSITROn>; Fri, 20 Sep 2002 13:14:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:36094 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263211AbSITROk>; Fri, 20 Sep 2002 13:14:40 -0400
Date: Fri, 20 Sep 2002 10:20:41 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Bond, Andrew" <Andrew.Bond@hp.com>, linux-kernel@vger.kernel.org
Subject: Re: TPC-C benchmark used standard RH kernel
Message-ID: <20020920172041.GB1944@beaverton.ibm.com>
References: <45B36A38D959B44CB032DA427A6E106402D09E43@cceexc18.americas.cpqcorp.net> <3D8A3654.50201@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8A3654.50201@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave Hansen [haveblue@us.ibm.com] wrote:
> Bond, Andrew wrote:
> > This isn't as recent as I would like, but it will give you an idea.
> > Top 75 from readprofile.  This run was not using bigpages though.
> >
> > 00000000 total                                      7872   0.0066
> > c0105400 default_idle                               1367  21.3594
> > c012ea20 find_vma_prev                               462   2.2212

> > c0142840 create_bounce                               378   1.1250
> > c0142540 bounce_end_io_read                          332   0.9881

.. snip..
> 
> Forgive my complete ignorane about TPC-C...  Why do you have so much 
> idle time?  Are you I/O bound? (with that many disks, I sure hope not 
> :) )  Or is it as simple as leaving profiling running for a bit before 
> or after the benchmark was run?

The calls to create_bounce and bounce_end_io_read are indications that
some of your IO is being bounced and will not be running a peak
performance. 

This is avoided by using the highmem IO changes which I believe are not
in the standard RH kernel. Unknown if that would address your idle time
question.

-andmike

-- 
Michael Anderson
andmike@us.ibm.com


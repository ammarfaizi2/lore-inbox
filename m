Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292815AbSBVGRP>; Fri, 22 Feb 2002 01:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292811AbSBVGRF>; Fri, 22 Feb 2002 01:17:05 -0500
Received: from [210.0.172.57] ([210.0.172.57]:42757 "EHLO dog.ima.net")
	by vger.kernel.org with ESMTP id <S292815AbSBVGQu>;
	Fri, 22 Feb 2002 01:16:50 -0500
Date: Fri, 22 Feb 2002 14:16:44 +0800 (HKT)
From: Joe Wong <joewong@tkodog.no-ip.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: detect memory leak tools?
In-Reply-To: <Pine.LNX.4.10.10202211902290.842-100000@mikeg.wen-online.de>
Message-ID: <Pine.LNX.4.21.0202221416300.18868-100000@dog.ima.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

  Thanks for the suggestions. :)

- Joe

On Thu, 21 Feb 2002, Mike Galbraith wrote:

> On Thu, 21 Feb 2002, Richard B. Johnson wrote:
> 
> > On Thu, 21 Feb 2002, Joe Wong wrote:
> > 
> > > Hi,
> > > 
> > >   Is there any tools that can detect memory leak in kernel loadable 
> > > module?
> > > 
> > > TIA.
> > > 
> > > - Joe
> > 
> > How would it know? If you can answer that question, you have made
> > the tool. It would be specific to your module. FYI, in designing
> > such a tool, you often the find the leak, which means you don't
> > need the tool anymore.
> > 
> > I would start by temporarily putting a wrapper around whatever you
> > use for memory allocation and deallocation. The wrapper code keeps
> > track of pointer values and outstanding allocations. If the outstanding
> > allocations grow or if the pointers to whatever_free() are different
> > than the pointers to whatever_alloc(), you have a leak. You can read
> > the results from a private ioctl().
> 
> Close to how memleak works.  Wrap all allocators, and maintain a 1/32
> scale model of memory consisting of tags showing who allocated that
> ram-clod when.  Read allocation array via proc.
> 
> For most leaks, you're right.. the tool is too much horsepower for
> the problem.  Memleak has found some very non-trivial leaks though.
> It found one that was irritating Ingo quite a bit, and he designed
> memleak :)
> 
> 	-Mike
> 
> 

-- 



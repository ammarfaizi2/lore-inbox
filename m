Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271153AbTHLP66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271155AbTHLP66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:58:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46044 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271153AbTHLP6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:58:54 -0400
Date: Tue, 12 Aug 2003 17:58:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Timothy Miller <miller@techsource.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add an -Os config option
Message-ID: <20030812155847.GF569@fs.tum.de>
References: <20030811211145.GA569@fs.tum.de> <20030812080634.A19427@infradead.org> <3F390B36.5050709@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F390B36.5050709@techsource.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:43:50AM -0400, Timothy Miller wrote:
> 
> 
> Christoph Hellwig wrote:
> >On Mon, Aug 11, 2003 at 11:11:45PM +0200, Adrian Bunk wrote:
> >
> >>The patch below adds an option OPTIMIZE_FOR_SIZE (depending on EMBEDDED) 
> >>that changes the optimization from -O2 to -Os.
> >
> >
> >Please dropt the if EMBEDDED - this makes perfecty sense for lots of
> >todays hardware..
> >
> >In fact we should probably rather do some some benchmarking whether it
> >would be a good idea to make -Os the default.
> 
> 
> Interesting thought...  In reality, we want the system to spend as 
> little time in the kernel as possible.  If we've done that job right, 
> then optimizing for size shouldn't matter as much.  We're still spending 
> most of our time in user space.
> 
> Furthermore, it may be that we could benefit from compiling some source 
> files with -Os and others with -O2, depending on how critical they are 
> and how much they are ACTUALLY affected.
>...
> Comments?

First of all, compiling my own kernel with gcc 3.3.1 resulted in less 
than 10% difference in the size of the kernel image (and ACPI is not 
part of my kernel) - the mere difference in size isn't that important 
except for special needs (like boot _floppies_ or embedded systems 
with very limited memory).

The benchmarking Christoph was referring to was to check whether a 
kernel completely compiled with -Os is faster than a kernel compiled 
with -O2. This might sound strange, but if the code is smaller more fits 
into the cache and modern CPUs suffer much every time they need to 
access the incredibly slow RAM.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


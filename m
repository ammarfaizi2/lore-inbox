Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVLQXzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVLQXzy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 18:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVLQXzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 18:55:54 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40206 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965001AbVLQXzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 18:55:53 -0500
Date: Sun, 18 Dec 2005 00:55:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Robert Walsh <rjwalsh@pathscale.com>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 13/13] [RFC] ipath Kconfig and Makefile
Message-ID: <20051217235554.GW23349@stusta.de>
References: <200512161548.MdcxE8ZQTy1yj4v1@cisco.com> <200512161548.lokgvLraSGi0enUH@cisco.com> <20051217215251.GV23349@stusta.de> <1134860084.20575.101.camel@phosphene.durables.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134860084.20575.101.camel@phosphene.durables.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 02:54:44PM -0800, Robert Walsh wrote:
> > The driver shouldn't use assembler code and therefore no longer depend 
> > on X86_64.
> 
> Agreed about the assembler, but one way or the other, x86_64 is the only
> arch we support.
>...

There's a difference between "technically supported by the driver" and 
"officially supported for our costumers":

It's fine if you tell the costumers buying your hardware "anything else 
than 64bit x86_64 kernels is completely unsupported", but for getting 
your driver included into the kernel it should be 32bit clean [1] and 
should also work for people using 32bit kernels on an Opteron.

> > -O3 doesn't make much sense since the fight for producing the fastest 
> > code is between -O2 and -Os.
> 
> Makes many nanoseconds of difference to us for our latency numbers.  At
> the low latency numbers we measuring (1.29us), this is a very important
> difference to our customers.
>...

There's no doubt that this is important for your customers.

What surprises me is that -O3 turned out to be the fastest flag for you.

Can you send numbers comparing -Os/-O2/-O3 (without -g3, preferable with 
gcc 4.0) including a description what and how you are measuring?

> Regards,
>  Robert.

cu
Adrian

[1] not long ago, it used to be the other way round that drivers weren't
    64bit clean...

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


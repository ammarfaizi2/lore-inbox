Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbUH0OyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUH0OyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUH0OyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:54:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32740 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265799AbUH0OyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:54:22 -0400
Date: Fri, 27 Aug 2004 16:54:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, gregkh@us.ibm.com
Subject: Re: [2.4 patch][1/6] ibmphp_res.c: fix gcc 3.4 compilation
Message-ID: <20040827145416.GP12772@fs.tum.de>
References: <20040826195133.GB12772@fs.tum.de> <20040826195455.GC12772@fs.tum.de> <20040827120330.GD32707@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827120330.GD32707@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 09:03:31AM -0300, Marcelo Tosatti wrote:
> > 
> > The patch below fixes this issue by uninlining find_bus_wprev (as done 
> > in 2.6).
> 
> Just out of curiosity, if you move the inlined function up to the beginning of the 
> file (before any calls to it), and remove the declaration (at 45), does it
> stop complaining?

Yes it does.

For all these inline errors you can choose between uninlining and 
reordering the file.

In this case I did choose unlinlining because find_bus_wprev is 
uninlined in 2.6 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292766AbSCDSvk>; Mon, 4 Mar 2002 13:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292714AbSCDSub>; Mon, 4 Mar 2002 13:50:31 -0500
Received: from zero.tech9.net ([209.61.188.187]:23055 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292733AbSCDSuO>;
	Mon, 4 Mar 2002 13:50:14 -0500
Subject: Re: [PATCH] moving task_struct
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Roman Zippel <zippel@linux-m68k.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E16hqRx-0000cv-00@starship.berlin>
In-Reply-To: <Pine.LNX.4.21.0203012040220.32042-100000@serv>
	<3C7FEAC9.DDA73021@mandrakesoft.com>  <E16hqRx-0000cv-00@starship.berlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 13:50:06 -0500
Message-Id: <1015267808.15479.16.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-03-04 at 06:16, Daniel Phillips wrote:

> On March 1, 2002 09:55 pm, Jeff Garzik wrote:
> > nice...   In addition to your second patch, this first patch may be a
> > small step in paving the way for further unraveling of nasty include
> > dependencies.
> 
> Apropo of that, struct page needs to be defined before mmzone.h is
> included, so that inlines in mmzone.h can do arithmetic involving
> sizeof(struct page), instead of using macros.

Yep.

The preempt patch in 2.4 hit some of the uglies of sched.h.  Thankfully,
in 2.5 we use thread_info exclusive and Linus helped me remove all
sched.h dependencies - it is a big cleanup.  sched.h and its related and
interrelated dependencies are _not_ pretty.

Anything you do helps, Daniel ;)

	Robert Love


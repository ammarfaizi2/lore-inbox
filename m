Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270833AbTHOUqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270835AbTHOUqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:46:25 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16602 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270833AbTHOUqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:46:23 -0400
Date: Fri, 15 Aug 2003 22:46:14 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ISDN PCBIT: #ifdef MODULE some code
Message-ID: <20030815204614.GX569@fs.tum.de>
References: <20030728202500.GM25402@fs.tum.de> <20030815184720.B0E502CE86@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815184720.B0E502CE86@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 02:51:20AM +1000, Rusty Russell wrote:
> In message <20030728202500.GM25402@fs.tum.de> you write:
> > I got the following error at the final linkage of 2.6.0-test2 if 
> > CONFIG_ISDN_DRV_PCBIT is compiled statically:
> > 
> > <--  snip  -->
> > 
> > ...
> >   LD      .tmp_vmlinux1
> > ...
> > drivers/built-in.o(.exit.text+0xe183): In function `pcbit_exit':
> > : undefined reference to `pcbit_terminate'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> AFAICT This is also broken in 2.4.22-rc2, which makes me wonder if
> anyone actually cares about this driver?

It doesn't cause a compile error in 2.4.

This is inside an __exit function and in 2.4 __exit functions are 
discarded at link time when compiling a driver statically.

Due to changes Andi Kleen did in 2.6 __exit functions are no longer
discarded at link time when compiling a driver statically (they are
discarded at runtime).

> Taken anyway, for both.
> Rusty.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


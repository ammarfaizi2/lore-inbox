Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318830AbSICQKG>; Tue, 3 Sep 2002 12:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSICQKG>; Tue, 3 Sep 2002 12:10:06 -0400
Received: from pD9E23EAA.dip.t-dialin.net ([217.226.62.170]:12416 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318830AbSICQKF>; Tue, 3 Sep 2002 12:10:05 -0400
Date: Tue, 3 Sep 2002 10:14:01 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Oliver Pitzeier <o.pitzeier@uptime.at>
cc: Leslie Donaldson <donaldlf@cs.rose-hulman.edu>,
       <axp-kernel-list@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.5.33 successfully compiled
In-Reply-To: <200209031753.09814.o.pitzeier@uptime.at>
Message-ID: <Pine.LNX.4.44.0209031006001.3373-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I must admit that Alpha is a few more out of sync than it deserves.

On Tue, 3 Sep 2002, Oliver Pitzeier wrote:
> > 2. The following file need copied (a quick hack)
> >
> >          cd include/asm
> >           cp ../asm-i386/kmap_types.h  .

That's really a bad hack, if i386 kmap types match up with your 
expectations, you must be a lucky guy. i386 and alpha are still 100% 
different machines.

> I used the same quick-hack, but I was wondering why kmap_types.h is missing... 
> Any ideas? Anybody?

It wasn't introduced, I guess.

> > process.c: In function `alpha_clone':
> > process.c:268: too few arguments to function `do_fork'
> > process.c: In function `alpha_vfork':
> > process.c:277: too few arguments to function `do_fork'
> > make[1]: *** [process.o] Error 1
> > make[1]: Leaving directory

Yes, the syntax changed. 

> The same problems happens here. I'm currently searching for the changelog for 
> do_fork, so I may find out what arguments I should add to make this working 
> again. At the i386-tree there is sometimes "NULL" as the last argument added, 
> but I don't believe that it will be good to simply add "NULL" in every 
> function call. :o)

The NULL only needs to be non-NULL if we clone with CLONE_CLEARTID.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-


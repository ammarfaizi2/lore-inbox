Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318844AbSICQOZ>; Tue, 3 Sep 2002 12:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318845AbSICQOZ>; Tue, 3 Sep 2002 12:14:25 -0400
Received: from vivi.uptime.at ([62.116.87.11]:40657 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id <S318844AbSICQOY> convert rfc822-to-8bit;
	Tue, 3 Sep 2002 12:14:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Pitzeier <o.pitzeier@uptime.at>
Organization: UPtime system solutions
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: Kernel 2.5.33 successfully compiled
Date: Tue, 3 Sep 2002 18:18:16 +0200
User-Agent: KMail/1.4.2
Cc: Leslie Donaldson <donaldlf@cs.rose-hulman.edu>,
       <axp-kernel-list@redhat.com>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209031006001.3373-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209031006001.3373-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209031818.16140.o.pitzeier@uptime.at>
X-MailScanner: Nothing found, baby
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 18:14, Thunder from the hill wrote:
[ ... ]
> > I used the same quick-hack, but I was wondering why kmap_types.h is
> > missing... Any ideas? Anybody?
>
> It wasn't introduced, I guess.

No. It seems simply missing. In 2.5.32 it is there. On the right place. :o))))

> > > process.c: In function `alpha_clone':
> > > process.c:268: too few arguments to function `do_fork'
> > > process.c: In function `alpha_vfork':
> > > process.c:277: too few arguments to function `do_fork'
> > > make[1]: *** [process.o] Error 1
> > > make[1]: Leaving directory
>
> Yes, the syntax changed.

I saw. But how should it be called now from within process.c?

> > The same problems happens here. I'm currently searching for the changelog
> > for do_fork, so I may find out what arguments I should add to make this
> > working again. At the i386-tree there is sometimes "NULL" as the last
> > argument added, but I don't believe that it will be good to simply add
> > "NULL" in every function call. :o)
>
> The NULL only needs to be non-NULL if we clone with CLONE_CLEARTID.

I c...

That what I expected.

-- 
Oliver Pitzeier
UNIX Administrator
-
Linux 2.4.19 i686     Load: 0.59 0.37 0.32

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSBGIxX>; Thu, 7 Feb 2002 03:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSBGIxO>; Thu, 7 Feb 2002 03:53:14 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:39665 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S286339AbSBGIxB>; Thu, 7 Feb 2002 03:53:01 -0500
Message-Id: <200202070852.g178qoPN001986@tigger.cs.uni-dortmund.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Wed, 06 Feb 2002 14:16:27 GMT." <E16YSs7-0005GY-00@the-village.bc.nu> 
Date: Thu, 07 Feb 2002 09:52:49 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> "Christoph Rohland" at Feb 06, 2002 11:36:56 AM said:
> X-Mailer: ELM [version 2.5 PL6]
> MIME-Version: 1.0
> Sender:  linux-kernel-owner@vger.kernel.org
> Precedence: bulk
> X-Mailing-List: linux-kernel@vger.kernel.org
> X-UIDL:  70dcc828dc0f5fc32828144e3bf3c08c
> 
> > > If you are going to cat it onto the end of the kernel image just
> > > mark it __initdata and shove a known symbol name on it. It'll get
> > > dumped out of memory and you can find it trivially by using tools on
> > > the binary
> > 
> > What about putting such info into a (swappable) tmpfs file with
> > shmem_file_setup?
> 
> That is indeed an extremely cunning plan. Paticularly as /proc/config can
> be a symlink to it

Right. If I take my .config, get just non-"n" entries, get rid of the
CONFIG_ at each line, then gzip(1) the result, I get 1515 _bytes_. Less
than the rounding error in a module, can be expanded on the fly with
existing infrastructure.

Sure, it makes sense to have .config around somehow for some rather
specialized cases, but kludgeing on some such functionality for a very
niche use just stinks, IMHO.
-- 
Horst von Brand			     http://counter.li.org # 22616

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318426AbSGaSN5>; Wed, 31 Jul 2002 14:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318427AbSGaSN5>; Wed, 31 Jul 2002 14:13:57 -0400
Received: from [195.39.17.254] ([195.39.17.254]:2432 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318426AbSGaSN4>;
	Wed, 31 Jul 2002 14:13:56 -0400
Date: Tue, 30 Jul 2002 11:58:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
Message-ID: <20020730095845.GB331@elf.ucw.cz>
References: <Pine.LNX.4.44.0207242222410.1231-100000@home.transmeta.com> <Pine.GSO.4.21.0207250739390.17037-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0207250739390.17037-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Note that there is one place where 64 bits is simply _too_ expensive, and
> > that's the page cache. In particular, the "index" in "struct page". We
> > want to make "struct page" _smaller_, not larger.
> > 
> > Right now that means that 16TB really is a hard limit for at least some
> > device access on a 32-bit machine with a 4kB page-size (yes, you could
> > make a filesystem that is bigger, but you very fundamentally cannot make
> > individual files larger than 16TB).
> 
> ITYM "8Tb" - indices are signed, IIRC.  OTOH, it's not 2^31 * PAGE_SIZE -
> it's 2^31 * PAGE_CACHE_SIZE, which can be bigger.
> 
> Al, still thinking that anybody who does mkfs.<whatever> on a multi-Tb
> device should seek professional help of the kind they don't give on
> l-k...

Why?

Its Linux's job to make this work. If I happen to own 20 120GB disks,
whats wrong with just mkfs on them? If mkfs.ext3 on 2TB array is
reason for seeking profesional help, then there's something wrong with
Linux.
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

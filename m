Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276230AbRI1Sds>; Fri, 28 Sep 2001 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276045AbRI1Sdk>; Fri, 28 Sep 2001 14:33:40 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:3588 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S276229AbRI1Sdd>; Fri, 28 Sep 2001 14:33:33 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200109281833.UAA00831@green.mif.pg.gda.pl>
Subject: Re: Kernel 2.4.10 /proc/partitions
To: shewp@pblx.net
Date: Fri, 28 Sep 2001 20:33:28 +0200 (CEST)
Cc: andre@sam.com.br, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I also have this problem as mentioned before.
> 
> The problem cropped up between 2.4.10-pre5 and 2.4.10-pre6, 
> I did some checking. pre5 is fine, pre6 is broken.
> 
> >From what I saw, my guess is that
> genhd.c and the gendisk rewrites might be related.
> 
> Unfortunately have no time to look at it until mid-October-
> any help appreciated. 

I used to observe similar problem many kernels ago (2.1.x ?).
Then it was related to a module not removing its gendisk from the
list when unloading. The list became circular at its next modification.

Maybe something similar ?

> >  major minor  #blocks  name
> > 
> >    8     0   17692672 sda
> >    8     1      32098 sda1
> >    8     2      32130 sda2
> >    8     3    4096575 sda3
> >    8     4   13526730 sda4
> >    8     0   17692672 sda
> >    8     1      32098 sda1
> >    8     2      32130 sda2
> >    8     3    4096575 sda3
[...]
> > the cat command never stop to list.

Andrzej


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk

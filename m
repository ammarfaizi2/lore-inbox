Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbRE3K24>; Wed, 30 May 2001 06:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262711AbRE3K2q>; Wed, 30 May 2001 06:28:46 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:47004 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262706AbRE3K2f>; Wed, 30 May 2001 06:28:35 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200105301028.MAA23790@sunrise.pg.gda.pl>
Subject: Re: [PATCH] net #9
To: hps@intermeta.de
Date: Wed, 30 May 2001 12:28:04 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9f2enn$jbr$1@forge.intermeta.de> from "Henning P. Schmiedehausen" at May 30, 2001 09:32:39 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen wrote:"
> Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl> writes:
> 
> >-static char	name[4][IFNAMSIZ] = { "", "", "", "" };
> 
> >+static char	name[4][IFNAMSIZ];
> 
> Ugh. Sure about that one? the variables have been pointers to zero,
> now they're zero...

I do not agree. As I understand C "name" is a table, i.e. a pointer to a
prealocated area of size of 4*IFNAMSIZ*sizeof(char) bytes. There is no
pointers to the strings stored seprately. 
[ The strings are copied into the apropriate locations in the array during
  initialization ]

After applying the mentioned patch just the whole area of the array will be
zeroed. Not only the first characters of name[i] i=0,1,2,3 ...

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSLPAJs>; Sun, 15 Dec 2002 19:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263362AbSLPAJs>; Sun, 15 Dec 2002 19:09:48 -0500
Received: from elin.scali.no ([62.70.89.10]:59920 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S263313AbSLPAJr>;
	Sun, 15 Dec 2002 19:09:47 -0500
Date: Mon, 16 Dec 2002 01:17:30 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to do -nostdinc?
In-Reply-To: <1357.1039954001@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0212160110040.1030-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Dec 2002, Keith Owens wrote:

> There are two ways of setting the -nostdinc flag in the kernel Makefile :-
> 
> (1) -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
> (2) -nostdinc -iwithprefix include
> 
> The first format breaks with non-English locales, however the fix is trivial.
> 
> (1a) -nostdinc $(shell LANG=C $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
> 
> The second format is simpler but there have been reports that it does
> not work with some versions of gcc.  I have been unable to find a
> definitive statement about which versions of gcc fail and whether the
> problem has been fixed.  Anybody care to provide a definitive
> statement?
> 
> If kernel build cannot rely on gcc working with -nostdinc -iwithprefix include
> then we need to convert to (1a).

Well, it works fine with gcc-2.91.66 (egcs-1.1.2 release), gcc-2.96 (RH 
7.{1,2,3} versions), and gcc-3.2 (RH 8.0 version)

Of course there are other versions out there but 2.91 is rather old...

Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY


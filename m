Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSGNCQN>; Sat, 13 Jul 2002 22:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSGNCQM>; Sat, 13 Jul 2002 22:16:12 -0400
Received: from p50886DAC.dip.t-dialin.net ([80.136.109.172]:38532 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315593AbSGNCQL>; Sat, 13 Jul 2002 22:16:11 -0400
Date: Sat, 13 Jul 2002 20:19:02 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [SCRIPT] kbuild-2.4/2.5 symbol export parser
Message-ID: <Pine.LNX.4.44.0207132002030.3331-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one checks if your Makefile's and Makefile.in's report the correct 
files exporting symbols. A file that exports symbols must be listed. This 
script checks whether files that export symbols are set in expsyms and its 
kbuild-2.4 equivalent, and whether the files listed there really export 
symbols.

It's quite a kludge. I don't do the parsing on my own here, since I'm just 
as lazy as you, but I use the (in)famous grep for each file.

Lots of stuff, produces result and tmp files only in a special directory 
called ".deps" (because some of the code was inherited from another script 
of mine that computer dependencies for kbuild-2.5 Makefile.in's and thus 
created them automagically).

Usage: go to your kernel tree (main directory) and run the script there 
without parameters. Takes me a minute to run on my Alpha, produces approx. 
270 kB of output files. Requires find, grep, diff, sort and, of course, 
perl.

<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/tools/expsyms-check.pl.bz2>

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------


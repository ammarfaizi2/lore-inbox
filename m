Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSGNUDH>; Sun, 14 Jul 2002 16:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSGNUDG>; Sun, 14 Jul 2002 16:03:06 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:45554 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S317056AbSGNUDF>; Sun, 14 Jul 2002 16:03:05 -0400
Date: Sun, 14 Jul 2002 22:04:21 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207142004.g6EK4LaV019433@burner.fokus.gmd.de>
To: schilling@fokus.gmd.de, szepe@pinerecords.com
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Tomas Szepe <szepe@pinerecords.com>

>> >A Pentium 1200, eh?
>> >More like Pentium 120 or star just doesn't cut it.
>> 
>> star uses less CPU time than GNU tar. As GNU tar uses a proprietary 
>> archive format, I never use it if I may avoid to use it.

>How does this relate to the test? I got the archive directly off your
>ftp site -> the software has been dealing with exactly the same format
>in both cases.

Well. it took me only 8 years of repeated bug reports to make the GNU tar
maintaners fix the worst problems so it is finally able to extract standard 
compliant tar archives ;-).

As recent GNU tar is still unable to _list_ those tar files correctly
(try ftp://ftp.fokus.gme.de/pub/unix/star/testscripts/gtarfail.tar
and ftp://ftp.fokus.gme.de/pub/unix/star/testscripts/gtarfail2.tar),
I would never trust GNU tar. A program that behaves inconsistent in
list vs. extract mode is not what I like to use.

The real problem of GNU tar is that is does still not create POSIX.1-1988
compliantarchives while star is able to create POSIX.1-2001 archives for a year.
This causes that many archives out on ftp servgers cannot be unpacked using
compliant implementations.

To understand the problem, please fetch a recent star distribution and use the
contained program 'tartest' together with 

ftp://ftp.fokus.gme.de/pub/unix/star/testscripts/ustar-all-quicktest.tar

and the instructions in: 

ftp://ftp.fokus.gme.de/pub/unix/star/testscripts/README.quicktest

to find the POSIX deviations in GNU tar.

>> >Athlon 1GHz:
>> 
>> >kala@nibbler:/tmp/1$ time tar xjf rock.tar.bz2
>> >real    3m19.703s
>> >user    0m9.870s
>> >sys     0m24.840s
>> 
>> >According to top, the system was ~90% idle during the extraction.
>> >Linux 2.4.19-rc1-ac3, reiserfs 3.6.
>> 
>> Well, I wrote that this has been done with ext3 (I also checked ext2
>> which is approx. the same speed.
>> I don't have access to a reiserfs system that has not been compiled
>> with debug and I don't like to put out false statements.

>I honestly doubt ext3 would perform significantly worse than what I've
>observed with reiserfs.

Just try it, I did try it.

>Never mind, however, the sole aim of my having tested the extraction of
>rock.tar.bz2 was to show how easily you get to accuse people on lkml of
>being incompetent w/o having any real support for your claims.

It was (as I mentioned before) to show that there need to be some sort 
of high level coordination to make Linux better and address the needs of the 
future.

>> >PS. Solaris is over 60% slower than Linux 2.2/2.4 in common fs
>> >operations on my SMP SPARCstation 10.
>> 
>> If you make such statements, it would help a lot of you would mention
>> the Solaris version you are running. I am always running a recent
>> Solaris beta kernel - you may have used an outdated version.

>Umm, let's see if I can fish out the install media from somewhere...
>jup, Solaris 2.6 5/98.

So did you compare Solaris performance with a 4 year old Linux?

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix

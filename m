Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313083AbSELMzR>; Sun, 12 May 2002 08:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSELMzQ>; Sun, 12 May 2002 08:55:16 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:20999 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313083AbSELMzP>; Sun, 12 May 2002 08:55:15 -0400
Date: Sun, 12 May 2002 14:54:39 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre8-ac2 kbuild 2.4 tmp_include_depends
Message-ID: <20020512125439.GE3749@louise.pinerecords.com>
In-Reply-To: <20020512103946.GB3749@louise.pinerecords.com> <22944.1021206179@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 1 day, 4:41)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Keith Owens <kaos@ocs.com.au>, May-12 2002, Sun, 22:22 +1000]
> On Sun, 12 May 2002 12:39:46 +0200, 
> Tomas Szepe <szepe@pinerecords.com> wrote:
> >> [Keith Owens <kaos@ocs.com.au>, May-12 2002, Sun, 20:11 +1000]
> >> Missed one occurrence of .tmp_include_depends.  Edit Makefile, find
> >> $(patsubst %, _dir_%, $(SUBDIRS)) and change .tmp_include_depends to
> >> tmp_include_depends (no '.' at start).
> >> 
> >> Corrected patch against 2.4.19-pre8-ac2.
> >
> >Great work, Keith!
> >"make modules_install" takes like 2 seconds w/ -ac now!
> 
> That was not the aim (although I will accept the praise :).  The patch
> ensures that cross directory header dependencies are done correctly on
> kbuild 2.4.  Any speed up as a side effect of removing .hdepend from
> Rules.make is a bonus.

Now these are some side effects I like!

<cut>
2.4.19-pre8-ac1:
$ time make dep clean bzImage modules
...
real    6m22.176s

$ time su -c 'make modules_install'
...
real    0m6.963s

----

2.4.19-pre8-ac2 + patch-2.4.19-pre8-ac2-kbuildfix2:
$ time make dep clean bzImage modules
...
real    5m57.509s

$ time su -c 'make modules_install'
...
real    0m2.255s
<cut>

> kbuild mantra - correctness first, speed second.

Thumbs up!


T.

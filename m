Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUGVT1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUGVT1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 15:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUGVT1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 15:27:46 -0400
Received: from mail.timesys.com ([65.117.135.102]:59571 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261252AbUGVT1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 15:27:41 -0400
Subject: Re: case-sensitive file names during build
From: Pragnesh Sampat <pragnesh.sampat@timesys.com>
To: dank@kegel.com
Cc: hollisb@us.ibm.com, christopher.faylor@timesys.com,
       "Povolotsky, Alexander" <alexander.povolotsky@marconi.com>,
       crossgcc <crossgcc@sources.redhat.com>,
       "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
       Andrew Morton <akpm@osdl.org>, bert hubert <ahu@ds9a.nl>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3D848382FB72E249812901444C6BDB1D036EDF21@exchange.timesys.com>
References: <3D848382FB72E249812901444C6BDB1D036EDF21@exchange.timesys.com>
Content-Type: text/plain
Message-Id: <1090524458.8679.23.camel@pss-pc.timesys>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 22 Jul 2004 15:27:38 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2004 19:27:40.0859 (UTC) FILETIME=[F453F0B0:01C47021]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I maintain patches that allow building glibc on Cygwin and MacOSX.
> > The main patch deals with exactly this issue (S vs. s)
> >
> http://kegel.com/crosstool/crosstool-0.28-rc26/patches/glibc-2.3.2/glibc
> -2.3.2-cygwin.patch
> > I have to maintain it separately as the glibc maintainer dislikes the
> > idea of catering to Cygwin users (though maybe if I present it as a
> > MacOSX support patch he'd reconsider... naaah, probably not :-).  
> > 
> > With the advent of linux-2.6, I also have a patch to get kconfig to
> > not use shared libraries (since I use kconfig to help install the
> > kernel headers, and shared libraries are tricky to build on those two
> > platforms).   
> > 
> > It wouldn't be a big leap for me or someone else to also maintain a
> > patch to allow compiling the whole kernel on Cygwin or MacOSX. 
> > If anyone puts it together, I'll carry it in crosstool.

Dan,

We have some patches that we use at TimeSys that allow a linux kernel to
build on cygwin.  They fall under:

1. case insensitive issues
2. kconfig using shared library
3. header file issues under some cygwin versions (typically types.h)
4. arguments handling limited to 32K (large number of modules are issues
in Makefiles)

1 and 2 have already been discussed and Chris Faylor mentioned just a
while ago that with managed mounts under newer cygwin versions, this is
not a big issue for cygwin at least.

Sometime later today, I will send in the patches we are using for 2.6.6
that allow a full build, in case they are useful (at least the arguments
handling patch is a kludge, but I will send it in to start with).

-Pragnesh






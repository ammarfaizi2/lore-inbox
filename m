Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263287AbTCUGav>; Fri, 21 Mar 2003 01:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263288AbTCUGat>; Fri, 21 Mar 2003 01:30:49 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:25748 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S263287AbTCUGan>; Fri, 21 Mar 2003 01:30:43 -0500
Message-ID: <3E7AB38F.124B98E4@verizon.net>
Date: Thu, 20 Mar 2003 22:39:11 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.65 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Linux-kernel@vger.kernel.org, torvalds@transmeta.com, ak@suse.de,
       rml@tech9.net
Subject: Re: [PATCH] arch-independent syscalls to return long
References: <3E7AAD0C.B8CB2926@verizon.net> <20030320222358.454a1f4f.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [4.64.238.61] at Fri, 21 Mar 2003 00:41:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> "Randy.Dunlap" <randy.dunlap@verizon.net> wrote:
> >
> > Hi,
> >
> > I posted this about 1 month ago (as [RFC]), to no avail.
> > However, tonight Andi needs it for pause() [which is failing
> > on x86_64], and Robert Love mentioned converting the affinity
> > syscalls.  I had already done them, so here they are again.
> >
> 
> Thanks.  Is that all of them done now?

AFAIK, without guarantees.  I used a list from Jamie Lokier and then
went thru bunches of source files & syscalls myself and came up with
these.

There are still some syscall prototypes that are declared as int
instead of long, but I can't fix them tonight (zzz).  Examples:

	sys_sched_setaffinity
		arch/sparc64/, arch/ppc64/, arch/s390x/ (FIX PROTO)
	sys_sched_getaffinity
		arch/sparc64/, arch/ppc64/, arch/s390x/ (FIX PROTO)
	sys_remap_file_pages
		arch/sparc/ (FIX PROTO)
	sys_lookup_dcookie
		arch/sparc64/, arch/ppc64/, arch/parisc/ (FIX PROTO)


That's all that I know of.

~Randy

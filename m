Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315689AbSECUaC>; Fri, 3 May 2002 16:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315693AbSECUaB>; Fri, 3 May 2002 16:30:01 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61611 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315689AbSECUaA>;
	Fri, 3 May 2002 16:30:00 -0400
To: rwhron@earthlink.net
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: O(1) scheduler gives big boost to tbench 192 
In-Reply-To: Your message of Fri, 03 May 2002 09:38:56 EDT.
             <20020503093856.A27263@rushmore> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5347.1020457751.1@us.ibm.com>
Date: Fri, 03 May 2002 13:29:11 -0700
Message-Id: <E173jfz-0001OJ-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020503093856.A27263@rushmore>, > : rwhron@earthlink.net writes:
> > > > Rumor is that on some workloads MQ it outperforms O(1), but it
> > > > may be that the latest (post K3?) O(1) is catching up?
> 
> Is MQ based on the Davide Libenzi scheduler? 
> (a version of Davide's scheduler is in the -aa tree).
 
No - Davide's is another variant.  All three had similar goals
and similar changes.  MQ was the "first" public one written by
Mike Kravetz and Hubertus Franke with help from a number of others.

> tbench 192 is an anomaly test too.  AIM looks like a nice
> "mixed" bench.  Do you have any scripts for it?  I'd like 
> to use AIM too.
 
The SGI folks may be using more custom scripts.  I think there
is a reasonable set of options in the released package.  OSDL
might also be playing with it (Wookie, are you out here?).  Sequent
used to have a large set of scripts but I don't know where those
are at the moment.  I may check around.

> A side effect of O(1) in ac2 and jam6 on the 4 way box is a decrease 
> in pipe bandwidth and an increase in pipe latency measured by lmbench:

Not surprised.  That seems to be one of our problems with
volanomark testing at the moment and we have some hacks to help,
one in TCP which allows the receiver to be scheduled on a "close"
CPU which seems to help latency.  Others are tweaks of the
scheduler itself, with nothing conclusively better yet.

gerrit

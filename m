Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbTILCBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 22:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbTILCBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 22:01:12 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:14048 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261648AbTILCBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 22:01:11 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16225.10465.132753.695040@wombat.chubb.wattle.id.au>
Date: Fri, 12 Sep 2003 12:01:05 +1000
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] schedstat-2.6.0-test5-A1 measuring process scheduling latency 
In-Reply-To: <200309120102.h8C12NV07347@owlet.beaverton.ibm.com>
References: <16225.5591.442410.58842@wombat.chubb.wattle.id.au>
	<200309120102.h8C12NV07347@owlet.beaverton.ibm.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rick" == Rick Lindsley <ricklind@us.ibm.com> writes:


    
Rick> I'm not sure that it's any less or more intrusive, but it's at
Rick> least another way of doing the same thing.  So since you've
Rick> taken some measurements, what's the length of time you find your
Rick> process waits to hit the processor after getting the I/O it
Rick> needs?  What's the time it seems to wait when it skips (what's
Rick> the cutoff at which you hear a skip versus don't hear one?)


In short, time on the run queue is negligeable.  Time spend waiting
for disk I/O is extensive.  If you look at the graph, you'll see each
disk I/O takes 0.8 seconds, which is about the same as the skip.  This
is on ReiserFS 2.6, laptop (4000RPM) disk, but attached to mains
power.

There's a massive difference between the behaviour with hdparm -u1 and
hdparm -u0 --- I don't see skips with -u1, and the time the disk light
is on is much reduced.  This puts my problem in the IDE layer
somewhere -- which means it may not be the same problem others are
seeing.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.

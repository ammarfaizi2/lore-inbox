Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbTKRWZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 17:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTKRWZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 17:25:11 -0500
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:50314 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263801AbTKRWZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 17:25:05 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16314.39961.545212.446223@wombat.chubb.wattle.id.au>
Date: Wed, 19 Nov 2003 09:24:25 +1100
To: kernwek jalsl <edityacomm@yahoo.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: softirqd
In-Reply-To: <20031118063551.25057.qmail@web20710.mail.yahoo.com>
References: <Pine.LNX.4.53.0311170914580.22131@chaos>
	<20031118063551.25057.qmail@web20710.mail.yahoo.com>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Kernwek Jalsl said:

Kernwek> Sorry in case I was not very clear with my
Kernwek> requirements.   With real time interrupt I meant a
Kernwek> real time task waiting for IO from this interrupt.
Kernwek> Assume that I have a high priority interrupt and a
Kernwek> real time task waiting for it. Well followimg are the
Kernwek> various latencies involved:
Kernwek> L1- interrupt latency
Kernwek> L2- hard and soft IRQ completion
Kernwek> L3 - scheduler latency
Kernwek> L4 - scheduler completion

Kernwek> L1 is pretty acceptable on Linux. 

I've been trying to measure this.  On IA64 I'm measuring around
2.5microseconds (on a 900MHz machine).  I personally think that this
is too big, and could be reduced.

One thing I think we need to do early in 2.7 is to merge all those
architecture-dependent arch/XXX/kernel/irq.c files, and try to reduce
the amount of duplicated work done in the new merged file and the
lower level architecture-specific files.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*


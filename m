Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTLKECL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 23:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbTLKECL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 23:02:11 -0500
Received: from mail007.syd.optusnet.com.au ([211.29.132.55]:1727 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264339AbTLKECI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 23:02:08 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16343.60461.218583.753101@wombat.chubb.wattle.id.au>
Date: Thu, 11 Dec 2003 15:01:49 +1100
To: Hannu Savolainen <hannu@opensound.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Driver API (was Re: Linux GPL and binary module exception clause?)
In-Reply-To: <Pine.LNX.4.58.0312102256520.3787@zeus.compusonic.fi>
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org>
	<Pine.LNX.4.58.0312100714390.29676@home.osdl.org>
	<20031210153254.GC6896@work.bitmover.com>
	<Pine.LNX.4.58.0312100809150.29676@home.osdl.org>
	<20031210163425.GF6896@work.bitmover.com>
	<Pine.LNX.4.58.0312100852210.29676@home.osdl.org>
	<20031210175614.GH6896@work.bitmover.com>
	<Pine.LNX.4.58.0312100959180.29676@home.osdl.org>
	<20031210180822.GI6896@work.bitmover.com>
	<Pine.LNX.4.58.0312101016010.29676@home.osdl.org>
	<20031210183833.GJ6896@work.bitmover.com>
	<Pine.LNX.4.58.0312101108150.29676@home.osdl.org>
	<Pine.LNX.4.58.0312102256520.3787@zeus.compusonic.fi>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Hannu" == Hannu Savolainen <hannu@opensound.com> writes:


Hannu> Even better would be a proper device driver ABI for "loosely
Hannu> integrated" device drivers. 

One of the things we're working on here is an ABI to allow device
drivers to live in user space, by enabling access to interrupts and PCI
DMA.  Now that NPTL and fast system calls are available, it's possible
to write, say, an IDE driver, that performs almost as well as (and in
some cases better than) the in-kernel driver.

Developing and tuning drivers out-of-kernel is *much* easier than
developing a module that lives in the kernel.  Also, bugs in an
out-of-kernel driver are much less likely to affect the rest of the
kernel (although screwing up the SG-list you pass to the device can
do it)

Sound drivers would be ideal to move out of the kernel entirely, and
there's a student here working on that.

I'll be talking about some of this work at LCA2004, and intend to
release the code then too.


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

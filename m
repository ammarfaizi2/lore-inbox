Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTKQEeU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 23:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTKQEeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 23:34:20 -0500
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:18568 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263125AbTKQEeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 23:34:19 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16312.20420.533453.102220@wombat.chubb.wattle.id.au>
Date: Mon, 17 Nov 2003 15:34:12 +1100
To: public@mikl.as
Cc: linux-kernel@vger.kernel.org
Subject: Re: Userspace DMA
In-Reply-To: <200311161842.00253.public@mikl.as>
References: <200311161842.00253.public@mikl.as>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Miklas <public@mikl.as> writes:

Andrew> Hi, Is there an accepted way of doing userspace DMA with
Andrew> Linux?

I'm currently working on a framework for user-space device drivers,
that allow suitably privileged user-space programs to set up and tear
down dma regions -- essentially exposing pci_alloc_consistent and
pci_{un}map_sg to userspace -- and also to handle interrupts in user
space.  The framework is implemented as a pair of filesystems, one for
interrupts (actually, I hijack /proc/interrupts/*)  and one for
mappings --- mainly to allow easy cleanup when the userspace program
dies.

It's not yet in a fit state to release, but contact me offline if
you'd like a copy.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*



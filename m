Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVAMWW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVAMWW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVAMWWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:22:15 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:53135 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261764AbVAMWTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:19:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16870.62464.192905.778878@wombat.chubb.wattle.id.au>
Date: Fri, 14 Jan 2005 09:19:44 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <41E5C3E6.90906@yahoo.com.au>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com>
	<m1652ddljp.fsf@muc.de>
	<Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com>
	<41E4BCBE.2010001@yahoo.com.au>
	<20050112014235.7095dcf4.akpm@osdl.org>
	<Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com>
	<20050112104326.69b99298.akpm@osdl.org>
	<41E5AFE6.6000509@yahoo.com.au>
	<20050112153033.6e2e4c6e.akpm@osdl.org>
	<41E5B7AD.40304@yahoo.com.au>
	<Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
	<41E5BC60.3090309@yahoo.com.au>
	<Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
	<41E5C3E6.90906@yahoo.com.au>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nick Piggin wrote:

Nick> I would say that having arch-definable accessors for
Nick> the page tables wouldn't be a bad idea anyway, and the
Nick> flexibility may come in handy for other things.

Nick> It would be a big, annoying patch though :(

We're currently working in a slightly different direction, to try to
hide page-table implemention details from anything outside the page table
implementation.  Our goal is to be able to try out other page tables
(e.g., Liedtke's guarded page table) instead of the 2/3/4 level fixed
hierarchy.

We're currently working on a 2.6.10 snapshot; obviously we'll have to
roll up to 2.6.11 before releasing (and there are lots of changes
there because of the recent 4-layer page table implementation).

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263341AbTIWKkx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 06:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTIWKkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 06:40:53 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:35464 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261868AbTIWKkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 06:40:51 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16240.8965.91289.460763@wombat.chubb.wattle.id.au>
Date: Tue, 23 Sep 2003 20:40:05 +1000
To: "David S. Miller" <davem@redhat.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, peter@chubb.wattle.id.au, ak@suse.de,
       iod00d@hp.com, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <20030922232237.28a5ac4a.davem@redhat.com>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
	<20030919043847.GA2996@cup.hp.com>
	<20030919044315.GC7666@wotan.suse.de>
	<16234.36238.848366.753588@wombat.chubb.wattle.id.au>
	<20030919055304.GE16928@wotan.suse.de>
	<20030919064922.B3783@kvack.org>
	<16239.38154.969505.748461@wombat.chubb.wattle.id.au>
	<20030922203629.B21836@kvack.org>
	<20030922232237.28a5ac4a.davem@redhat.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

David> On Mon, 22 Sep 2003 20:36:29 -0400 Benjamin LaHaise
David> <bcrl@kvack.org> wrote:

>> Denied.  Dave, please explain.

David> Why should I have anything to explain? :-)

David> The fact that ia64 is doing a printk for an unaligned kernel
David> load or store is what you should be asking questions about :)

How expensive is it to take the trap and do a fix up, compared to
making an aligned copy?  As it involves raising and handling a fault
disassembling the instruction that caused the fault, etc., I'd be
surprised if it's much less than 1000 cycles, even without the printk,
although I haven't measured it yet, and can't find enough info in the
architecture manuals to know what it is.

Even if it's only 500 cycles, you can copy and realign a large packet
in that time. 

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.

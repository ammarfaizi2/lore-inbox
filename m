Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274813AbTHFDrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 23:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274815AbTHFDrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 23:47:47 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:10661
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S274813AbTHFDrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 23:47:46 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16176.31324.827466.49836@wombat.chubb.wattle.id.au>
Date: Wed, 6 Aug 2003 13:47:40 +1000
To: Grant Miner <mine0057@mrs.umn.edu>
CC: linux-kernel@vger.kernel.org
Subject: Filesystem Tests
In-Reply-To: <3F306858.1040202@mrs.umn.edu>
References: <3F306858.1040202@mrs.umn.edu>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Grant" == Grant Miner <mine0057@mrs.umn.edu> writes:

Grant> I tested the performace of various filesystems with a mozilla
Grant> build tree of 295MB, with primarily writing and copying
Grant> operations.

It'd be interesting to add in some read-only operations (e.g., tar to
/dev/null) because, in general, filesystems trade off expensive writes
vs expensive reads.  Especially as the disk gets fuller. (What I mean
is that filesystems that do more work to optimise disk layout will be slower to
write, but should be faster to read.  And `easy' optimisations for
disk layout get harder as the disk gets fuller and fragmented).

So the other thing that'd be interesting to test is doing the same
thing after having pre-fragmented the disk in some predictable way.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.

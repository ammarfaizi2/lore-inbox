Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264666AbTGGEJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 00:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266800AbTGGEJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 00:09:58 -0400
Received: from c16805.randw1.nsw.optusnet.com.au ([210.49.26.171]:19116 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S264666AbTGGEJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 00:09:56 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16136.62969.788967.727528@wombat.chubb.wattle.id.au>
Date: Mon, 7 Jul 2003 14:24:25 +1000
To: linux-kernel@vger.kernel.org
Subject: major and minor fault counts (2.5)
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks,
   What are the major and minor fault counts in the struct task_struct
meant to count?

   On most Unix-like systems, a major fault is one that incurs I/O; a
minor fault (reclaim) is one that does not.  It appears that on Linux
2.5.74, some faults counted as `major' do not sleep (e.g., ones that
hit the swap readahead).

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.

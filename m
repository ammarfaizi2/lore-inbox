Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269214AbUICCSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269214AbUICCSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 22:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269419AbUICCSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 22:18:00 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:10969 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269512AbUICBQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:16:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16695.50657.670300.755315@wombat.chubb.wattle.id.au>
Date: Fri, 3 Sep 2004 11:16:17 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Paolo Molaro <lupus@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: incorrect time accouting
In-Reply-To: <75465520@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paolo" == Paolo Molaro <lupus@debian.org> writes:

Paolo> While benchmarking, a user pointed out that time(1) reported
Paolo> incorrect user and system times when running mono.
Paolo> A typical example (running on 2.6.8.1 is):



This is because mono is multithreaded.  At present, time(1) records
only the time of the parent thread.  This will change soon (I hope)
when the Roland McGrath's getrusage() patches are merged.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

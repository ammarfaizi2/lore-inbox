Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTFDC7B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 22:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTFDC7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 22:59:01 -0400
Received: from c16805.randw1.nsw.optusnet.com.au ([210.49.26.171]:18848 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S262656AbTFDC66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 22:58:58 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16093.25484.865498.467734@wombat.chubb.wattle.id.au>
Date: Wed, 4 Jun 2003 13:12:12 +1000
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, akpm@digeo.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fat-fs printk arg. fix
In-Reply-To: <174530962@toto.iv>
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Randy" == Randy Dunlap <Randy.Dunlap> writes:

Randy> Hi, A recent fatfs patch for large partitions upset printk.

Please cast to unsigned long long, not to u64, or the 64-bit
architectures (where u64 is unsigned long, not unsigned long long)
will see warnings.



PeterC

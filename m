Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTDWAby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 20:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTDWAby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 20:31:54 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:44212 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S263398AbTDWAbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 20:31:53 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16037.57791.391857.852269@wombat.chubb.wattle.id.au>
Date: Wed, 23 Apr 2003 10:43:43 +1000
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] struct loop_info64
In-Reply-To: <759098236@toto.iv>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andries" == Andries Brouwer <Andries.Brouwer@cwi.nl> writes:

Andries> OK, upon general request, a shorter version.  It has struct
Andries> loop_info64 and __kernel_old_dev_t.  Otherwise mostly as
Andries> before.

Andries> Andries

While you're fixing this part of the interface, can you make the
loop_info64 structure large-file and large-block-device safe?

+struct loop_info64 {
...
+	int		   lo_offset;
	loff_t		   lo_offset;



And for stuff transferred between user/kernel space, it's *usually*
better not to use int or long, but to use explicitly-sized types,
which allows, say, both 32 and 64-bit user spaces on top of 
a 64-bit kernel.

Peter C

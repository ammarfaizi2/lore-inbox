Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTEFCYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbTEFCYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:24:38 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:62139 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S262263AbTEFCYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:24:37 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16055.8153.961744.506917@wombat.chubb.wattle.id.au>
Date: Tue, 6 May 2003 12:37:13 +1000
To: linux-kernel@vger.kernel.org
Subject: Can't compile ipv[46] with ipsec (2.5.69)
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I think that the config files are a bit confused.  Surely
CONFIG_INET_AH should depend on CONFIG_CRYPTO_HMAC ???

  CC      net/ipv4/ah.o
In file included from net/ipv4/ah.c:5:
include/net/ah.h: In function `ah_hmac_digest':
include/net/ah.h:26: warning: implicit declaration of function
`crypto_hmac_init'
include/net/ah.h:27: `crypto_hmac_update' undeclared (first use in
this function)
include/net/ah.h:27: (Each undeclared identifier is reported only once
include/net/ah.h:27: for each function it appears in.)
include/net/ah.h:28: warning: implicit declaration of function
`crypto_hmac_final'



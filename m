Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbTDFWxA (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 18:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTDFWxA (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 18:53:00 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:45249 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S263151AbTDFWxA (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 18:53:00 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16016.45674.743959.682129@wombat.chubb.wattle.id.au>
Date: Mon, 7 Apr 2003 09:04:10 +1000
To: John Bradford <john@grabjohn.com>
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] take 48-bit lba a bit further
In-Reply-To: <175955253@toto.iv>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Bradford <john@grabjohn.com> writes:


John> So, say you have a choice of either a 256Kb request to a low
John> block number, which can use the faster 28-bit mode, or a 512Kb
John> request to the same low block number, which can only be made
John> using 48-bit LBA, which is the best to use?

Interrupt overhead as measured here is greater than the IO overhead
(at least on IA64 and alpha machines).  The bigger the transfer for a
single interrupt, the better.

Peter C

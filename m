Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTELJvj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTELJuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:50:07 -0400
Received: from ns.suse.de ([213.95.15.193]:11532 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262030AbTELJqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:46:18 -0400
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Brad Boyer <flar@pants.nu>, Roman Zippel <zippel@linux-m68k.org>,
       linux-hfsplus-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] HFS+ driver
References: <Pine.LNX.4.44.0305071643030.5042-100000@serv>
	<20030508213401.GA3458@werewolf.able.es>
	<20030508214746.GB19450@pants.nu>
	<20030508221202.GE3458@werewolf.able.es>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I HAVE a towel.
Date: Mon, 12 May 2003 11:58:59 +0200
In-Reply-To: <20030508221202.GE3458@werewolf.able.es> (J. A. Magallon's
 message of "Fri, 9 May 2003 00:12:02 +0200")
Message-ID: <jeissglc4c.fsf@sykes.suse.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> writes:

|> Modified version, including the hfsplus dir and the 64 bit changes, is at
|> http://giga.cps.unizar.es/~magallon/linux/hfsplus-20030507-2.bz2

There is a warning in btree.c:hfsplus_btree_alloc_node.  Does this make
sense?

--- btree.c.~1~	2003-05-12 11:53:42.000000000 +0200
+++ btree.c	2003-05-12 11:53:51.000000000 +0200
@@ -204,7 +204,7 @@ hfsplus_bnode *hfsplus_btree_alloc_node(
 					}
 				}
 			}
-			if (++off >= PAGE_CACHE_MASK) {
+			if (++off >= PAGE_CACHE_SIZE) {
 				hfsplus_kunmap(*pagep++);
 				data = hfsplus_kmap(*pagep);
 				off = 0;

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

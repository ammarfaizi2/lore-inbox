Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992844AbWJUIRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992844AbWJUIRq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 04:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992837AbWJUIRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 04:17:46 -0400
Received: from smtp107.plus.mail.re2.yahoo.com ([206.190.53.32]:19563 "HELO
	smtp107.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161191AbWJUIRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 04:17:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:Content-Disposition:User-Agent;
  b=C95MwlmwWv7SA0ORSMRJ7ji6Zx9ADqw2Yjy/vvb0A0UmGpu3vWnBcMcWcNGo5lWqhZ8az/7rmK2Cg6/V1TXhMkjRSsIM0H8JflFlIVfBNPGUG7gbq8qnSa4RQ8ZCIVnij9MqlXs4lk97lJ1fFBlGCOtncrS53VeCrH93pozsCyo=  ;
Date: Sat, 21 Oct 2006 10:17:45 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, info-linux@geode.amd.com
Subject: [PATCH] do not compile AMD Geode's hwcrypto driver as a module per default
Message-ID: <20061021081745.GA6193@zmei.tnic>
Reply-To: Borislav Petkov <petkov@math.uni-muenster.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one should be probably made dependent on some #define saying that the cpu
is an AMD and has the LX Geode crypto hardware built in. Turn it off for now.

Signed-off-by: <petkov@math.uni-muenster.de>


--- current/drivers/crypto/Kconfig.orig	2006-10-21 10:05:08.000000000 +0200
+++ current/drivers/crypto/Kconfig	2006-10-21 10:05:25.000000000 +0200
@@ -56,7 +56,6 @@ config CRYPTO_DEV_GEODE
 	depends on CRYPTO && X86_32
 	select CRYPTO_ALGAPI
 	select CRYPTO_BLKCIPHER
-	default m
 	help
 	  Say 'Y' here to use the AMD Geode LX processor on-board AES
 	  engine for the CryptoAPI AES alogrithm.

		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUJATfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUJATfG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUJATeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:34:18 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:4102 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266233AbUJATbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:31:10 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: jmorris@redhat.com, davem@davemloft.net
Subject: [PATCH] deinline large function in blowfish.c
Date: Fri, 1 Oct 2004 22:31:03 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3BbXBBV6RMXAluK"
Message-Id: <200410012231.03378.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_3BbXBBV6RMXAluK
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This function has 3 callsites.
Patch reduces code by 1.5k (on i386).
--
vda

--Boundary-00=_3BbXBBV6RMXAluK
Content-Type: text/x-diff;
  charset="koi8-r";
  name="blowfish.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="blowfish.c.diff"

This one has 3 callsites.
Saves 1.5k

--- linux-2.6.9-rc3/crypto/blowfish.c.org	Thu Sep 30 07:29:14 2004
+++ linux-2.6.9-rc3/crypto/blowfish.c	Thu Sep 30 07:31:29 2004
@@ -316,7 +316,7 @@
  * The blowfish encipher, processes 64-bit blocks.
  * NOTE: This function MUSTN'T respect endianess 
  */
-static inline void encrypt_block(struct bf_ctx *bctx, u32 *dst, u32 *src)
+static void encrypt_block(struct bf_ctx *bctx, u32 *dst, u32 *src)
 {
 	const u32 *P = bctx->p;
 	const u32 *S = bctx->s;

--Boundary-00=_3BbXBBV6RMXAluK--


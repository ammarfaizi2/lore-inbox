Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVDLLQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVDLLQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVDLLPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:15:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:14794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262243AbVDLKc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:58 -0400
Message-Id: <200504121032.j3CAWoJX005693@shell0.pdx.osdl.net>
Subject: [patch 138/198] pnpbios: eliminate bad section references
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, janitor@sternwelten.at
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: maximilian attems <janitor@sternwelten.at>

one of the last buildcheck errors on i386, thanks Randy again for double
checking.

Fix pnpbios section references:
make dmi_system_id pnpbios_dmi_table __initdata

Error: ./drivers/pnp/pnpbios/core.o .data refers to 00000100 R_386_32
.init.text
Error: ./drivers/pnp/pnpbios/core.o .data refers to 0000012c R_386_32
.init.text

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/pnp/pnpbios/core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/pnp/pnpbios/core.c~pnpbios-eliminate-bad-section-references drivers/pnp/pnpbios/core.c
--- 25/drivers/pnp/pnpbios/core.c~pnpbios-eliminate-bad-section-references	2005-04-12 03:21:36.702557264 -0700
+++ 25-akpm/drivers/pnp/pnpbios/core.c	2005-04-12 03:21:36.705556808 -0700
@@ -512,7 +512,7 @@ static int __init exploding_pnp_bios(str
 	return 0;
 }
 
-static struct dmi_system_id pnpbios_dmi_table[] = {
+static struct dmi_system_id pnpbios_dmi_table[] __initdata = {
 	{	/* PnPBIOS GPF on boot */
 		.callback = exploding_pnp_bios,
 		.ident = "Higraded P14H",
_

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVHVSnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVHVSnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 14:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVHVSnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 14:43:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64681 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750717AbVHVSnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 14:43:16 -0400
Date: Mon, 22 Aug 2005 20:42:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Russell King <rmk@arm.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] Fix macro abuse in pcmcia/cistpl.c
Message-ID: <20050822184257.GA2106@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Please apply,
								Pavel

Fix macro abuse in pcmcia.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 486ece208a1ae323fce89fc3b4b5b4b522a1b4b8
tree 1c9aa703b585a65acbd038c053dbf42c9603e281
parent b4b834e36f0180e1036a7a8ba8505b6d4165596e
author <pavel@amd.(none)> Mon, 22 Aug 2005 20:42:10 +0200
committer <pavel@amd.(none)> Mon, 22 Aug 2005 20:42:10 +0200

 drivers/pcmcia/cistpl.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -60,9 +60,9 @@ static const u_int exponent[] = {
 
 /* Parameters that can be set with 'insmod' */
 
-#define INT_MODULE_PARM(n, v) static int n = v; module_param(n, int, 0444)
-
-INT_MODULE_PARM(cis_width,	0);		/* 16-bit CIS? */
+/* 16-bit CIS? */
+static int cis_width = 0;
+module_param(cis_width, int, 0444);
 
 void release_cis_mem(struct pcmcia_socket *s)
 {

-- 
if you have sharp zaurus hardware you don't need... you know my address

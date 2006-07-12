Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWGLIcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWGLIcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWGLIcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:32:31 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:20352 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750958AbWGLIcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:32:31 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] Fix bad section placement
Date: Wed, 12 Jul 2006 10:32:33 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: linux-kernel@vger.kernel.org
Cc: peri@csai.unipa.it
Message-Id: <20060712083233.8014.90941.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

subsystem_configurations was placed in __devinitdata even though its only
user is a __init function.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/net/irda/smsc-ircc2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/irda/smsc-ircc2.c b/drivers/net/irda/smsc-ircc2.c
index a467404..2eff45b 100644
--- a/drivers/net/irda/smsc-ircc2.c
+++ b/drivers/net/irda/smsc-ircc2.c
@@ -2353,7 +2353,7 @@ static int __init smsc_superio_lpc(unsig
 #ifdef CONFIG_PCI
 #define PCIID_VENDOR_INTEL 0x8086
 #define PCIID_VENDOR_ALI 0x10b9
-static struct smsc_ircc_subsystem_configuration subsystem_configurations[] __devinitdata = {
+static struct smsc_ircc_subsystem_configuration subsystem_configurations[] __initdata = {
 	{
 		.vendor = PCIID_VENDOR_INTEL, /* Intel 82801DBM LPC bridge */
 		.device = 0x24cc,


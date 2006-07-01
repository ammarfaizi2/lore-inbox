Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751868AbWGAPG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbWGAPG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 11:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWGAPGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 11:06:23 -0400
Received: from www.osadl.org ([213.239.205.134]:64164 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751903AbWGAO5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:57:34 -0400
Message-Id: <20060701145227.663650000@cruncher.tec.linutronix.de>
References: <20060701145211.856500000@cruncher.tec.linutronix.de>
Date: Sat, 01 Jul 2006 14:55:04 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>
Subject: [RFC][patch 38/44] rio: Use the new IRQF_ constansts
Content-Disposition: inline; filename=irqflags-drivers-rio.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 drivers/char/rio/rio_linux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.git/drivers/char/rio/rio_linux.c
===================================================================
--- linux-2.6.git.orig/drivers/char/rio/rio_linux.c	2006-07-01 16:51:12.000000000 +0200
+++ linux-2.6.git/drivers/char/rio/rio_linux.c	2006-07-01 16:51:46.000000000 +0200
@@ -1119,7 +1119,7 @@ static int __init rio_init(void)
 	for (i = 0; i < p->RIONumHosts; i++) {
 		hp = &p->RIOHosts[i];
 		if (hp->Ivec) {
-			int mode = SA_SHIRQ;
+			int mode = IRQF_SHARED;
 			if (hp->Ivec & 0x8000) {
 				mode = 0;
 				hp->Ivec &= 0x7fff;

--


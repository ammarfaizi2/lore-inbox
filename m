Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVB1DmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVB1DmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 22:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVB1DmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 22:42:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:8860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261540AbVB1DmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 22:42:10 -0500
Date: Sun, 27 Feb 2005 19:29:16 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Subject: [PATCH] parport_pc: use devinitdata
Message-Id: <20050227192916.037f479f.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


parport_init_mode is used by devinit code so it should be __devinitdata;

Error: ./drivers/parport/parport_pc.o .text refers to 0000000000002601 R_X86_64_PC32     .init.data+0x00000000000000e0

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/parport/parport_pc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./drivers/parport/parport_pc.c~parport_pc_sections ./drivers/parport/parport_pc.c
--- ./drivers/parport/parport_pc.c~parport_pc_sections	2005-02-27 12:54:05.893027568 -0800
+++ ./drivers/parport/parport_pc.c	2005-02-27 19:15:23.024175000 -0800
@@ -2488,7 +2488,7 @@ static int __devinit sio_ite_8872_probe 
 
 /* VIA 8231 support by Pavel Fedin <sonic_amiga@rambler.ru>
    based on VIA 686a support code by Jeff Garzik <jgarzik@pobox.com> */
-static int __initdata parport_init_mode = 0;
+static int __devinitdata parport_init_mode = 0;
 
 /* Data for two known VIA chips */
 static struct parport_pc_via_data via_686a_data __devinitdata = {

---

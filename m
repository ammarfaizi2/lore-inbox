Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVCEG0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVCEG0D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbVCEGTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:19:02 -0500
Received: from fire.osdl.org ([65.172.181.4]:22156 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263000AbVCEGKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:10:40 -0500
Date: Fri, 4 Mar 2005 21:54:35 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-sound@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Subject: [PATCH] oss/es1370: fix initdata section references
Message-Id: <20050304215435.7e18b830.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oss/es1370: fix initdata section reference:

Error: ./sound/oss/es1370.o .text refers to 00000000000042bd R_X86_64_32S      .init.data+0x0000000000000024
Error: ./sound/oss/es1370.o .text refers to 00000000000042c5 R_X86_64_32S      .init.data+0x0000000000000020

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 sound/oss/es1370.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./sound/oss/es1370.c~oss_es1370_sections ./sound/oss/es1370.c
--- ./sound/oss/es1370.c~oss_es1370_sections	2005-03-01 23:38:33.000000000 -0800
+++ ./sound/oss/es1370.c	2005-03-04 21:17:17.000000000 -0800
@@ -2540,7 +2540,7 @@ MODULE_LICENSE("GPL");
 static struct initvol {
 	int mixch;
 	int vol;
-} initvol[] __initdata = {
+} initvol[] __devinitdata = {
 	{ SOUND_MIXER_WRITE_VOLUME, 0x4040 },
 	{ SOUND_MIXER_WRITE_PCM, 0x4040 },
 	{ SOUND_MIXER_WRITE_SYNTH, 0x4040 },


---

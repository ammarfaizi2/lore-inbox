Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263054AbVCEGZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbVCEGZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbVCEGSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:18:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:21132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262651AbVCEGKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:10:39 -0500
Date: Fri, 4 Mar 2005 21:53:14 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-sound@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Subject: [PATCH] oss/cmpci: fix initdata section references
Message-Id: <20050304215314.75614e58.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oss/cmpci: fix initdata section reference:

Error: ./sound/oss/cmpci.o .text refers to 000000000000418e R_X86_64_32S      .init.data+0x0000000000000004
Error: ./sound/oss/cmpci.o .text refers to 0000000000004196 R_X86_64_32S      .init.data

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 sound/oss/cmpci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./sound/oss/cmpci.c~oss_cmpci_sections ./sound/oss/cmpci.c
--- ./sound/oss/cmpci.c~oss_cmpci_sections	2005-03-01 23:38:10.000000000 -0800
+++ ./sound/oss/cmpci.c	2005-03-04 21:09:15.000000000 -0800
@@ -2925,7 +2925,7 @@ static /*const*/ struct file_operations 
 static struct initvol {
 	int mixch;
 	int vol;
-} initvol[] __initdata = {
+} initvol[] __devinitdata = {
 	{ SOUND_MIXER_WRITE_CD, 0x4f4f },
 	{ SOUND_MIXER_WRITE_LINE, 0x4f4f },
 	{ SOUND_MIXER_WRITE_MIC, 0x4f4f },


---
---
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263086AbVCEG0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbVCEG0E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbVCEGTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:19:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:22668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263004AbVCEGKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:10:42 -0500
Date: Fri, 4 Mar 2005 21:55:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-sound@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Subject: [PATCH] oss/esssolo1: fix initdata section references
Message-Id: <20050304215549.776833e2.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oss/esssolo1: fix initdata section reference:

Error: ./sound/oss/esssolo1.o .text refers to 0000000000000bab R_X86_64_32S      .init.data+0x0000000000000004
Error: ./sound/oss/esssolo1.o .text refers to 0000000000000bb2 R_X86_64_32S      .init.data

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 sound/oss/esssolo1.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./sound/oss/esssolo1.c~oss_esssolo1_sections ./sound/oss/esssolo1.c
--- ./sound/oss/esssolo1.c~oss_esssolo1_sections	2005-03-01 23:37:48.000000000 -0800
+++ ./sound/oss/esssolo1.c	2005-03-04 21:19:59.000000000 -0800
@@ -2193,7 +2193,7 @@ static /*const*/ struct file_operations 
 static struct initvol {
 	int mixch;
 	int vol;
-} initvol[] __initdata = {
+} initvol[] __devinitdata = {
 	{ SOUND_MIXER_WRITE_VOLUME, 0x4040 },
 	{ SOUND_MIXER_WRITE_PCM, 0x4040 },
 	{ SOUND_MIXER_WRITE_SYNTH, 0x4040 },


---

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263194AbVCEG0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbVCEG0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbVCEGSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:18:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:20620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262110AbVCEGKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:10:37 -0500
Date: Fri, 4 Mar 2005 21:53:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-sound@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Subject: [PATCH] oss/cs4281: fix initdata section references
Message-Id: <20050304215306.1f92e87b.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


oss/cs4281: fix initdata section references:

Error: ./sound/oss/cs4281/cs4281.o .text refers to 0000000000006dae R_X86_64_32S      .init.data+0x0000000000000004
Error: ./sound/oss/cs4281/cs4281.o .text refers to 0000000000006db6 R_X86_64_32S      .init.data
Error: ./sound/oss/cs4281/cs4281m.o .text refers to 0000000000006dae R_X86_64_32S      .init.data+0x0000000000000004
Error: ./sound/oss/cs4281/cs4281m.o .text refers to 0000000000006db6 R_X86_64_32S      .init.data

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 sound/oss/cs4281/cs4281m.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./sound/oss/cs4281/cs4281m.c~oss_cs4281_sections ./sound/oss/cs4281/cs4281m.c
--- ./sound/oss/cs4281/cs4281m.c~oss_cs4281_sections	2005-03-01 23:38:33.000000000 -0800
+++ ./sound/oss/cs4281/cs4281m.c	2005-03-04 21:35:51.000000000 -0800
@@ -4096,7 +4096,7 @@ static /*const */ struct file_operations
 static struct initvol {
 	int mixch;
 	int vol;
-} initvol[] __initdata = {
+} initvol[] __devinitdata = {
 
 	{
 	SOUND_MIXER_WRITE_VOLUME, 0x4040}, {

---
---
~Randy

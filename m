Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVCSN3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVCSN3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVCSNZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:25:02 -0500
Received: from coderock.org ([193.77.147.115]:39816 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262530AbVCSNT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:19:28 -0500
Subject: [patch 1/1] CodingStyle: trivial whitespace fixups
To: akpm@osdl.org
Cc: ak@suse.de, linux-kernel@vger.kernel.org, domen@coderock.org,
       didickman@yahoo.com
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:19:13 +0100
Message-Id: <20050319131913.951D81F248@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



When I do a "diff -Nur arch/i386 arch/x86_64" to see what is different between these two
architectures, I see some differences due to whitespace issues only. The attached patch removes
some of the noise by fixing up the following files:
- arch/i386/boot/bootsect.S
- arch/i386/boot/video.S
- arch/x86_64/boot/bootsect.S

Signed-off-by: Daniel Dickman <didickman@yahoo.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/i386/boot/bootsect.S   |    2 +-
 kj-domen/arch/i386/boot/video.S      |   18 +++++++++---------
 kj-domen/arch/x86_64/boot/bootsect.S |    4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff -puN arch/i386/boot/bootsect.S~whitespace-arch_i386_boot_bootsect.S arch/i386/boot/bootsect.S
--- kj/arch/i386/boot/bootsect.S~whitespace-arch_i386_boot_bootsect.S	2005-03-18 20:05:15.000000000 +0100
+++ kj-domen/arch/i386/boot/bootsect.S	2005-03-18 20:05:15.000000000 +0100
@@ -83,7 +83,7 @@ bugger_off_msg:
 	.ascii	"\n"
 	.ascii	"Remove disk and press any key to reboot . . .\r\n"
 	.byte	0
-	
+
 
 	# Kernel attributes; used by setup
 
diff -puN arch/i386/boot/video.S~whitespace-arch_i386_boot_bootsect.S arch/i386/boot/video.S
--- kj/arch/i386/boot/video.S~whitespace-arch_i386_boot_bootsect.S	2005-03-18 20:05:15.000000000 +0100
+++ kj-domen/arch/i386/boot/video.S	2005-03-18 20:05:15.000000000 +0100
@@ -1924,36 +1924,36 @@ skip10:	movb	%ah, %al
 	ret
 
 store_edid:
-	pushw	%es				# just save all registers 
-	pushw	%ax				
+	pushw	%es				# just save all registers
+	pushw	%ax
 	pushw	%bx
 	pushw   %cx
 	pushw	%dx
 	pushw   %di
 
-	pushw	%fs                             
+	pushw	%fs
 	popw    %es
 
 	movl	$0x13131313, %eax		# memset block with 0x13
 	movw    $32, %cx
 	movw	$0x140, %di
 	cld
-	rep 
-	stosl  
+	rep
+	stosl
 
-	movw	$0x4f15, %ax                    # do VBE/DDC 
+	movw	$0x4f15, %ax                    # do VBE/DDC
 	movw	$0x01, %bx
 	movw	$0x00, %cx
 	movw    $0x01, %dx
 	movw	$0x140, %di
-	int	$0x10	
+	int	$0x10
 
-	popw	%di				# restore all registers        
+	popw	%di				# restore all registers
 	popw	%dx
 	popw	%cx
 	popw	%bx
 	popw	%ax
-	popw	%es	
+	popw	%es
 	ret
 
 # VIDEO_SELECT-only variables
diff -puN arch/x86_64/boot/bootsect.S~whitespace-arch_i386_boot_bootsect.S arch/x86_64/boot/bootsect.S
--- kj/arch/x86_64/boot/bootsect.S~whitespace-arch_i386_boot_bootsect.S	2005-03-18 20:05:15.000000000 +0100
+++ kj-domen/arch/x86_64/boot/bootsect.S	2005-03-18 20:05:15.000000000 +0100
@@ -63,7 +63,7 @@ msg_loop:
 	jz	die
 	movb	$0xe, %ah
 	movw	$7, %bx
- 	int	$0x10
+	int	$0x10
 	jmp	msg_loop
 
 die:
@@ -71,7 +71,7 @@ die:
 	xorw	%ax, %ax
 	int	$0x16
 	int	$0x19
-	
+
 	# int 0x19 should never return.  In case it does anyway,
 	# invoke the BIOS reset code...
 	ljmp	$0xf000,$0xfff0
_

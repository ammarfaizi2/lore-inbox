Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUJVTCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUJVTCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUJVS7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:59:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:7330 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S266905AbUJVSu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:50:59 -0400
Message-ID: <41795446.40904@osdl.org>
Date: Fri, 22 Oct 2004 11:41:10 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, ak@suse.de,
       pavel@suse.cz
Subject: [PATCH] x86_64 ia32 syscall32: references initdata during resume
Content-Type: multipart/mixed;
 boundary="------------080705090508070100040907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080705090508070100040907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
~Randy

--------------080705090508070100040907
Content-Type: text/x-patch;
 name="x64_syscall32_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x64_syscall32_init.patch"


Fix __initdata references in syscall32_cpu_init:
Error: ./arch/x86_64/ia32/syscall32.o .text refers to 0000000000000002 R_X86_64_PC32     .init.data+0x000000000000152b
Error: ./arch/x86_64/ia32/syscall32.o .text refers to 0000000000000017 R_X86_64_PC32     .init.data+0x000000000000152c

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/x86_64/ia32/syscall32.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./arch/x86_64/ia32/syscall32.c~x64_syscall32_init ./arch/x86_64/ia32/syscall32.c
--- ./arch/x86_64/ia32/syscall32.c~x64_syscall32_init	2004-10-18 14:54:37.000000000 -0700
+++ ./arch/x86_64/ia32/syscall32.c	2004-10-22 09:17:40.045615536 -0700
@@ -28,7 +28,7 @@ extern unsigned char syscall32_sysenter[
 extern int sysctl_vsyscall32;
 
 char *syscall32_page; 
-static int use_sysenter __initdata = -1;
+static int use_sysenter = -1;
 
 /*
  * Map the 32bit vsyscall page on demand.

--------------080705090508070100040907--

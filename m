Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313490AbSDPB6m>; Mon, 15 Apr 2002 21:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313486AbSDPB6l>; Mon, 15 Apr 2002 21:58:41 -0400
Received: from rj.SGI.COM ([204.94.215.100]:27306 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313490AbSDPB6f>;
	Mon, 15 Apr 2002 21:58:35 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available 
In-Reply-To: Your message of "Sun, 14 Apr 2002 23:23:16 +1000."
             <2833.1018790596@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Apr 2002 11:58:12 +1000
Message-ID: <11907.1018922292@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2002 23:23:16 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>Updates for kbuild 2.5 at
>http://sourceforge.net/project/showfiles.php?group_id=18813
>kbuild-2.5-i386-2.5.8-pre3-1.bz2

i386-2.5.8-pre3-1 was missing this bit, against i386-2.5.8-pre3-1.
Apply this patch or use kbuild-2.5-i386-2.5.8-pre3-2.bz2.

diff -urN 2.5.8-pre3-kbuild-2.5/arch/i386/kernel/Makefile.in 2.5.8-pre3-kbuild-2.5-save/arch/i386/kernel/Makefile.in
--- 2.5.8-pre3-kbuild-2.5/arch/i386/kernel/Makefile.in	Tue Apr 16 11:09:25 2002
+++ 2.5.8-pre3-kbuild-2.5-save/arch/i386/kernel/Makefile.in	Sun Apr 14 11:45:28 2002
@@ -27,5 +27,11 @@
 
 # uses_asm_offsets(entry.o)
 
+# "Unterminated character constants", due to mismatched ' in comments
+extra_aflags(entry.o -traditional)
 extra_aflags(head.o -traditional)
 extra_aflags(trampoline.o -traditional)
+
+extra_cflags(acpi.o $(fixme_acpi_includes))
+extra_cflags(pci-irq.o $(fixme_acpi_includes))
+extra_cflags(setup.o $(fixme_acpi_includes))


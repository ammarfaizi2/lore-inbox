Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279973AbRKDIDy>; Sun, 4 Nov 2001 03:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279971AbRKDIDo>; Sun, 4 Nov 2001 03:03:44 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:7040 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S279974AbRKDID3>;
	Sun, 4 Nov 2001 03:03:29 -0500
Message-ID: <3BE4F64C.A5252A31@pobox.com>
Date: Sun, 04 Nov 2001 00:03:25 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hartmann <andihartmann@freenet.de>
CC: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbols in 2.4.14-pre7
In-Reply-To: <200111040646.fA46khp00596@athlon.maya.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hartmann wrote:

> with my standard configuration, I get some unresolved symbols with
> 2.4.14-pre7:

It appears to be fixed in -pre8....

but here's a patch that fixes it in -pre7:

diff -urN linux/kernel/ksyms.c linux-patched/kernel/ksyms.c
--- linux/kernel/ksyms.c Fri Nov  2 11:02:45 2001
+++ linux-patched/kernel/ksyms.c Fri Nov  2 10:09:48 2001
@@ -83,6 +83,7 @@
 EXPORT_SYMBOL(do_mmap_pgoff);
 EXPORT_SYMBOL(do_munmap);
 EXPORT_SYMBOL(do_brk);
+EXPORT_SYMBOL(unlock_page);
 EXPORT_SYMBOL(exit_mm);
 EXPORT_SYMBOL(exit_files);
 EXPORT_SYMBOL(exit_fs);



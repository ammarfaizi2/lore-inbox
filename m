Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263959AbTJFDQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 23:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbTJFDQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 23:16:58 -0400
Received: from covilha.procergs.com.br ([200.198.128.212]:12809 "EHLO
	covilha.procergs.com.br") by vger.kernel.org with ESMTP
	id S263959AbTJFDQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 23:16:57 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Normal Flopply should depend of ISA?
From: Otavio Salvador <otavio@debian.org>
Date: Mon, 06 Oct 2003 00:16:09 -0300
Message-ID: <87he2n2gzq.fsf@retteb.casa>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I'm current have problem to use normal floppy disk in 2.6.0-test6-bk7
and looking at last patchset I found one possible cause.

--- a/drivers/block/Kconfig Thu Sep 25 11:33:27 2003
+++ b/drivers/block/Kconfig Thu Oct 2 00:12:22 2003
@@ -6,7 +6,7 @@
config BLK_DEV_FD
tristate "Normal floppy disk support"
- depends on !X86_PC9800 && !ARCH_S390
+ depends on ISA || M68 || SPARC64
---help---
If you want to use the floppy disk drive(s) of your PC under Linux,
say Y. Information about this driver, especially important for IBM

Is right normal floppy depends of ISA? I'll include this by the moment
but I doesn't have any ISA hardware in my system.

Thanks in Advance,
Otavio

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------

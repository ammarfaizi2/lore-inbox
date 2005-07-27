Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVG0VAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVG0VAR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVG0U6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:58:48 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:5640 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262448AbVG0U5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:57:40 -0400
Message-ID: <42E7F53E.9050604@tuxrocks.com>
Date: Wed, 27 Jul 2005 14:57:34 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Fix up i386 compile after the "i386: clean up user_mode macros"
 patch
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The "i386: clean up user_mode macros" patch that recently went into the
kernel doesn't know the definition of VM_MASK, so the current -git
doesn't compile.  This patch includes the header where VM_MASK is defined.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

Fix up i386 compile after the "i386: clean up user_mode macros" patch

diff --git a/include/asm-i386/ptrace.h b/include/asm-i386/ptrace.h
- --- a/include/asm-i386/ptrace.h
+++ b/include/asm-i386/ptrace.h
@@ -1,8 +1,10 @@
 #ifndef _I386_PTRACE_H
 #define _I386_PTRACE_H

+#include <asm-i386/vm86.h>
+
 #define EBX 0
 #define ECX 1
 #define EDX 2
 #define ESI 3
 #define EDI 4


Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC5/U+aI0dwg4A47wRAsdOAJ9hzY9aQ0pQTY1QikQ0MzobJzJG7QCeI9C7
zU+Gyxyp933jK0ahLWDhzq0=
=90nz
-----END PGP SIGNATURE-----

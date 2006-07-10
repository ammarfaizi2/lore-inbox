Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbWGJXb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbWGJXb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbWGJXb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:31:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21196 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965063AbWGJXbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:31:50 -0400
Subject: [HDRINSTALL 3/3] Remove asm/io.h from user visibility
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1152574110.25567.47.camel@shinybook.infradead.org>
References: <1152573909.25567.45.camel@shinybook.infradead.org>
	 <1152574110.25567.47.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 00:32:15 +0100
Message-Id: <1152574336.25567.56.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no excuse for userspace abusing this kernel header -- the
kernel's headers are not intended to provide a library of helper
routines for userspace. Using <asm/io.h> from userspace is broken on
most architectures anyway. Just say 'no'.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-generic/Kbuild.asm b/include/asm-generic/Kbuild.asm
index bdb8b08..6b16dda 100644
--- a/include/asm-generic/Kbuild.asm
+++ b/include/asm-generic/Kbuild.asm
@@ -4,8 +4,5 @@ unifdef-y += a.out.h auxvec.h byteorder.
 	sigcontext.h siginfo.h signal.h socket.h sockios.h stat.h	\
 	statfs.h termbits.h termios.h timex.h types.h unistd.h user.h
 
-# These really shouldn't be exported
-unifdef-y += io.h
-
 # These probably shouldn't be exported
 unifdef-y += elf.h page.h

-- 
dwmw2


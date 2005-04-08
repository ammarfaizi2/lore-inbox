Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVDHDz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVDHDz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVDHDz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:55:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56761 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262680AbVDHDzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:55:45 -0400
Date: Thu, 7 Apr 2005 20:55:38 -0700
Message-Id: <200504080355.j383tcxa029807@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86-64: i386 vDSO: add PT_NOTE segment
In-Reply-To: Roland McGrath's message of  Thursday, 7 April 2005 20:53:52 -0700 <200504080353.j383rqf8029792@magilla.sf.frob.com>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Vitriolic ostentatious yies
   (2) Sudsing malevolent mountains
   (3) Sunburnt commanders
   (4) Symbolical mountain lips
   (5) Obnoxious condensers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assuming my previous patch goes into the native i386 vDSO,
this patch makes the x86_64's 32-bit vDSO match it.

Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/arch/x86_64/ia32/vsyscall-sigreturn.S
+++ linux-2.6/arch/x86_64/ia32/vsyscall-sigreturn.S
@@ -118,3 +118,6 @@ __kernel_rt_sigreturn:
 
 	.align 4
 .LENDFDE3:
+
+#include "../../i386/kernel/vsyscall-note.S"
+	    

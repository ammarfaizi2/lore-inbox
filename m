Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWANUud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWANUud (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 15:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWANUud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 15:50:33 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:23934 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751109AbWANUud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 15:50:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=E2+r0KPMU2AWvKnoXGWVcWJYd+xdz1u1NNefcUPuONECGL61d1NkgmWebHZ1J2Jszbu5vr7M7UAT200RIpsSXgm8mTHW0suag8FYbcdA/IP/HP3AdW0s5hG0xv9A8rq++rMSyJv93RaFwqLsdRJn/I4WoO9LdpEAwgzrEodPX1o=
Date: Sun, 15 Jan 2006 00:07:37 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Ian Molton <spyro@f2s.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] arm26: s/task_threas_info/task_thread_info/
Message-ID: <20060114210737.GA5145@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 I'm in the quest to make it build. So far only clusterfsck with NR_IRQS,
 asm/irq.h, asm/hardirq.h ... is the only thing I don't understand.

 arch/arm26/kernel/ptrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm26/kernel/ptrace.c
+++ b/arch/arm26/kernel/ptrace.c
@@ -527,7 +527,7 @@
 static int ptrace_setfpregs(struct task_struct *tsk, void *ufp)
 {
 	set_stopped_child_used_math(tsk);
-	return copy_from_user(&task_threas_info(tsk)->fpstate, ufp,
+	return copy_from_user(&task_thread_info(tsk)->fpstate, ufp,
 			      sizeof(struct user_fp)) ? -EFAULT : 0;
 }
 


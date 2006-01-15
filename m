Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWAOXID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWAOXID (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 18:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWAOXID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 18:08:03 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:64973 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S1750973AbWAOXIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 18:08:01 -0500
Message-ID: <43CAD629.2090007@f2s.com>
Date: Sun, 15 Jan 2006 23:09:29 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] arm26: s/task_threas_info/task_thread_info/
References: <20060114210737.GA5145@mipter.zuzino.mipt.ru>
In-Reply-To: <20060114210737.GA5145@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

Obviously correct.

Signed-off-by: Ian Molton <spyro@f2s.com>
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





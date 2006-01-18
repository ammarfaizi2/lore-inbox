Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbWARUoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWARUoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWARUoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:44:14 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:55216 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030444AbWARUoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:44:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=sjkEJ9N2rVefR8qyfYJ6vE5gEkpNJMi9Yg8yVDbYmyi1323fw14GsPSdI8tSm5fAH3zkdbFIXvYZLnH2G0OEguF5Lpl7bRUtHR48yhmpDBey6mK2WdKv5nlStI/RqSIJa7asojyho9AiOKSzrRZx5fl7G+HJ1tVxuA1kgxpZ1Hs=
Date: Thu, 19 Jan 2006 00:01:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm26: drop first arg of prepare_arch_switch, finish_arch_switch
Message-ID: <20060118210135.GH12771@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-arm26/system.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- a/include/asm-arm26/system.h
+++ b/include/asm-arm26/system.h
@@ -98,8 +98,8 @@ extern unsigned int user_debug;
  * spin_unlock_irq() and friends are implemented.  This avoids
  * us needlessly decrementing and incrementing the preempt count.
  */
-#define prepare_arch_switch(rq,next)	local_irq_enable()
-#define finish_arch_switch(rq,prev)	spin_unlock(&(rq)->lock)
+#define prepare_arch_switch(next)	local_irq_enable()
+#define finish_arch_switch(prev)	spin_unlock(&(rq)->lock)
 
 /*
  * switch_to(prev, next) should switch from task `prev' to `next'


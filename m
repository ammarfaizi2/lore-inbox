Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWARUnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWARUnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbWARUnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:43:53 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:44071 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030443AbWARUnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:43:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=j+F1C6CpT1j/ll1XOi45h+M3uWz1B6HKZVga3qjeb09GlJVeIJQUix0pedwJ86a1qHDw7cXyHZTsHvIQxZCSmsctGluSHYAZk9u5gwnQ4J3AKlhP88tf4RuTmBn6Wl6+NK3BE2EXwOnt6Tp7E4/wMcMCxadBPCVv4HCESIbrvMg=
Date: Thu, 19 Jan 2006 00:00:48 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm26: drop local task_running copy
Message-ID: <20060118210048.GG12771@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-arm26/system.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

--- a/include/asm-arm26/system.h
+++ b/include/asm-arm26/system.h
@@ -100,7 +100,6 @@ extern unsigned int user_debug;
  */
 #define prepare_arch_switch(rq,next)	local_irq_enable()
 #define finish_arch_switch(rq,prev)	spin_unlock(&(rq)->lock)
-#define task_running(rq,p)		((rq)->curr == (p))
 
 /*
  * switch_to(prev, next) should switch from task `prev' to `next'


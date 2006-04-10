Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWDJDAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWDJDAq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 23:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWDJDAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 23:00:46 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:5865 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750854AbWDJDAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 23:00:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=GvAiDbfZlGNOXDVjVPopwNbtx+04UUY4nu5Cva8W5A2XVQfImDcw8+WT4nlWCHulY/b3EuYA0GBWz/hCHIDYXqtERHxvkBbNo856pB1aeGLIfVMUBKMPDN/HaoeJS6l7tqL7xbL8EXkDcobkqk4gMpNN7RuvzDbEVAE3UShvQ6c=
Date: Mon, 10 Apr 2006 07:01:04 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove duplicate check after powernow-k8 changes
Message-ID: <20060410030104.GB32151@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
@@ -1109,9 +1109,6 @@ static unsigned int powernowk8_get (unsi
 	if (!data)
 		return -EINVAL;
 
-	if (!data)
-		return -EINVAL;
-
 	set_cpus_allowed(current, cpumask_of_cpu(cpu));
 	if (smp_processor_id() != cpu) {
 		printk(KERN_ERR PFX "limiting to CPU %d failed in powernowk8_get\n", cpu);


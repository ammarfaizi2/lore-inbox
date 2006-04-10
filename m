Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWDJRUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWDJRUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWDJRUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:20:36 -0400
Received: from mail.shorthander.org ([85.10.227.118]:24484 "EHLO
	herakles.nuerscht.net") by vger.kernel.org with ESMTP
	id S1750742AbWDJRUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:20:35 -0400
Date: Mon, 10 Apr 2006 19:20:12 +0200
From: Tobias Klauser <tklauser@nuerscht.ch>
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk, akpm@osdl.org
Subject: [PATCH] i386: Remove duplicate code
Message-ID: <20060410171943.GA1106@neon.tklauser.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 0x3A445520
X-OS: GNU/Linux
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a duplicate NULL pointer check introduced by commit
4211a30349e8d2b724cfb4ce2584604f5e59c299

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>

---

 arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
index 7c0e160..30bb6fd 100644
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

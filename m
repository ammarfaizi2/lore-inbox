Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966509AbWKOLvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966509AbWKOLvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 06:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966024AbWKOLvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 06:51:06 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:62030 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932859AbWKOLvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 06:51:05 -0500
Date: Wed, 15 Nov 2006 18:56:19 +0300
From: Alexey Dobriyan <adobriyan@openvz.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, devel@openvz.org
Subject: [PATCH] Don't give bad kprobes example aka ") < 0))" typo
Message-ID: <20061115155619.GC9011@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
---

 Documentation/kprobes.txt |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -442,9 +442,10 @@ static int __init kprobe_init(void)
 	kp.fault_handler = handler_fault;
 	kp.symbol_name = "do_fork";
 
-	if ((ret = register_kprobe(&kp) < 0)) {
+	ret = register_kprobe(&kp);
+	if (ret < 0) {
 		printk("register_kprobe failed, returned %d\n", ret);
-		return -1;
+		return ret;
 	}
 	printk("kprobe registered\n");
 	return 0;


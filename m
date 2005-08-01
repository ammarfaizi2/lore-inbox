Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVHAUj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVHAUj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVHAUg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:36:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17595 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261230AbVHAUez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:34:55 -0400
Date: Mon, 1 Aug 2005 16:34:42 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, Mirko Lindner <mlindner@syskonnect.de>
Subject: skge missing ifdefs.
Message-ID: <20050801203442.GD2473@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	Mirko Lindner <mlindner@syskonnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with CONFIG_PM undefined, the build breaks due to 
undefined symbols.

Signed-off-by: Dave Jones <davej@redhat.com>

-- linux-2.6.12/drivers/net/sk98lin/skge.c~	2005-08-01 16:32:42.000000000 -0400
+++ linux-2.6.12/drivers/net/sk98lin/skge.c	2005-08-01 16:33:10.000000000 -0400
@@ -5233,8 +5233,10 @@ static struct pci_driver skge_driver = {
 	.id_table	= skge_pci_tbl,
 	.probe		= skge_probe_one,
 	.remove		= __devexit_p(skge_remove_one),
+#ifdef CONFIG_PM
 	.suspend	= skge_suspend,
 	.resume		= skge_resume,
+#endif
 };
 
 static int __init skge_init(void)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUAWGiw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUAWGg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:36:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21202 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266517AbUAWGgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:43 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
From: davej@redhat.com
Subject: PCI probing typo?
Message-Id: <E1Ajuub-0000xN-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at this code, I can't convince myself it's
currently doing the right thing.  It looks more like
the intention was one of the two below..

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/pci/direct.c linux-2.5/arch/i386/pci/direct.c
--- bk-linus/arch/i386/pci/direct.c	2003-09-29 19:45:06.000000000 +0100
+++ linux-2.5/arch/i386/pci/direct.c	2004-01-05 05:54:04.000000000 +0000
@@ -259,7 +259,7 @@ static int __init pci_direct_init(void)
 	release_resource(region);
 
  type2:
-	if ((!pci_probe & PCI_PROBE_CONF2) == 0)
+	if ((pci_probe & PCI_PROBE_CONF2) == 0)
 		goto out;
 	region = request_region(0xCF8, 4, "PCI conf2");
 	if (!region)


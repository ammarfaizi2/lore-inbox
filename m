Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266303AbUFUQ1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUFUQ1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 12:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbUFUQ1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 12:27:13 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:44687 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S266303AbUFUQ1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 12:27:11 -0400
X-Sender-Authentication: net64
Date: Mon, 21 Jun 2004 18:27:09 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Patch for 2.4 orinoco_pci.c for device 0x3872
Message-Id: <20040621182709.5e2553df.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the attached patch makes a Harris Semiconductor wireless device (3872) work,
which is built into some series of Acer notebooks. It is tested for months and
known to work (and obviously plain and simple).

Regards,
Stephan


--- linux-2.4.27-rc1/drivers/net/wireless/orinoco_pci.c	2003-08-25 13:44:42.000000000 +0200
+++ linux-2.4.27-skraw/drivers/net/wireless/orinoco_pci.c	2004-06-18 22:27:52.000000000 +0200
@@ -360,6 +360,7 @@
 
 static struct pci_device_id orinoco_pci_pci_id_table[] __devinitdata = {
 	{0x1260, 0x3873, PCI_ANY_ID, PCI_ANY_ID,},
+	{0x1260, 0x3872, PCI_ANY_ID, PCI_ANY_ID,},
 	{0,},
 };
 

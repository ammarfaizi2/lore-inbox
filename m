Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWF1TdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWF1TdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWF1TdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:33:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1738 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751038AbWF1TdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:33:16 -0400
Date: Wed, 28 Jun 2006 15:33:13 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: bcasavan@sgi.com
Subject: remove devinit from ioc4 pci_driver
Message-ID: <20060628193313.GA22146@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, bcasavan@sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documention/pci.txt states..
"The struct pci_driver shouldn't be marked with any of these tags."
(Referring to __devinit and friends).

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/sn/ioc4.c~	2006-06-28 15:31:26.000000000 -0400
+++ linux-2.6/drivers/sn/ioc4.c	2006-06-28 15:32:09.000000000 -0400
@@ -438,7 +438,7 @@ static struct pci_device_id ioc4_id_tabl
 	{0}
 };
 
-static struct pci_driver __devinitdata ioc4_driver = {
+static struct pci_driver ioc4_driver = {
 	.name = "IOC4",
 	.id_table = ioc4_id_table,
 	.probe = ioc4_probe,

-- 
http://www.codemonkey.org.uk

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270870AbTHATgg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270862AbTHATcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:32:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:6847 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270677AbTHATcW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:32:22 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10597663191966@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test2
In-Reply-To: <10597663161736@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Aug 2003 12:31:59 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1547.10.4, 2003/07/31 16:07:47-07:00, greg@kroah.com

[PATCH] PCI: pci_device_id can not be marked __devinitdata.

Last straggler in arch/mips/*


 arch/mips/vr41xx/common/vrc4173.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/mips/vr41xx/common/vrc4173.c b/arch/mips/vr41xx/common/vrc4173.c
--- a/arch/mips/vr41xx/common/vrc4173.c	Fri Aug  1 12:18:29 2003
+++ b/arch/mips/vr41xx/common/vrc4173.c	Fri Aug  1 12:18:29 2003
@@ -53,7 +53,7 @@
 #define VRC4173_SYSINT1REG	0x060
 #define VRC4173_MSYSINT1REG	0x06c
 
-static struct pci_device_id vrc4173_table[] __devinitdata = {
+static struct pci_device_id vrc4173_table[] = {
 	{PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_VRC4173, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0, }
 };


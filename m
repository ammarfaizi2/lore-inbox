Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265865AbUFXWPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUFXWPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUFXWPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:15:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:42934 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265775AbUFXVrh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:37 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <10881135682040@kroah.com>
Date: Thu, 24 Jun 2004 14:46:09 -0700
Message-Id: <10881135681488@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1823.1.11, 2004/06/23 16:59:52-07:00, ossi@kde.org

[PATCH] PCI: (one more) PCI quirk for SMBus bridge on Asus P4 boards

my board has one of those "clever" bioses that hide the smbus. this tiny
patch adds it to the Bad Guy List (TM).


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/quirks.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-06-24 13:49:17 -07:00
+++ b/drivers/pci/quirks.c	2004-06-24 13:49:17 -07:00
@@ -705,6 +705,7 @@
 		}
 	if (dev->device == PCI_DEVICE_ID_INTEL_82845G_HB)
 		switch(dev->subsystem_device) {
+ 		case 0x80b1: /* P4GE-V */
 		case 0x80b2: /* P4PE */
  		case 0x8093: /* P4B533-V */
 			asus_hides_smbus = 1;


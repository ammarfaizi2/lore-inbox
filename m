Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbVAJRiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbVAJRiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVAJRhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:37:50 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:17543 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262338AbVAJRVA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:21:00 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI patches for 2.6.10
User-Agent: Mutt/1.5.6i
In-Reply-To: <1105377659183@kroah.com>
Date: Mon, 10 Jan 2005 09:20:59 -0800
Message-Id: <11053776591967@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.447.18, 2004/12/22 09:46:15-08:00, greg@kroah.com

PCI: fix bttv-driver "cleanup" that called an incorrect function.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/media/video/bttv-driver.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
--- a/drivers/media/video/bttv-driver.c	2005-01-10 08:59:42 -08:00
+++ b/drivers/media/video/bttv-driver.c	2005-01-10 08:59:42 -08:00
@@ -3942,7 +3942,7 @@
 
 	/* save pci state */
 	pci_save_state(pci_dev);
-	if (0 != pci_set_power_state(pci_dev, device_to_pci_power(pci_dev, state))) {
+	if (0 != pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state))) {
 		pci_disable_device(pci_dev);
 		btv->state.disabled = 1;
 	}


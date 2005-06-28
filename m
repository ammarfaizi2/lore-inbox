Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVF1GH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVF1GH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVF1FkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:40:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:8684 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261642AbVF1Fde convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:34 -0400
Cc: gud@eth.net
Subject: [PATCH] pci: remove deprecates
In-Reply-To: <11199367711777@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:51 -0700
Message-Id: <11199367714038@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] pci: remove deprecates

Replace pci_find_device() with more safer pci_get_device().

Signed-off-by: Amit Gud <gud@eth.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 881a8c120acf7ec09c90289e2996b7c70f51e996
tree edac4f63c30cbda0604e722056b5bb2876ddd67d
parent 120bb4246a99cc6e9cc976573fcbcd0ee9d544ef
author Amit Gud <gud@eth.net> Tue, 12 Apr 2005 19:03:33 +0530
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:38 -0700

 drivers/char/moxa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -451,7 +451,7 @@ static int __init moxa_init(void)
 		int n = (sizeof(moxa_pcibrds) / sizeof(moxa_pcibrds[0])) - 1;
 		i = 0;
 		while (i < n) {
-			while ((p = pci_find_device(moxa_pcibrds[i].vendor, moxa_pcibrds[i].device, p))!=NULL)
+			while ((p = pci_get_device(moxa_pcibrds[i].vendor, moxa_pcibrds[i].device, p))!=NULL)
 			{
 				if (pci_enable_device(p))
 					continue;


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVKEXxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVKEXxA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 18:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVKEXxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 18:53:00 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:15468 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932219AbVKEXw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 18:52:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:organization:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=laZNERqP6TddXK42e0S7704PDjWf9dqi+NqBGkgBAqyhmADqBaqKr2FOA/3FEzdESrpFWtQ9J0zCc7NwJBLliiLxzlTw8uBZ1nRlodw0gyfh3xA1cPE6LQsk8+cAvwPoTCXJJgPTm76ffX4sesLPa5MzDk43EDcwMezuay996Ro=
Message-ID: <436D45D3.4060807@gmail.com>
Date: Sun, 06 Nov 2005 10:52:51 +1100
From: Grant Coady <gcoady@gmail.com>
Organization: http://bugsplatter.mine.nu/
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chun-Chung Chen <cjj@u.washington.edu>
Subject: [PATCH] pci_ids cleanup: fix two additional IDs in bt87x
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I missed a couple PCI IDs in bt87x.c, so here they are.

Cheers,
Grant.

From: Grant Coady <gcoady@gmail.com>

pci_ids cleanup: fixup bt87x.c: two macro defined IDs missed in prior cleanup.

Caught by Chun-Chung Chen <cjj@u.washington.edu>: "In the patch for bt87x.c,
you seemed have missed the two occurrences of BT_DEVICE on line 897 and
line 898."

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 bt87x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14b/sound/pci/bt87x.c~	2005-11-06 10:13:56.000000000 +1100
+++ linux-2.6.14b/sound/pci/bt87x.c	2005-11-06 10:17:08.000000000 +1100
@@ -897,8 +897,8 @@
 /* default entries for all Bt87x cards - it's not exported */
 /* driver_data is set to 0 to call detection */
 static struct pci_device_id snd_bt87x_default_ids[] = {
-	BT_DEVICE(878, PCI_ANY_ID, PCI_ANY_ID, 0),
-	BT_DEVICE(879, PCI_ANY_ID, PCI_ANY_ID, 0),
+	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, PCI_ANY_ID, PCI_ANY_ID, 0),
+	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_879, PCI_ANY_ID, PCI_ANY_ID, 0),
 	{ }
 };


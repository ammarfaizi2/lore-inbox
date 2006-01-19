Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWASCOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWASCOu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 21:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWASCOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 21:14:50 -0500
Received: from mail14.bluewin.ch ([195.186.19.62]:38627 "EHLO
	mail14.bluewin.ch") by vger.kernel.org with ESMTP id S932363AbWASCOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 21:14:48 -0500
Date: Wed, 18 Jan 2006 21:12:57 -0500
To: gregkh@suse.de
Cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org, apgo@patchbomb.org
Subject: [PATCH] cyblafb: remove pci_module_init() return, really.
Message-ID: <20060119021257.GB23678@krypton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson <ricknu-0@student.ltu.se> did the original pci_module_init()
cleanups:

    http://marc.theaimsgroup.com/?l=linux-kernel&m=113330872125068&w=2
    http://marc.theaimsgroup.com/?l=linux-kernel&m=113330888507321&w=2

Greg, on it's way upstream, pci_module_init() return sneaked back in for
cyblafb?

    http://marc.theaimsgroup.com/?l=linux-pci&m=113652969209562&w=2
    http://marc.theaimsgroup.com/?l=linux-pci&m=113683930220421&w=2

Remove for good.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>

---

 drivers/video/cyblafb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

11ebdedfa0d3c2b0dd5173c893b89ab9a16b2f97
diff --git a/drivers/video/cyblafb.c b/drivers/video/cyblafb.c
index 2b97246..0ae0a97 100644
--- a/drivers/video/cyblafb.c
+++ b/drivers/video/cyblafb.c
@@ -1665,7 +1665,6 @@ static int __devinit cyblafb_init(void)
 		}
 #endif
 	output("CyblaFB version %s initializing\n", VERSION);
-	return pci_module_init(&cyblafb_pci_driver);
 	return pci_register_driver(&cyblafb_pci_driver);
 }
 
-- 
1.0.0b

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWATTLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWATTLA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWATTJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:09:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:40912 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932075AbWATTFK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:10 -0500
Cc: apgo@patchbomb.org
Subject: [PATCH] PCI: cyblafb: remove pci_module_init() return, really.
In-Reply-To: <11377838802978@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:40 -0800
Message-Id: <11377838801772@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: cyblafb: remove pci_module_init() return, really.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit f4be67dc68bec2cddfe147642a7411b5e1dd9af1
tree 39ef2de1a00a98cf1fd58c2990e23745a3b5162c
parent 2f8d04252f3ae653d142229c2f28ff88afb46ed8
author Arthur Othieno <apgo@patchbomb.org> Wed, 18 Jan 2006 21:12:57 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:36 -0800

 drivers/video/cyblafb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

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
 


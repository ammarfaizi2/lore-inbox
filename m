Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUBJADZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUBJABP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:01:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:55740 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265393AbUBIXWa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:30 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689382788@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:18 -0800
Message-Id: <10763689381296@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.9, 2004/02/02 11:50:52-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: Kill useless instructions from ibmphp_core.c

This kills the explicit setting of rc to -ENODEV in 2 places where it is
not necessary because it will have this value on this path anyway.


 drivers/pci/hotplug/ibmphp_core.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	Mon Feb  9 14:59:13 2004
+++ b/drivers/pci/hotplug/ibmphp_core.c	Mon Feb  9 14:59:13 2004
@@ -418,8 +418,7 @@
 				rc = -ENODEV;
 			}
 		}
-	} else
-		rc = -ENODEV;
+	}
 
 	ibmphp_unlock_operations ();
 	debug ("%s - Exit rc[%d] value[%x]\n", __FUNCTION__, rc, *value);
@@ -465,8 +464,7 @@
 				}
 			}
 		}
-	} else
-		rc = -ENODEV;
+	}
 
 	ibmphp_unlock_operations ();
 	debug ("%s - Exit rc[%d] value[%x]\n", __FUNCTION__, rc, *value);


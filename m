Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbULET6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbULET6I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 14:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbULET6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 14:58:07 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:25285 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261369AbULET6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 14:58:00 -0500
Message-ID: <41B36845.4080004@g-house.de>
Date: Sun, 05 Dec 2004 20:57:57 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: sheutlin@gmx.de
CC: linuxppc-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Sven Hartge <hartge@ds9.argh.org>
Subject: [PATCH] linux 2.6 not^Wnow working with PReP (ppc32)
References: <41B23DF2.4010303@g-house.de> <1102207299.6778.16.camel@weizen.left.earth>
In-Reply-To: <1102207299.6778.16.camel@weizen.left.earth>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090607070008000300020808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090607070008000300020808
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

whoops! a bit too early, i had to change 3 lines, not one.


Signed-off-by: Christian Kujau <evil@g-house.de>


(new patch attached; credits should go to Sebastian Heutling aka
sheutlin@gmx.de)


thanks,
Christian.
- --
BOFH excuse #304:

routing problems on the neural net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBs2hE+A7rjkF8z0wRAi+3AJ42GZlqMZen6lqMwtyQSMbS61tkbwCeMNET
nKgGhTpgwAcCJJ0hWUKoFqg=
=xyi5
-----END PGP SIGNATURE-----

--------------090607070008000300020808
Content-Type: text/x-patch;
 name="prep_pci_renumbered-2.6.10-rc3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prep_pci_renumbered-2.6.10-rc3.patch"

--- linux-2.6-BK/arch/ppc/platforms/prep_pci.c	2004-12-05 20:46:33.000000000 +0100
+++ linux-2.6-BK/arch/ppc/platforms/prep_pci.c.edited	2004-12-05 20:45:55.000000000 +0100
@@ -49,10 +49,10 @@
         0,   /* Slot 1  - unused */
         5,   /* Slot 2  - SCSI - NCR825A  */
         0,   /* Slot 3  - unused */
-        1,   /* Slot 4  - Ethernet - DEC2114x */
+        3,   /* Slot 4  - Ethernet - DEC2114x */
         0,   /* Slot 5  - unused */
-        3,   /* Slot 6  - PCI Card slot #1 */
-        4,   /* Slot 7  - PCI Card slot #2 */
+        2,   /* Slot 6  - PCI Card slot #1 */
+        3,   /* Slot 7  - PCI Card slot #2 */
         5,   /* Slot 8  - PCI Card slot #3 */
         5,   /* Slot 9  - PCI Bridge */
              /* added here in case we ever support PCI bridges */

--------------090607070008000300020808--

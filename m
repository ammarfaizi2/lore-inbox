Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131021AbQLMQQN>; Wed, 13 Dec 2000 11:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131305AbQLMQQE>; Wed, 13 Dec 2000 11:16:04 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:30227 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S131021AbQLMQP4>; Wed, 13 Dec 2000 11:15:56 -0500
Date: Wed, 13 Dec 2000 16:45:02 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: andrewm@uow.edu.au
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] cs89x0 is not only an ISA card
Message-ID: <20001213164501.A15157@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Crystal CS89x0 ethernet chip is also used in quite some embedded
systems that don't have an ISA bus at all, so the CONFIG_ISA option in
drivers/net/Config.in is inapropriate. Here is a patch against
2.4.0-test12 to fix that. Please consider applying.


Erik


Index: drivers/net/Config.in
===================================================================
RCS file: /home/erik/cvsroot/elinux/drivers/net/Config.in,v
retrieving revision 1.1.1.39
diff -u -r1.1.1.39 Config.in
--- drivers/net/Config.in	2000/12/07 14:16:21	1.1.1.39
+++ drivers/net/Config.in	2000/12/13 14:22:02
@@ -134,7 +138,7 @@
       fi
 
       tristate '    Apricot Xen-II on board Ethernet' CONFIG_APRICOT
-      dep_tristate '    CS89x0 support' CONFIG_CS89x0 $CONFIG_ISA
+      tristate '    CS89x0 support' CONFIG_CS89x0
       dep_tristate '    DECchip Tulip (dc21x4x) PCI support' CONFIG_TULIP $CONFIG_PCI
       if [ "$CONFIG_PCI" = "y" -o "$CONFIG_EISA" = "y" ]; then
          tristate '    Generic DECchip & DIGITAL EtherWORKS PCI/EISA' CONFIG_DE4X5


-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

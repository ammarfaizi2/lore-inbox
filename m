Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288050AbSBNIxC>; Thu, 14 Feb 2002 03:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288047AbSBNIwy>; Thu, 14 Feb 2002 03:52:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7684 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288012AbSBNIwj>;
	Thu, 14 Feb 2002 03:52:39 -0500
Message-ID: <3C6B7AD5.CF4CCA0A@mandrakesoft.com>
Date: Thu, 14 Feb 2002 03:52:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] via-rhine build fix
Content-Type: multipart/mixed;
 boundary="------------A30E28B411ED198EC6D49FAE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A30E28B411ED198EC6D49FAE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus,

This one slipped by me... a partial via-rhine change, resulting in build
breakage.  This patch, with BK cset info, fixes.

There is also an automerged 8139too recalc_sigpending() change I caught
at the last minute, that you might get when you pull... your tree might
already have this.  It's an ok change though, cset log included.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
--------------A30E28B411ED198EC6D49FAE
Content-Type: text/plain; charset=us-ascii;
 name="net-drivers-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.txt"



Pull from:  http://gkernel.bkbits.net/net-drivers-2.5


---------------------------------------------------------------------------
ChangeSet@1.333, 2002-02-14 03:25:36-05:00, jgarzik@rum.normnet.org
  Add board id to via-rhine net driver, for board added in
  previous revision (thus fixing the build).

 drivers/net/via-rhine.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

ChangeSet@?????, jgarzik@rum.normnet.org
  Update 8139too net driver to new arg-free recalc_sigpending() API
  function

 drivers/net/8139too.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

---------------------------------------------------------------------------

--------------A30E28B411ED198EC6D49FAE
Content-Type: text/plain; charset=us-ascii;
 name="via-rhine-2.5.5.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-rhine-2.5.5.1.patch"

diff -Nru a/drivers/net/via-rhine.c b/drivers/net/via-rhine.c
--- a/drivers/net/via-rhine.c	Thu Feb 14 03:27:48 2002
+++ b/drivers/net/via-rhine.c	Thu Feb 14 03:27:48 2002
@@ -321,6 +321,7 @@
 	VT86C100A = 0,
 	VT6102,
 	VT3043,
+	VT6105,
 };
 
 struct via_rhine_chip_info {
@@ -349,7 +350,7 @@
 	{ "VIA VT6102 Rhine-II", RHINE_IOTYPE, 256,
 	  CanHaveMII | HasWOL },
 	{ "VIA VT3043 Rhine",    RHINE_IOTYPE, 128,
-	  CanHaveMII | ReqTxAlign }
+	  CanHaveMII | ReqTxAlign },
 	{ "VIA VT6105 Rhine-III", RHINE_IOTYPE, 256,
 	  CanHaveMII | HasWOL },
 };

--------------A30E28B411ED198EC6D49FAE--


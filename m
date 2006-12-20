Return-Path: <linux-kernel-owner+w=401wt.eu-S965072AbWLTOKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWLTOKM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWLTOKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:10:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:30940 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965072AbWLTOKK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:10:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ou4GohiUSRC4UYjdIDD4Vlgj2cQACuWwfO+c+Vp9UoeHQfSpnj8/56PKWbhOiiJh90sP7/65IAVor2AAZ7AY7QT5AYa/IuTsJKPOMgVmEjyUjXUiP/A7IPf8eo4UIi8xb1uS/X6uqXEDj0vw932B/K+MyFQmcMaZForPNxnqiRk=
Date: Wed, 20 Dec 2006 15:10:00 +0100
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH update9] drivers: add LCD support
Message-Id: <20061220151000.27602c37.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, another one for drivers-add-lcd-support saga. Thanks you.
---

 - Fix Randy Dunlap's points:
    · Adds CONFIG_FB dependency to CONFIG_CFAG12864B
    · Spelling fix and improved help.

 Kconfig |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

drivers-add-lcd-support-update9.patch
Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 8d41f72..a6fc2b7 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -65,6 +65,7 @@ config KS0108_DELAY
 config CFAG12864B
        tristate "CFAG12864B LCD"
        depends on X86
+       depends on FB
        depends on KS0108
        default n
        ---help---
@@ -74,6 +75,8 @@ config CFAG12864B
          For help about how to wire your LCD to the parallel port,
          check Documentation/auxdisplay/cfag12864b

+         Depends on the x86 arch and the framebuffer support.
+
          The LCD framebuffer driver can be attached to a console.
          It will work fine. However, you can't attach it to the fbdev driver
          of the xorg server.
@@ -84,7 +87,7 @@ config CFAG12864B
          If unsure, say N.

 config CFAG12864B_RATE
-       int "Refresh rate (hertzs)"
+       int "Refresh rate (hertz)"
        depends on CFAG12864B
        default "20"
        ---help---
@@ -104,4 +107,3 @@ config CFAG12864B_RATE
          If you compile this as a module, you can still override this
          value using the module parameters.
 endmenu
-

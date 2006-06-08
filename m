Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWFHUJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWFHUJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWFHUJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:09:44 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:14824 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S964965AbWFHUJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:09:43 -0400
Date: Thu, 8 Jun 2006 17:09:48 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: rmk+lkml@arm.linux.org.uk
Cc: alan@lxorguk.ukuu.org.uk, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial-core: Updates documentation.
Message-ID: <20060608170948.327372cc@doriath.conectiva>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.1 (GTK+ 2.9.1; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 tx_empty(), break_ctl() and set_termios() are not called in atomic context,
they are allowed to sleep.

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

---

 Documentation/serial/driver |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

7e65eee0ccc08beec8b98d2a31c2b6807cd29ba2
diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 88ad615..e6fabba 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -78,7 +78,6 @@ hardware.
 
 	Locking: none.
 	Interrupts: caller dependent.
-	This call must not sleep
 
   set_mctrl(port, mctrl)
 	This function sets the modem control lines for port described
@@ -160,7 +159,6 @@ hardware.
 
 	Locking: none.
 	Interrupts: caller dependent.
-	This call must not sleep
 
   startup(port)
 	Grab any interrupt resources and initialise any low level driver
@@ -227,7 +225,6 @@ hardware.
 
 	Locking: none.
 	Interrupts: caller dependent.
-	This call must not sleep
 
   pm(port,state,oldstate)
 	Perform any power management related activities on the specified
-- 
1.3.3



-- 
Luiz Fernando N. Capitulino

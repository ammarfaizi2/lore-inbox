Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264846AbRGEINF>; Thu, 5 Jul 2001 04:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264847AbRGEIMp>; Thu, 5 Jul 2001 04:12:45 -0400
Received: from ns.suse.de ([213.95.15.193]:34822 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S264846AbRGEIMi>;
	Thu, 5 Jul 2001 04:12:38 -0400
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: N_HCI for S390x missing in 2.4.5
From: Andreas Jaeger <aj@suse.de>
Date: Thu, 05 Jul 2001 10:12:36 +0200
Message-ID: <ho3d8beqvf.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking at the patch for 2.4.5, I noticed that all architectures use
N_HCI - except s390x which has N_BT.

Why is this different?  I propose to use N_HCI everywhere,

Andreas

diff -u --recursive --new-file v2.4.5/linux/include/asm-s390/termios.h linux/include/asm-s390/termios.h
--- v2.4.5/linux/include/asm-s390/termios.h     Tue Feb 13 14:13:44 2001
+++ linux/include/asm-s390/termios.h    Mon Jun 11 19:15:27 2001
@@ -63,6 +63,7 @@
 #define N_IRDA         11      /* Linux IR - http://irda.sourceforge.net/ */
 #define N_SMSBLOCK     12      /* SMS block mode - for talking to GSM data cards about SMS messages */
 #define N_HDLC         13      /* synchronous HDLC */
+#define N_HCI          15  /* Bluetooth HCI UART */
diff -u --recursive --new-file v2.4.5/linux/include/asm-s390x/termios.h linux/include/asm-s390x/termios.h
--- v2.4.5/linux/include/asm-s390x/termios.h    Wed Apr 11 19:02:29 2001
+++ linux/include/asm-s390x/termios.h   Mon Jun 11 19:15:27 2001
@@ -63,6 +63,7 @@
 #define N_IRDA         11      /* Linux IR - http://irda.sourceforge.net/ */
 #define N_SMSBLOCK     12      /* SMS block mode - for talking to GSM data cards about SMS messages */
 #define N_HDLC         13      /* synchronous HDLC */
+#define N_BT           15      /* bluetooth */
 

-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj

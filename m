Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265807AbRGGCdc>; Fri, 6 Jul 2001 22:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbRGGCdW>; Fri, 6 Jul 2001 22:33:22 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:9739 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S265807AbRGGCdT>;
	Fri, 6 Jul 2001 22:33:19 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15174.29838.622252.962233@tango.paulus.ozlabs.org>
Date: Sat, 7 Jul 2001 12:31:42 +1000 (EST)
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] fix drivers/usb/scanner.c ioctl return
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch corrects the return value from the ioctl function
in the USB scanner code, in the case where the ioctl is unrecognized.

Linus, please apply.

Paul.

diff -urN linux/drivers/usb/scanner.c pmac/drivers/usb/scanner.c
--- linux/drivers/usb/scanner.c	Sat Apr 28 23:02:49 2001
+++ pmac/drivers/usb/scanner.c	Thu Jun 28 17:28:25 2001
@@ -909,7 +909,7 @@
 		return result;
 	}
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	}
 	return 0;
 }

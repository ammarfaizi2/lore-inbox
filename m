Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135535AbRAUFvh>; Sun, 21 Jan 2001 00:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135533AbRAUFv1>; Sun, 21 Jan 2001 00:51:27 -0500
Received: from linuxcare.com.au ([203.29.91.49]:62991 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S135460AbRAUFvO>; Sun, 21 Jan 2001 00:51:14 -0500
From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14954.31040.647996.752037@gargle.gargle.HOWL>
Date: Sun, 21 Jan 2001 16:53:04 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: rwsemaphores and modules
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@linuxcare.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know why we have this code in include/linux/usbdevicefs.h?
Is it still needed?

/*
 * sigh. rwsemaphores do not (yet) work from modules
 */

#define rw_semaphore semaphore
#define init_rwsem init_MUTEX
#define down_read down
#define down_write down
#define up_read up
#define up_write up

Paul.

-- 
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWECMSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWECMSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbWECMSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:18:48 -0400
Received: from k2smtpout02-01.prod.mesa1.secureserver.net ([64.202.189.90]:64483
	"HELO k2smtpout02-01.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S965178AbWECMSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:18:47 -0400
X-Antivirus-MYDOMAIN-Mail-From: razvan.g@plutohome.com via plutohome.com.secureserver.net
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:0(82.77.255.201):SA:0(-2.3/5.0):. Processed in 3.810036 secs Process 31032)
Message-ID: <44589FB0.6090909@plutohome.com>
Date: Wed, 03 May 2006 15:18:56 +0300
From: Razvan Gavril <razvan.g@plutohome.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftdi_sio: ACT Solutions HomePro ZWave interface
References: <44572749.6090103@plutohome.com> <20060502200532.GA8172@kroah.com>
In-Reply-To: <20060502200532.GA8172@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, May 02, 2006 at 12:32:57PM +0300, Razvan Gavril wrote:
>
> Care to diff this against 2.6.17-rc3?  Lots of ftdi new device ids have
> been added there.
>
> You also forgot to add a "Signed-off-by:" line :(

Signed-Off By: Razvan Gavril <razvan.g@plutohome.com>
---

diff -Nur linux-2.6.17-rc3-orig/drivers/usb/serial/ftdi_sio.c 
linux-2.6.17-rc3/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.17-rc3-orig/drivers/usb/serial/ftdi_sio.c 2006-05-03 
15:12:01.000000000 +0300
+++ linux-2.6.17-rc3/drivers/usb/serial/ftdi_sio.c      2006-05-03 
15:04:39.000000000 +0300
@@ -307,6 +307,7 @@


 static struct usb_device_id id_table_combined [] = {
+       { USB_DEVICE(FTDI_VID, FTDI_ACTZWAVE_PID) },
        { USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
        { USB_DEVICE(FTDI_VID, FTDI_SIO_PID) },
        { USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },
diff -Nur linux-2.6.17-rc3-orig/drivers/usb/serial/ftdi_sio.h 
linux-2.6.17-rc3/drivers/usb/serial/ftdi_sio.h
--- linux-2.6.17-rc3-orig/drivers/usb/serial/ftdi_sio.h 2006-05-03 
15:09:33.000000000 +0300
+++ linux-2.6.17-rc3/drivers/usb/serial/ftdi_sio.h      2006-05-03 
15:13:26.000000000 +0300
@@ -32,6 +32,10 @@
 #define FTDI_NF_RIC_PID        0x0001  /* Product Id */


+/* ACT Solutions HomePro ZWave interface 
(http://www.act-solutions.com/HomePro.htm) */
+#define FTDI_ACTZWAVE_PID      0xF2D0
+
+
 /* www.irtrans.de device */
 #define FTDI_IRTRANS_PID 0xFC60 /* Product Id */


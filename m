Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVAIFfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVAIFfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 00:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVAIFfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 00:35:15 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:49559 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262258AbVAIFfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 00:35:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Sun, 9 Jan 2005 00:35:02 -0500
User-Agent: KMail/1.6.2
Cc: Roey Katz <roey@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <d120d50005010707204463492@mail.gmail.com> <Pine.NEB.4.61.0501090513180.18441@sdf.lonestar.org>
In-Reply-To: <Pine.NEB.4.61.0501090513180.18441@sdf.lonestar.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501090035.07247.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 January 2005 12:14 am, Roey Katz wrote:
> Dmitry,
> 
> maybe I'm misunderstanding you;  how should the file look like once I 
> modify it with your changes (what does "reversing the fragment" mean 
> here)?
>

Now that I am at my box, just try applying the patch below.

-- 
Dmitry

===== drivers/Makefile 1.50 vs edited =====
--- 1.50/drivers/Makefile	2004-12-01 01:00:21 -05:00
+++ edited/drivers/Makefile	2005-01-09 00:33:32 -05:00
@@ -21,9 +21,6 @@
 obj-$(CONFIG_FB_I810)           += video/i810/
 obj-$(CONFIG_FB_INTEL)          += video/intelfb/
 
-# we also need input/serio early so serio bus is initialized by the time
-# serial drivers start registering their serio ports
-obj-$(CONFIG_SERIO)		+= input/serio/
 obj-y				+= serial/
 obj-$(CONFIG_PARPORT)		+= parport/
 obj-y				+= base/ block/ misc/ net/ media/
@@ -46,6 +43,7 @@
 obj-$(CONFIG_TC)		+= tc/
 obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
+obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_I2O)		+= message/

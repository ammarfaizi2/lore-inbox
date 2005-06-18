Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVFRAuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVFRAuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 20:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVFRAuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 20:50:19 -0400
Received: from [62.101.100.8] ([62.101.100.8]:50915 "EHLO smtpout1.reply.it")
	by vger.kernel.org with ESMTP id S261662AbVFRAuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 20:50:10 -0400
From: "Daniele Gaffuri" <d.gaffuri@reply.it>
To: "'Greg KH'" <gregkh@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Hidden SMBus bridge on Toshiba Tecra M2
Date: Sat, 18 Jun 2005 02:50:05 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0006_01C573B0.6EA76670"
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20050617224953.GA23742@suse.de>
Thread-Index: AcVzjue2+h0HmgCtRZGpOdyj1XPDhwAEIkXQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Message-ID: <TO1FRES03jlGiFdfg3o00004555@to1fres03.replynet.prv>
X-OriginalArrivalTime: 18 Jun 2005 00:50:08.0891 (UTC) FILETIME=[ACF8D4B0:01C5739F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0006_01C573B0.6EA76670
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Sat, Jun 18, 2005 at 12:36:18AM +0200, Daniele Gaffuri wrote:
>> Here's a trivial patch, against 2.6.12-rc6, to unhide SMBus on
>> Toshiba Centrino laptops using Intel 82855PM chipset.
> 
> Your patch is linewrapped, and missing a Signed-off-by: line.  Care to
> redo it?
> 
> thanks,
> 
> greg k-h

Sorry. Didn't realize. Trying to attach to avoid it.

Trivial patch, against 2.6.12-rc6, to unhide SMBus on Toshiba Centrino
laptops using Intel 82855PM chipset

Signed-off-by: Daniele Gaffuri <d.gaffuri@reply.it>

Daniele

------=_NextPart_000_0006_01C573B0.6EA76670
Content-Type: text/plain;
	name="patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch.txt"

--- linux-2.6.12-rc6/drivers/pci/quirks.c	2005-06-17 23:49:32.000000000 =
+0200=0A=
+++ linux/drivers/pci/quirks.c	2005-06-18 00:06:45.000000000 +0200=0A=
@@ -822,6 +822,11 @@=0A=
 			case 0x0001: /* Toshiba Satellite A40 */=0A=
 				asus_hides_smbus =3D 1;=0A=
 			}=0A=
+		if (dev->device =3D=3D  PCI_DEVICE_ID_INTEL_82855PM_HB)=0A=
+			switch(dev->subsystem_device) {=0A=
+			case 0x0001: /* Toshiba Tecra M2 */=0A=
+				asus_hides_smbus =3D 1;=0A=
+			}=0A=
        } else if (unlikely(dev->subsystem_vendor =3D=3D =
PCI_VENDOR_ID_SAMSUNG)) {=0A=
                if (dev->device =3D=3D  PCI_DEVICE_ID_INTEL_82855PM_HB)=0A=
                        switch(dev->subsystem_device) {=0A=

------=_NextPart_000_0006_01C573B0.6EA76670--


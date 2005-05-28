Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVE1Bes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVE1Bes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 21:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVE1Bes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 21:34:48 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:40862 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S261908AbVE1Bef convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 21:34:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: How to find if BIOS has already enabled the device
Date: Fri, 27 May 2005 18:34:50 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to find if BIOS has already enabled the device
Thread-Index: AcVjHXRDo+2KyjjBSjGOpIC8EOiAdgAB6+8A
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Parag Warudkar" <kernel-stuff@comcast.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 May 2005 01:34:34.0973 (UTC) FILETIME=[6767E8D0:01C56325]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am trying to trace the root cause of an annoying problem 
>with a USB Storage 
>device - 
>
>My laptop's BIOS supports booting from USB devices. I have attached an 
>external USB HDD to a USB 2.0 port. If I boot Linux with the 
>HDD attached and 
>powered on, load of OHCI-HCD module hangs the machine for 
>around 2 minutes - 
>after that it recovers and all is fine. I have tried different distros 
>without luck, but while installing debian, I figured out that the hang 
>happens after ohci-hcd calls pci_enable_device() for the USB 
>controller.
>
>This does not happen when the boot is complete. I.e. if I 
>attach the HDD after 
>boot is complete (BIOS did not get a chance to enable it 
>beforehand) load of 
>ohci-hcd (during and after boot) does not hang the machine.
>
>I think since the machine supports booting from USB HDD, the 
>BIOS must be 
>enabling the USB controller and attached device early during 
>boot, and when 
>ohci-hcd tries to re-enable it, it doesn't like it and leads 
>to a hang. 

See if 'usb-handoff' as a kernel parameter makes it any better.

Aleks.

>
>My question - Is it possible to detect if the USB controller 
>is already 
>enabled and skip enabling it second time?
>
>Thanks
>
>Parag
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

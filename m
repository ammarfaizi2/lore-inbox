Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWIHOZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWIHOZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 10:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWIHOZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 10:25:09 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:10406 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750746AbWIHOZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 10:25:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc6-mm1
Date: Fri, 8 Sep 2006 16:26:42 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <20060908011317.6cb0495a.akpm@osdl.org>
In-Reply-To: <20060908011317.6cb0495a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609081626.43262.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 8 September 2006 10:13, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/

ohci_hcd doesn't work after a resume from disk on HPC nx6325, worked on
2.6.18-rc5-mm1.

It helps if I rmmod and modprobe it after the resume.

Here's the relevant part of the dmesg output:

usb usb1: resuming
 usbdev1.1_ep00: PM: resume from 0, parent usb1 still 1
hub 1-0:1.0: PM: resume from 0, parent usb1 still 1
hub 1-0:1.0: resuming
 usbdev1.1: PM: resume from 0, parent usb1 still 1
usb usb2: resuming
usb usb2: root hub lost power or was reset
 usbdev2.1_ep00: PM: resume from 0, parent usb2 still 1
hub 2-0:1.0: PM: resume from 0, parent usb2 still 1
hub 2-0:1.0: resuming
 usbdev2.1: PM: resume from 0, parent usb2 still 1
usb usb3: resuming
usb usb3: root hub lost power or was reset
 usbdev3.1_ep00: PM: resume from 0, parent usb3 still 1
hub 3-0:1.0: PM: resume from 0, parent usb3 still 1
hub 3-0:1.0: resuming
 usbdev3.1: PM: resume from 0, parent usb3 still 1
usb 2-2: PM: resume from 1, parent usb2 still 1
usb 2-2: resuming
 usbdev2.2_ep00: PM: resume from 0, parent 2-2 still 1
hci_usb 2-2:1.0: PM: resume from 1, parent 2-2 still 1
hci_usb 2-2:1.0: resuming
 usbdev2.2_ep81: PM: resume from 0, parent 2-2:1.0 still 1
 usbdev2.2_ep82: PM: resume from 0, parent 2-2:1.0 still 1
 usbdev2.2_ep02: PM: resume from 0, parent 2-2:1.0 still 1
hci_usb 2-2:1.1: PM: resume from 1, parent 2-2 still 1
hci_usb 2-2:1.1: resuming
usb 2-2:1.2: PM: resume from 1, parent 2-2 still 1
usb 2-2:1.2: resuming
 usbdev2.2_ep84: PM: resume from 0, parent 2-2:1.2 still 1
 usbdev2.2_ep04: PM: resume from 0, parent 2-2:1.2 still 1
usb 2-2:1.3: PM: resume from 1, parent 2-2 still 1
usb 2-2:1.3: resuming
 usbdev2.2: PM: resume from 0, parent 2-2 still 1
platform bluetooth: resuming
usb 3-1: PM: resume from 1, parent usb3 still 1
usb 3-1: resuming
 usbdev3.2_ep00: PM: resume from 0, parent 3-1 still 1
usb 3-1:1.0: PM: resume from 1, parent 3-1 still 1
usb 3-1:1.0: resuming
 usbdev3.2_ep81: PM: resume from 0, parent 3-1:1.0 still 1
 usbdev3.2_ep02: PM: resume from 0, parent 3-1:1.0 still 1
 usbdev3.2: PM: resume from 0, parent 3-1 still 1
usb 3-4: PM: resume from 1, parent usb3 still 1
usb 3-4: resuming
 usbdev3.3_ep00: PM: resume from 0, parent 3-4 still 1
usbhid 3-4:1.0: PM: resume from 1, parent 3-4 still 1
usbhid 3-4:1.0: resuming
 usbdev3.3_ep81: PM: resume from 0, parent 3-4:1.0 still 1
 usbdev3.3: PM: resume from 0, parent 3-4 still 1
 usbdev2.2_ep83: PM: resume from 0, parent 2-2:1.1 still 1
 usbdev2.2_ep03: PM: resume from 0, parent 2-2:1.1 still 1
 hci0: PM: resume from 0, parent 2-2:1.0 still 1

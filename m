Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262468AbRFFFy5>; Wed, 6 Jun 2001 01:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263378AbRFFFys>; Wed, 6 Jun 2001 01:54:48 -0400
Received: from jcwren-1.dsl.speakeasy.net ([216.254.53.52]:18933 "EHLO
	jcwren.com") by vger.kernel.org with ESMTP id <S262468AbRFFFyj>;
	Wed, 6 Jun 2001 01:54:39 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: USBDEVFS_URB_TYPE_INTERRUPT
Date: Wed, 6 Jun 2001 01:54:32 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGGEICCIAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Sigh.  What do half the answers always show up seconds after clicking
'Send'?

	I see there is a FILL_URB_INT macro in linux/usb.h, but the only things
using it seem to be drivers (as opposed to usbstress, libusb, etc).  The
ioctl call supports USBDEVFS_SUBMITURB, but passing a type
USBDEVFS_URB_TYPE_INTERRUPT returns EINVAL.  If the ioctl calls are the
'proper' way to talk to the USB drivers, should my code be calling
usb_submit_urb directly if I want to pass interrupt type messages?

	I don't really want to write a full-up kernel mode driver for this device,
but interrupt type messages are the preferred method for communicating,
since once a message needs to be sent, it should be timely (whereas control
messages could be delayed a significant amount on a busy USB channel).

	-- John


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVBHQCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVBHQCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVBHQCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:02:40 -0500
Received: from mail1.kontent.de ([81.88.34.36]:38273 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261551AbVBHQCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:02:39 -0500
From: Oliver Neukum <oliver@neukum.org>
To: zyphr <infzyphr@gmail.com>
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Date: Tue, 8 Feb 2005 17:02:30 +0100
User-Agent: KMail/1.7.1
Cc: Mikkel Krautz <krautz@gmail.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com, vojtech@suse.cz
References: <20050207185706.GA6701@omnipotens.localhost> <3de2c80b050208071520375d28@mail.gmail.com>
In-Reply-To: <3de2c80b050208071520375d28@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502081702.30934.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 8. Februar 2005 16:15 schrieb zyphr:
> Something looks odd.
> I've tested this with 2.6.11-rc3-bk5 + your lasted patch
> 
> cat /sys/module/usbhid/parameters/mousepoll says it's at 2ms
> but if I check /proc/bus/usb/devices it's reading 10ms

You're reading the device descriptor. It is unchangeable.
Using the module parameter you can make the driver ignore
the value specified in the descriptor, not change the descriptor.

	Regards
		Oliver

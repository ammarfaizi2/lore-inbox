Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWBFSnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWBFSnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWBFSnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:43:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11691 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932272AbWBFSnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:43:51 -0500
Date: Mon, 6 Feb 2006 10:43:26 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Gabriel A. Devenyi" <devenyga@mcmaster.ca>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [BUG] USB HID fails to init USB keyboard
Message-Id: <20060206104326.6cde4100.zaitcev@redhat.com>
In-Reply-To: <43E74DDB.7070508@mcmaster.ca>
References: <mailman.1139192641.4990.linux-kernel2news@redhat.com>
	<20060205210211.675015ba.zaitcev@redhat.com>
	<43E74DDB.7070508@mcmaster.ca>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2006 08:23:39 -0500, "Gabriel A. Devenyi" <devenyga@mcmaster.ca> wrote:

> >> usb 2-4: new low speed USB device using ohci_hcd and address 3
> >> input: USB-compliant keyboard as /class/input/input2
> >> input: USB HID v1.10 Keyboard [USB-compliant keyboard] on usb-0000:00:02.0-4
> >> drivers/usb/input/hid-core.c: input irq status -32 received
> > 
> > The -32 is a stall, so it probably wants a NOGET quirk.

> Google tells me there's a blacklist to handle this, located in 
> drivers/usb/input/hid-core.c, what info do I need to correctly add this 
> keyboard/manufacturer to the blacklist?

Look at the P: line of your /proc/bus/usb/devices, it has the necessary
vendor and product IDs.

-- Pete

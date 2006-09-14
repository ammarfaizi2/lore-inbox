Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWINRWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWINRWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWINRWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:22:45 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:9994 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750826AbWINRWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:22:44 -0400
Date: Thu, 14 Sep 2006 13:22:43 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Robert Hancock <hancockr@shaw.ca>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
In-Reply-To: <200609141908.15991.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0609141320020.5715-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Rafael J. Wysocki wrote:

> Now USB didn't work after the first resume (kernel configured with USB_SUSPEND
> unset).
> 
> The dmesg output is attached.

This is getting too confusing.  :-(

Let's try a simpler test.  Leave USB_SUSPEND unset.

First rmmod ohci-hcd.  None of your full-speed USB devices will work, but 
that's okay.  Try the suspend-twice test and see what happens.

Second, rmmod ehci-hcd and modprobe ohci-hcd.  Again try the suspend-twice 
test.

Having only one USB host driver loaded at any time should simplify things.

Alan Stern


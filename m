Return-Path: <linux-kernel-owner+w=401wt.eu-S964930AbXAJQOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbXAJQOm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 11:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbXAJQOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 11:14:42 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:50458 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964930AbXAJQOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 11:14:41 -0500
Date: Wed, 10 Jan 2007 11:14:39 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oneukum@suse.de>
cc: Pavel Machek <pavel@ucw.cz>, <linux-usb-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: null pointer deref in khubd
In-Reply-To: <200701101653.57929.oneukum@suse.de>
Message-ID: <Pine.LNX.4.44L0.0701101112210.3289-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2007, Oliver Neukum wrote:

> Am Mittwoch, 10. Januar 2007 11:49 schrieb Pavel Machek:
> > usb 2-1: new full speed USB device using uhci_hcd and address 68
> > usb 2-1: USB disconnect, address 68
> > usb 2-1: unable to read config index 0 descriptor/start
> > usb 2-1: chopping to 0 config(s)
> 
> Does anybody know a legitimate reasons a device should have
> 0 configurations? Independent of the reason of this bug, should we disallow
> such devices and error out?

About the only reason to allow such devices is so that the user can run 
lsusb to try and get more information about the problem.  With no 
configurations, the device won't be useful for anything.

Alan Stern


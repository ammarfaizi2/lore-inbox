Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVFJKEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVFJKEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 06:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVFJKEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 06:04:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:21194 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262535AbVFJKEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 06:04:11 -0400
From: Marcus Meissner <meissner@suse.de>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Problems with usb and digital camera
In-Reply-To: <20050610085033.GA16936@kroah.com.suse.lists.linux.kernel>
X-Newsgroups: suse.lists.linux.kernel
User-Agent: tin/1.6.2-20030910 ("Pabbay") (UNIX) (Linux/2.6.11.10-3-ppc64 (ppc64))
Message-Id: <20050610100409.E28FC7E0A9@grape.suse.de>
Date: Fri, 10 Jun 2005 12:04:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050610085033.GA16936@kroah.com.suse.lists.linux.kernel> you wrote:
>> I have a Canon Powershot A70 and it used to work nicely with linux and
>> gnome. But now it has stopped working.

>> When I plug the camera, gthumb pops and try to import photos. But I get a
>> window with this message:
>> 
>> 
>> Jun  6 23:43:04 werewolf kernel: usb 5-2: new full speed USB device using uhci_hcd and address 6
>> Jun  6 23:45:38 werewolf kernel: usb 5-2: usbfs: interface 0 claimed by usbfs while 'gthumb' sets config #1
> 
> That looks fine.
> 
>> I have now 2.6.12-rc6-mm1. My USB pendrive works nicely.
>> 
>> Are you aware of any strange behaviour of USB in this kernel ?
> 
> Nope :)

This was a bug (?) in libgphoto2 which is fixed with 2.1.6rc2 or 
later.

Please download libgphoto2-2.1.6rc2 from sf.net/projects/gphoto 
and it will be fixed.

The technical problem was that that the libusb call
usb_set_configuration() could only be called with the USB interface
released via usb_release_interface() before.

I do not know why this is necessary, but we fixed it neithertheless.

Ciao, Marcus

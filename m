Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTDKUTx (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbTDKUTw (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:19:52 -0400
Received: from toq5-srv.bellnexxia.net ([209.226.175.27]:37252 "EHLO
	toq5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261710AbTDKUTv (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 16:19:51 -0400
Date: Fri, 11 Apr 2003 16:25:23 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Greg KH <greg@kroah.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: USB optical mouse on laptop causes bk12 boot to hang
In-Reply-To: <20030411201629.GR1821@kroah.com>
Message-ID: <Pine.LNX.4.44.0304111621050.11560-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003, Greg KH wrote:

> So if you load the usb core, and then plug in your usb device, does it
> all work after the machine has booted?

in a fairly recent posting, i clarified that a lot of the problem
seemed to be that many of my modules were simply not being loaded
on demand.  not only the USB stuff, but even the vfat module so
i could mount my windows partition.

i finally went back and just built all this stuff into the kernel,
and solved most (not quite all) of the problems.  i find this
kind of surprising -- i've never had to do this before.

and, to answer your question above, before i did all this, to
get my zip drive to work, i modprobe'd usbcore and usb-storage
manually.  to mount the windows partition, same with modprobe
and vfat.

and it's still a mystery why, before i did this, when i booted
with a USB optical mouse plugged in, it hung after
"Freeing unused kernel memory".  *that* is still a puzzler.

rday


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbULTPeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbULTPeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbULTP37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:29:59 -0500
Received: from ida.rowland.org ([192.131.102.52]:4356 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261540AbULTP0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:26:05 -0500
Date: Mon, 20 Dec 2004 10:25:58 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Pete Zaitcev <zaitcev@redhat.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, <mdharm-usb@one-eyed-alien.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: RFC: [2.6 patch] let BLK_DEV_UB depend on
 EMBEDDED
In-Reply-To: <20041219223006.4301bb8c@lembas.zaitcev.lan>
Message-ID: <Pine.LNX.4.44L0.0412201016510.1358-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2004, Pete Zaitcev wrote:

> I don't quite understand why it matters for you if a certain module
> is loaded or not loaded. The hotplug acts upon the contents of
> modules.usbmap which does not change when you modprobe or rmmod things.
> So, the match lists are made non-conflicting between
> ub and usb-storage. It looks as if Adrian has the same broken mental
> model of the way things work. Once again, what is loaded does not
> matter (not in ideal world, but in reality we still have conflicts such
> as e100 and eepro100).

No one has posted a reply to this point, so here's one even if it is 
unnecessary.

What matters is not which modules are loaded, but rather which modules 
bind to which devices.  If ub is configured then usb-storage will not bind 
to certain devices, regardless of what modules are loaded.

Problems start arising when devices that ub binds to and usb-storage 
doesn't (when ub is configured) fail to work with ub, or work much more 
slowly than they do with usb-storage.  And since some distributions enable 
ub in their shipping configurations, users often don't realize what has 
happened -- they only know that things don't work as well as they used to.

Maybe a reasonable answer would be to ask distributors not to enable ub,
and leave it up to individual users to configure it when they want to.  
That is the default setting in Kconfig, after all.

Alan Stern


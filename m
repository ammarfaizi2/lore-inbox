Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVFMWUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVFMWUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVFMWTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:19:20 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:15129 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261511AbVFMWRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:17:14 -0400
Date: Mon, 13 Jun 2005 15:16:57 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Input sysbsystema and hotplug
Message-ID: <20050613221657.GB15381@suse.de>
References: <200506131607.51736.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506131607.51736.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 04:07:51PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> I am trying to convert input systsem to play nicely with sysfs and I am
> having trouble with hotplug agent. The old hotplug mechanism was using
> "input" as agent/subsystem name, unfortunately I can't simply use "input"
> class because when Greg added class_simple support to input handlers
> (evdev, mousedev, joydev, etc) he used that name.

Why not?  What's wrong with using the existing input class?  I was
hopeing it would get flushed out into something "real" someday.  All you
have to do is keep the "dev" stuff in there somewhere and udev will be
happy.

> /sys/class/input---input0
> 		 |
> 		 |-input1
> 		 |
> 		 |-input2
> 		 |
> 		 |-mouse---mouse0
> 		 |	 |
> 		 |	 |-mouse1
> 		 |	 |
> 		 |	 --mice
> 		 |
> 		 |-event---event0
> 			 |
> 			 |-event1
> 			 |
> 			 |-event2
> 
> where inputX are class devices, mouse and event are subclasses of input
> class and mouseX and eventX are again class devices.

Yes, lots of people want class devices to have children.  Unfortunatly
they don't provide patches with their requests :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281010AbRKOTa3>; Thu, 15 Nov 2001 14:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281016AbRKOTaU>; Thu, 15 Nov 2001 14:30:20 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:44747 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S281019AbRKOTaQ>; Thu, 15 Nov 2001 14:30:16 -0500
Date: Thu, 15 Nov 2001 14:30:12 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200111151930.fAFJUCq16060@devserv.devel.redhat.com>
To: vojtech@suse.cz
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible Bug: 2.4.14 USB Keyboard
In-Reply-To: <mailman.1005850740.5583.linux-kernel2news@redhat.com>
In-Reply-To: <3BF2DFBF.6090502@prairiegroup.com> <20011114145312.A6925@kroah.com> <3BF3D029.7070609@prairiegroup.com> <20011115090023.A10511@kroah.com> <3BF40C03.4010509@prairiegroup.com> <mailman.1005850740.5583.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have the keybdev module loaded? Also, don't load the usbkbd
> module, if you load hid ...
> 
> -- 
> Vojtech Pavlik
> SuSE Labs

There is a small problem with this approach: users have no clue
how to control what modules are loaded, hotplug loads whatever
was built (and recorded in modules.usbmap), and some users
have keyboards that plainly refuse to work with hid, therefore
vendors have to build both modules.

See this little gem, for instance:
 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=55878

I suspect some distributions can get away with "load the right
module" approach because their userbase is so small and technical
that they do not hit these cases often. I think something needs
fixing in hid.

-- Pete

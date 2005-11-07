Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965336AbVKGUIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbVKGUIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbVKGUIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:08:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:23471 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965330AbVKGUIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:08:47 -0500
Date: Mon, 7 Nov 2005 12:07:37 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org, Steven French <sfrench@us.ibm.com>,
       matthieu castet <castet.matthieu@free.fr>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.14-mm1
Message-ID: <20051107200734.GD22524@kroah.com>
References: <20051106182447.5f571a46.akpm@osdl.org> <436F7DAA.8070803@ums.usu.ru> <20051107115210.33e4f0bf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107115210.33e4f0bf.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 11:52:10AM -0800, Andrew Morton wrote:
> > 4) I also decided to test new input hotplug. Below is the udevmonitor 
> > trace of uevents when I rmmod and modprobe again the psmouse driver. 
> > <NULL>s don't look right there. Is the rest OK?
> > 
> > UEVENT[1131378684] remove@/class/input/input1/mouse0
> > ACTION=remove
> > DEVPATH=/class/input/input1/mouse0
> > SUBSYSTEM=input
> > SEQNUM=903
> > PHYSDEVPATH=/devices/platform/i8042/serio0
> > PHYSDEVBUS=serio
> > PHYSDEVDRIVER=psmouse
> > MAJOR=13
> > MINOR=32
> > 
> > UEVENT[1131378684] remove@/class/input/input1
> > ACTION=remove
> > DEVPATH=/class/input/input1
> > SUBSYSTEM=input
> > SEQNUM=904
> > PHYSDEVPATH=/devices/platform/i8042/serio0
> > PHYSDEVBUS=serio
> > PHYSDEVDRIVER=psmouse
> > PRODUCT=11/2/4/0
> > NAME="GenPS/2 Genius <NULL>"
> > PHYS="isa0060/serio1/input0"
> > UNIQ="<NULL>"
> > EV=7
> > KEY=1f0000 0 0 0 0 0 0 0 0
> > REL=103
> 
> Hopefully Greg can tell us?

Those nulls are coming from the device's strings from what I have seen.
I don't think this should be a problem, but Dmitry and Vojtech would
know for sure.

thanks,

greg k-h

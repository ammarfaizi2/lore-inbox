Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281016AbRKOTsC>; Thu, 15 Nov 2001 14:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281018AbRKOTrx>; Thu, 15 Nov 2001 14:47:53 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:54795 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S281016AbRKOTre>; Thu, 15 Nov 2001 14:47:34 -0500
Date: Thu, 15 Nov 2001 20:47:31 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible Bug: 2.4.14 USB Keyboard
Message-ID: <20011115204731.A8721@suse.cz>
In-Reply-To: <3BF2DFBF.6090502@prairiegroup.com> <20011114145312.A6925@kroah.com> <3BF3D029.7070609@prairiegroup.com> <20011115090023.A10511@kroah.com> <3BF40C03.4010509@prairiegroup.com> <mailman.1005850740.5583.linux-kernel2news@redhat.com> <200111151930.fAFJUCq16060@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111151930.fAFJUCq16060@devserv.devel.redhat.com>; from zaitcev@redhat.com on Thu, Nov 15, 2001 at 02:30:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 02:30:12PM -0500, Pete Zaitcev wrote:
> > Do you have the keybdev module loaded? Also, don't load the usbkbd
> > module, if you load hid ...
> > 
> > -- 
> > Vojtech Pavlik
> > SuSE Labs
> 
> There is a small problem with this approach: users have no clue
> how to control what modules are loaded, hotplug loads whatever
> was built (and recorded in modules.usbmap), and some users
> have keyboards that plainly refuse to work with hid, therefore
> vendors have to build both modules.
> 
> See this little gem, for instance:
>  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=55878
> 
> I suspect some distributions can get away with "load the right
> module" approach because their userbase is so small and technical
> that they do not hit these cases often. I think something needs
> fixing in hid.

Interesting. Could you by any chance try to run the 'evtest' program (i
can send it to you if you don't have it handy) on the /dev/input/event
device created for this keyboard? And/or dmesg with DEBUG enabled in
hid-core.c? Also, latest kernels should make even the extra keys of this
keyboard work ...

-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271867AbRHUVFJ>; Tue, 21 Aug 2001 17:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271866AbRHUVE7>; Tue, 21 Aug 2001 17:04:59 -0400
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:5030 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S271864AbRHUVE4>; Tue, 21 Aug 2001 17:04:56 -0400
Message-ID: <3B82CE05.992B7F63@wanadoo.fr>
Date: Tue, 21 Aug 2001 23:09:25 +0200
From: Pierre JUHEN <pierre.juhen@wanadoo.fr>
X-Mailer: Mozilla 4.77 [fr] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: fr, French, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Greg KH <greg@kroah.com>, mj@suse.cz, linux-kernel@vger.kernel.org,
        linux-hotplug-devel@lists.sourceforge.net
Subject: Re: PROBLEM : PCI hotplug crashes with 2.4.9
In-Reply-To: <3B816617.F5C1CD24@wanadoo.fr> <20010820123625.A31374@kroah.com>
	 <08d401c129ca$94ebd2a0$6800000a@brownell.org> <3B82A2C5.48E4DFC@wanadoo.fr> <0b5c01c12a6e$47b68e40$6800000a@brownell.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The offending command is "/sbin/modprobe ohci1394".

Thank you for your help.

I will dig around ieee1394 tomorrow.

Regards,

Pierre
_________________________________________

David Brownell a écrit :

> > I was a bit lazy, writing by memory : you are right the system says
> >
> > "pcimodules is scanning more than 00:00.0"
> >
> > but onluy this line and crashes. Under 2.4.6, it scans all the pci
> > adresses.
> 
> Then you should be able to try reproducing this by hand,
> without hotplug scripts at all.  Is it "pcimodules" that's making
> it crash?  Or is it the subsequent "modprobe" commands?
> Neither of those is supposed to be able to crash the kernel.
> 
> You should be able to track this down pretty easily.  Disable
> the /etc/hotplug/pci.rc script for a moment ("pci.rc-"), boot, then
> run it by hand like "sh -x pci.rc start".  That's pretty much the way
> it's done at boot time, except that by passing the "-x" you get
> some nice debug output, and will be able to see what user
> mode command caused the crash.
> 
> - Dave

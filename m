Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274248AbRJaWRI>; Wed, 31 Oct 2001 17:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRJaWQ6>; Wed, 31 Oct 2001 17:16:58 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:23997 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S274248AbRJaWQq>;
	Wed, 31 Oct 2001 17:16:46 -0500
Date: Wed, 31 Oct 2001 23:17:16 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110312217.XAA28976@harpo.it.uu.se>
To: andersg@0x63.nu
Subject: Re: Local APIC option (CONFIG_X86_UP_APIC) locks up Inspiron 8100
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001 22:42:01 +0100, andersg@0x63.nu wrote:
> > > > Not all BIOS firmware can cope when we switch to UP-APIC. Some laptops 
> > > > really don't like it one bit.
> > >
> > >Correct, and the I8x00 is the prime example of that.
> > >
> > >I have a fix, but it involves fairly major surgery:
> > >- Implement bt_ioremap()/bt_iounmap() which work at early boot-time (the
> > >  normal ioremap doesn't work yet).
> > >...
> > >The patch is still _very_ rough, but it seems to work. Let me know if you want it.
> > 
> > The patch is now available at
> > http://www.csd.uu.se/~mikpe/linux/patch-2.4.13ac5-init-order-5
> 
> The same problem appears on "Dell Latitude C810". So that should probably be
> added to the dmi-backlist too. 

You have confirmed that allowing the local APIC to be enabled
causes it to lock up at system management events, and that keeping
the local APIC disabled prevents those lockups?

Send me the DMI scan output (change the dmi_printk #define in dmi_scan.c
to actually do a printk) and I'll add the C810 to the blacklist.

/Mikael

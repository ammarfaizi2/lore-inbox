Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290423AbSB0Ahb>; Tue, 26 Feb 2002 19:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290338AbSB0AhV>; Tue, 26 Feb 2002 19:37:21 -0500
Received: from sushi.toad.net ([162.33.130.105]:25730 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S290423AbSB0AhM>;
	Tue, 26 Feb 2002 19:37:12 -0500
Subject: Re: please remove CONFIG_PNP, CONFIG_PNPBIOS
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 26 Feb 2002 19:37:53 -0500
Message-Id: <1014770275.6708.244.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> by checking 2.4.18, I saw that "CONFIG_PNP" is not in use in the 
> source anymore except in Documentation/Configure.help and as a 
> variable that CONFIG_ISAPNP depends on. 
> 
> => remove. 

Hold on.  This will change once the pnpbios driver 
is merged.  It's currently in Alan's tree (and in 2.5 stock). 

> as a side note, I'd want to know how linux is configuring 
> the PCI devices, when e.g. in the Bios Settings I say 
> "Yes - PNP aware OS installed". 

When you enable "PnP OS" in the BIOS, you are telling 
the BIOS not to use PnP methods to configure PnP devices, 
but to leave it to the OS to do the configuration. 

> can also someone tell me which variable the "CONFIG_PNPBIOS" options 
> depends on? this seems to be another variable which is only 
> "used" on Documentation/Configure.help. 

pnpbios is a driver used to communicate with the 
PnP BIOS.  This driver should be merged soon, but right 
now only the help text for the driver is present in stock 2.4. 

> according to the documentation of "CONFIG_PNP", Linux configures 
> my Plug and Play devices. 

In the case of ISA devices, Linux only configures them 
if you have the isa-pnp driver built. 

> Alternatively ... the user space utils 
> from isapnptools. this sounds like linux does not configure 
> PCI devices and therefore, the "PNP Aware OS" should always be 
> set to "N" in the BIOS - is this correct? 

The "PnP OS" boot flag may appropriately be set to 1 
only Linux is prepared (by using the isa-pnp driver, 
or isapnptools) to do PnP configuration itself. 

Actually, I don't see why we should ever set the "PnP OS" 
flag.  It doesn't hurt to let the BIOS preconfigure 
devices.  Linux can always re-configure devices as it 
sees fit, can't it? 

-- 
Thomas Hood 







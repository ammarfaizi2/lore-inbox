Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTIBPaB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 11:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTIBP0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 11:26:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:29866 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263884AbTIBPXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 11:23:15 -0400
Date: Tue, 2 Sep 2003 08:17:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: don fisher <dfisher@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to choose between ip 2 identical ethernet cards
Message-Id: <20030902081720.5895bde1.rddunlap@osdl.org>
In-Reply-To: <3F4FEFE9.4050704@as.arizona.edu>
References: <3F4FEFE9.4050704@as.arizona.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Aug 2003 17:29:29 -0700 don fisher <dfisher@as.arizona.edu> wrote:

| Sorry for a bit off topic.
| 
| I have a Dell 8200 laptop and a docking station, both with 3c905C 
| ethenet chips. I wish to use the 3c905c internal to the docking 
| station when the system is docked. Otherwise the 3c905c internal to 
| the 8200. In my office I would like to run with both eth0 and eth1, 
| but I need to be able to connect the correct interface to the correct 
| cable. The same module is loaded for both devices.
| 
| The HOWTOs I found all assumed you had old cards with fixed addresses. 
| These could be specified as options in modules.conf. From the Net-HOWTO:
|          alias eth0 ne
|          alias eth1 ne
|          alias eth2 ne
|          options ne io=0x220,0x240,0x300
| But this does not seem to apply to the 3c59x driver. modinfo doesn't 
| even list "io" as a valid option.
| 
| I did find:
|   1) in /proc/ioports, one of the devices is listed with "(#2)" after it.
|   2) in /etc/sysconfig/hwconf, one of the devices has
| subDeviceId = 00d4, the other 00de.
| 
| I have tried changing the order of loading modules, along with a few 
| vain attempts in modules.conf. For info, this is a Redhat system. 
| Where is the definition as to which device will be associated with 
| eth0 made?
| 
| Any assistance would be appreciated. I did try to RTFM, I just can't 
| find the correct "fine manual";-)
| thanks
| don

I did a mini-howto for 'nameif'.  URL is below.  Maybe it can
help you.

http://www.xenotime.net/linux/doc/network-interface-names.txt

--
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Fri, 29 Aug 2003 17:29:29 -0700 don fisher <dfisher@as.arizona.edu> wrote:

| Sorry for a bit off topic.
| 
| I have a Dell 8200 laptop and a docking station, both with 3c905C 
| ethenet chips. I wish to use the 3c905c internal to the docking 
| station when the system is docked. Otherwise the 3c905c internal to 
| the 8200. In my office I would like to run with both eth0 and eth1, 
| but I need to be able to connect the correct interface to the correct 
| cable. The same module is loaded for both devices.
| 
| The HOWTOs I found all assumed you had old cards with fixed addresses. 
| These could be specified as options in modules.conf. From the Net-HOWTO:
|          alias eth0 ne
|          alias eth1 ne
|          alias eth2 ne
|          options ne io=0x220,0x240,0x300
| But this does not seem to apply to the 3c59x driver. modinfo doesn't 
| even list "io" as a valid option.
| 
| I did find:
|   1) in /proc/ioports, one of the devices is listed with "(#2)" after it.
|   2) in /etc/sysconfig/hwconf, one of the devices has
| subDeviceId = 00d4, the other 00de.
| 
| I have tried changing the order of loading modules, along with a few 
| vain attempts in modules.conf. For info, this is a Redhat system. 
| Where is the definition as to which device will be associated with 
| eth0 made?
| 
| Any assistance would be appreciated. I did try to RTFM, I just can't 
| find the correct "fine manual";-)
| thanks
| don

I did a mini-howto for 'nameif'.  URL is below.  Maybe it can
help you.

http://www.xenotime.net/linux/doc/network-interface-names.txt

--
~Randy

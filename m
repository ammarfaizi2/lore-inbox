Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266565AbSKOTQx>; Fri, 15 Nov 2002 14:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSKOTQx>; Fri, 15 Nov 2002 14:16:53 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:5058 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266565AbSKOTQw>;
	Fri, 15 Nov 2002 14:16:52 -0500
Date: Fri, 15 Nov 2002 11:23:38 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.47 - PCMCIA ethernet and wireless ethernet bugs
Message-ID: <20021115192338.GB17861@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Pingenot wrote :
> 
> None of the PCMCIA wireless modules seem to work.  In addition, I get the
>   following errors when trying to manually load the aironet modules:
> /lib/modules/2.5.47/kernel/drivers/net/wireless/airo.o: unresolved symbol wirele
> ss_send_event_Rdc9b8ae0
> /lib/modules/2.5.47/kernel/drivers/net/wireless/airo.o: insmod /lib/modules/2.5.
> 47/kernel/drivers/net/wireless/airo.o failed
> /lib/modules/2.5.47/kernel/drivers/net/wireless/airo.o: insmod airo_cs failed

	I personally have stayed at 2.5.46 because I depend on modules
and will wait until the situation "settle down". So, don't expect quick
resolution from my side.
	I'm a bit puzzled by this error. Nothing has changed between
2.5.46 and 2.5.47. The symbol wireless_send_event() is still properly
exported in .../net/netsyms.c, and all uses of it are protected in #if
WIRELESS_EXT statements.
	Questions :
	1) Do you have module versioning enabled ? (Called "Set
version information on all module symbols").
	2) Did you change the config midway through the compile,
i.e. does a "make clean" of the kernel make it go away ?
	But as I say, I'm mostly stabbing in the dark...

	Good luck...

	Jean

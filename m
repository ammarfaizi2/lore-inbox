Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290293AbSA3SYb>; Wed, 30 Jan 2002 13:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290319AbSA3SXc>; Wed, 30 Jan 2002 13:23:32 -0500
Received: from www.transvirtual.com ([206.14.214.140]:39173 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S290333AbSA3SWq>; Wed, 30 Jan 2002 13:22:46 -0500
Date: Wed, 30 Jan 2002 10:22:02 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pozsar Balazs <pozsy@sch.bme.hu>, Dave Jones <davej@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: Linux 2.5.2-dj7
In-Reply-To: <E16Vie4-0005gE-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10201301018200.7609-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >    In dmi_scan.c there is a hook to deal with the PS/2 mouse on Dell
> > Latitude C600. Can someone with this machine test the new input drivers on
> > it. I like to see if we need some kind of fix for this device.
> 
> You I suspect will. When the machine resumes it likes to re-enable the mouse
> pad irrespective of whether it is being used - so you get an IRQ12. Even
> more fun if you ignore that IRQ you dont get keyboard events because the
> microcontroller (or SMM code impersonating it - who knows these days) is
> waiting for the ps/2 event to be handled first.

Oh man is that brain dead. 

> The alternative (possibly cleaner) fix on those machines would be to turn
> the PS/2 port on always and process/discard output if its not wanted by
> the user

This could be easily arranged with the new input drivers with it modular
design. Since for the ix86 platform most people will want PS/2 input
support to be built in. The only expection are the USB only users. I guess
with the Dell Latitude C600 we will have to force i8042.c to be built in. 
Vojtech what do you think about this solution?



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUDPL6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 07:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUDPL6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 07:58:13 -0400
Received: from [202.28.93.1] ([202.28.93.1]:47117 "EHLO gear.kku.ac.th")
	by vger.kernel.org with ESMTP id S262951AbUDPL6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 07:58:11 -0400
Date: Fri, 16 Apr 2004 18:25:18 +0700
From: Kitt Tientanopajai <kitt@gear.kku.ac.th>
To: "Brown, Len" <len.brown@intel.com>
Cc: daniel.ritz@gmx.ch, daniel.ritz@alcatel.ch, akpm@osdl.org,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] fix Acer TravelMate 360 interrupt routing
Message-Id: <20040416182518.46dd736c.kitt@gear.kku.ac.th>
In-Reply-To: <29AC424F54821A4FB5D7CBE081922E401F8579@hdsmsx403.hd.intel.com>
References: <29AC424F54821A4FB5D7CBE081922E401F8579@hdsmsx403.hd.intel.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
> >Linux version 2.6.5-mm4 (root@peorth.kitty.in.th) (gcc version 
> >3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #1 Sun Apr 11 11:46:57 ICT 2004
> ...
> >Acer TravelMate 36x Laptop detected - fixing broken IRQ routing
> >Acer TravelMate 36x Laptop detected: force use of pci=noacpi
> 
> Kitt,
> The patch is a platform specific workaround that forces "pci=noacpi"
> for this specific machine -- as if you supplied it on the cmdline.

ah.. I see :)
 
> The idea is to run the kernel w/o this patch and see
> If we can fix the root cause, thus possibly helping other
> systems which have the same problem.

Umm, I've tried almost, if not all, vanilla kernel 2.4.2x and 2.6.x, none of them could make the cardbus work. (For 2.4, I can to disable kernel pcmcia and use pcmcia-cs to make it works). I usually use "acpi=on pci=noacpi" for kernels that include ACPI. I also tried other boot param when I tested them, but the cardbus never work. lspci always reports irq 11 for the cardbus controllers.

> If we fail to find/fix the root cause, or discover that
> the platform has an issue that we simply can't fix
> in the kernel, then it makes sense to add this automatic
> workaround, but not before.

It's better to fix them if we could. :) 

rgds,
kitt

> >> > So for the ACPI mode part, I encourage you to file a bug here
> >> >
> >> > http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> >> > Component Config-Interrupts
> >> > and assign it to me.  Or if a bug is open already,
> >> > please direct me to it.
> >> >
> >> > thanks,
> >> > -Len
> 

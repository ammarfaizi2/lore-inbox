Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313355AbSDPPiH>; Tue, 16 Apr 2002 11:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313533AbSDPPiG>; Tue, 16 Apr 2002 11:38:06 -0400
Received: from [208.48.34.115] ([208.48.34.115]:1449 "EHLO
	wbkctmsx1ipc.ipc.com") by vger.kernel.org with ESMTP
	id <S313355AbSDPPiF>; Tue, 16 Apr 2002 11:38:05 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A92EE23DE@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: linux-kernel@vger.kernel.org
Subject: Compiling ALSA with 2.5.7
Date: Tue, 16 Apr 2002 11:35:17 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this is off-topic, my apologies.

I am unable to build ALSA for 2.5.7 on i386.  The problem is that 
the ALSA code uses a function virt_to_bus( ). This is #defined in 
asm/io.h as virt_to_bus_not_defined_use_pci_map( ). So there is 
an unresolved external.

The correct replacement of virt_to_bus( ) to pci_map_*( ) is not 
obvious to a newbie from a look at pci.h.

Am I missing something?  I think I must be.  So , is there
a kernel config option that needs to be set/unset, or is there
a patch I should get?

BTW I tried building 2.5.8, but that failed spectacularly in other
areas not related to ALSA...  Hmmmm, I've never had kernel build
problems before, I must be regressing!

thanks
td

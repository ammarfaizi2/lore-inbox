Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310344AbSCGONd>; Thu, 7 Mar 2002 09:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310340AbSCGONX>; Thu, 7 Mar 2002 09:13:23 -0500
Received: from sip-11a.usol.com ([63.64.148.11]:34832 "EHLO
	dns1.civic.twp.ypsilanti.mi.us") by vger.kernel.org with ESMTP
	id <S310335AbSCGONR>; Thu, 7 Mar 2002 09:13:17 -0500
Subject: 8139too on Proliant
From: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Mar 2002 09:13:19 -0500
Message-Id: <1015510399.25062.1.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a Compaq Proliant ML350.  We've added an additional PCI based
D-Link 530TX network card to the machine.  However, the driver (8139too)
fails to load.  The errors given are below.  We are using Debian Sid
(kernel 2.4.9-686).  If a new kernel or recompile is needed to fix this
problem, I'm willing, but if there's another way, I'd be *more* willing
to do that (putting new kernelson this machine is not fun).

I have tried changing the IRQ's for the card, that didn't seem to help. 
PnP is off, I believe (hard to tell with the Compaq BIOS).  Right now,
it's sharing IRQ 15 with the onboard eepro100 based card.  The add-on
card has been tested while sharing IRQ's with both the SCSI controllers
and the serial ports (the only options the BIOS gives us), and got the
exact same messages as below.

And, of course, like many people, I'm not subscribed to list.  CC on
replies would be spiffy.  Thanks!

On the console:
/lib/modules/2.4.9-686/kernel/drivers/net/8139too.o: init_module: No
such device
/lib/modules/2.4.9-686/kernel/drivers/net/8139too.o: insmod
/lib/modules/2.4.9-686/kernel/drivers/net/8139too.o failed
/lib/modules/2.4.9-686/kernel/drivers/net/8139too.o: insmod 8139too
failed
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters

/var/log/messages:
Mar  7 09:00:25 dns1 kernel: 8139too Fast Ethernet driver 0.9.18a
Mar  7 09:00:25 dns1 kernel: PCI: Found IRQ 15 for device 00:04.0
Mar  7 09:00:25 dns1 kernel: PCI: Unable to reserve I/O region
#1:100@3000 for device 00:04.0
Mar  7 09:00:25 dns1 kernel: Trying to free nonexistent resource
<00003000-000030ff>
Mar  7 09:00:25 dns1 kernel: Trying to free nonexistent resource
<b0800000-b08000ff>
Mar  7 09:00:25 dns1 kernel: Trying to free nonexistent resource
<00003000-000030ff>
Mar  7 09:00:25 dns1 kernel: Trying to free nonexistent resource
<b0800000-b08000ff>


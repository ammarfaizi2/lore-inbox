Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131234AbQLZF5i>; Tue, 26 Dec 2000 00:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131260AbQLZF51>; Tue, 26 Dec 2000 00:57:27 -0500
Received: from dfw-smtpout1.email.verio.net ([129.250.36.41]:35764 "EHLO
	dfw-smtpout1.email.verio.net") by vger.kernel.org with ESMTP
	id <S131234AbQLZF5O>; Tue, 26 Dec 2000 00:57:14 -0500
Date: Mon, 25 Dec 2000 23:26:13 -0600
From: Eric Shattow <radoni@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: controllerless pci device support
Reply-To: radoni@crosswinds.net
In-Reply-To: <20001226175057.A12275@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.10.10012250049400.5242-100000@penguin.transmeta.com> <Pine.LNX.4.10.10012250131370.5340-100000@penguin.transmeta.com> <20001226175057.A12275@metastasis.f00f.org>
X-Mailer: Spruce 0.7.5 for X11 w/smtpio 0.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E14AmdK-0003xe-00@dfw-mmp1.email.verio.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

would it be sensible to write a PCI device interface for controllerless PCI
devices like serial PCI ports?  I am now trying to make the older 2.2.x
series LT winmodem patch into the 2.4.0-test13pre4 sources work.  I see how
some companies are unable to release all the source code to drivers due to
legal reasons and patent restrictions.  Maybe there should be a generic
driver interface for software modems or other devices, so it is easier to -
as an example - write winmodem drivers for the serial driver without
hacking in many sets of "#ifdef LUCENT_MODEM..... modified code.... #endif"
to the serial.c source file.
i am not able to create such a thing, and winmodems are not the most
popular thing to talk about in regards to support.  after spending 3 hours
staring at serial.c, as a beginning programmer, and hand copying the
appropriate 2.2.x winnmodem "serial.c" driver code in, i am lost.   the
module finally compiles, without error, but complains with an error that
there is an unresolved symbol "jiffie".   kind of funny, a jiffie is all
that separates me from turning my brand new laptop into a machine i can use
the modem on.  also it is equally fustrating.  will this situation improve
in time or what else can i do to get my modem working?   arrrgh!  even if
the hand-done patching of 2.4.x's serial.c file resulted in a useable
kernel module, i would not like to have to patch it every time i update my
kernel. a winmodem.o module with support for generic interfaces into the
kernel so driver vendors do not need to muck around with serial.c would be
an idea.
my real question to all is where is the support of PCI serial devices at
inside of the kernel? if i have pci bus 0:0.b sharing irq 11 with 0:0.c,
does the linux kernel support both devices working at the same time
(ethernet, and serial port aka winmodem)?

this is probably better off sent to the serial mailing list i know, but i
am more interested in whether all the problems i am having with 4 out of 6
devices on my laptop's PCI bus conflicting, whether this is because the
linux kernel does not support more than one PCI function operating
simultaneously on any given PCI device under the same PCI bus.  (
bus:device.function )

right now i get a message that says [IRQ 11 is already used by device
0:8.0] when i load drivers for the device 0:8.1, and the visa-versa message
when loading drivers for device 0:8.0.  Is this just a warning, or an
error? i can't tell.  sometimes the driver (as is the case with pcmcia
drivers, where slot0 is 0:6.0 and slot1 is 0:6.1) loads anyways, despite
the message about [IRQ 11 is alr...].  othertimes, with my ethernet drivers
and alsa sound drivers, i see the message and the drivers fail to load.

what to do....

merry holidays, all. i apologize this is long and likely off topic. i mean
well though.

-Eric Shattow
radoni@crosswinds.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131314AbQLHScn>; Fri, 8 Dec 2000 13:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbQLHScZ>; Fri, 8 Dec 2000 13:32:25 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:5859 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129909AbQLHScO>; Fri, 8 Dec 2000 13:32:14 -0500
Date: Fri, 8 Dec 2000 13:01:48 -0500
From: Matthew Galgoci <mgalgoci@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: cardbus pirq conflict
Message-ID: <20001208130148.B19712@redhat.com>
Reply-To: mgalgoci@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I am running the 2.4.0test12pre7 kernel on my laptop computer, and
I'm having some rather interesting problems.

For the longest time, usb never worked on this machine. As of the 
happy patch that enabled bus mastering for usb controllers, it 
magically started working. I am really happy that it does work
now.

The usb controller and the pcmcia bridge both share the same 
irq, irq 10.

Now, my cardbus cards have stopped working. When I insert a cardbus
nic, I get the following message: "IRQ routing conflict in pirq 
table! Try 'pci=autoirq'"

The card fails to initialize, and upon issuing the halt command, the 
system generates a kernel Oops. I tend to think that the Oops is a
symptom of having a half initialized device. If anyone is interested, 
I'll catch the Oops, run it though ksymoops, and send it to them.

If I try as the kernel suggests, and give the kernel options
pci=autoirq, there seems to be no noticable change.

If I switch to a isa^H^H^H I mean 16 bit version of the same ethernet 
card, the card works find, and the usb controller works. As a matter
of fact, I've had the 16 bit nic and a usb nic both active at the 
same time.

So, beyond reporting this and waiting for the next prepatch from Linus,
I really don't know where to go next. If I can provide anyone with more
information about the hardware or this problem, please ask.

Cheers!

--Matt Galgoci


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

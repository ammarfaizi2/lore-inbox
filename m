Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUAUJp0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 04:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUAUJpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 04:45:25 -0500
Received: from tank-fep3-0.inet.fi ([194.251.242.243]:17132 "EHLO
	fep18.tmt.tele.fi") by vger.kernel.org with ESMTP id S262714AbUAUJpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 04:45:23 -0500
From: "tuija t." <tuxakka@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Subject: swusp acpi
Date: Wed, 21 Jan 2004 11:43:51 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401211143.51585.tuxakka@yahoo.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry about the newbie question but I haven't managed
to get answer elsewhere :-)
I have a laptop (Fujitsu Lifebook C1020) Debian system
with linux-2.6.1 vanilla.
An I have wondered how I should but it in sleep?
# echo 4 > /proc/acpi/sleep 
writes the ram in the swap:

Stopping tasks: ===================================================|
Freeing memory: ........................|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: completing PM request, suspend
/critical section: Counting pages to copy[nosave c03cf000] (pages needed: 
4727+512=5239 free: 118136)
Alloc pagedir
[nosave c03cf000]<4>Freeing prev allocated pagedir
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Fixing swap signatures... ok
Restarting tasks... done
And after reboot comes back to same than it was before
This behaviour is kind of "big sleep" and have to boot from grub.

When I do
# echo 3 > /proc/acpi/sleep
it beebs from bios and do:
PM: Preparing system for suspend
Stopping tasks: ===================================================|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Entering state.
Back to C!
PM: Finishing up.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks...<6>usb 1-1: USB disconnect, address 2
drivers/usb/host/uhci-hcd.c: 1200: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: 1200: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: 1300: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: 1300: host controller halted. very bad
drivers/usb/host/uhci-hcd.c: 1700: host system error, PCI problems?
drivers/usb/host/uhci-hcd.c: 1700: host controller halted. very bad
psmouse: reconnect request, but serio is disconnected, ignoring...
 done
hub 1-0:1.0: new USB device on port 1, assigned address 3
usb 1-1: control timeout on ep0out

And with pressing power button everything else comes back exept
usb.
This behaviour is kind of "little light nap" and system comes back fast.
And I have also noticed that I cannot use bios passwd with
# echo 3 > /proc/acpi/sleep   cause even it doesn't reboot it goes
somehow to bios and bios passwd prompted but it doesn't accept it?
But after disabled bios passwd it works exept usb.

Can somebody give me any wise what I'm doing wrong or point
me to some documentation about this matter?

Thank you for your patience and possible answers advance :-)

-- 
best rgds
~tt


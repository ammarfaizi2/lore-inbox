Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVBSNbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVBSNbO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 08:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVBSNbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 08:31:14 -0500
Received: from baana-62-44-231-9.dsl.phnet.fi ([62.44.231.9]:30087 "EHLO
	klapi.ath.cx") by vger.kernel.org with ESMTP id S261713AbVBSNbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 08:31:07 -0500
Subject: Sysfs, PCI-devices and power management
From: WareKala <warekala@lag.ath.cx>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Feb 2005 15:29:34 +0200
Message-Id: <1108819774.11821.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know if this is the "right place(TM)" to ask about this, and if
it isn't, I apologize. But the fact is that I haven't found any help
from anywhere else and I can't learn enough without asking. So, the
situation is like this: I am using a laptop and want to minimize the
power consumption by shutting down unneeded components. Under windozer a
program called Battery Doubler does the same by for example shutting
down not-needed PCI devices. I too, tried to shut down certain devices
by doing "echo 3 > /sys/devices/pci*/*0a*/power/state", but that didn't
work. state was still a zero. So, I then echoed a "3" to detach_state
and removed the module, after which */power/state was 3. Now, I then
tried again changing it with no luck. Echoing a 1 to detach_state,
modprobing and rmmoding the module did the trick, but I still can't get
it back to state 0. Also, I read from the kernel documentations that
echoing something to power/state should work, without toying around with
the modules, but apparently that is b0rked.

So, is there any way to fix this? Or, could someone do a simple
C-program for changing the state of the devices? I don't know enough
about PCI or programming under Linux, so my experiments with
pci_set_power_state didn't work out quite the way they were supposed to
=/

Also, the kernel in question is 2.6.10, though this hasn't worked with
any other version either.

I am not a regular reader in here, so please be kind and answer directly
to me.
 -WareKala

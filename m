Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVCGKRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVCGKRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVCGKRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:17:11 -0500
Received: from aun.it.uu.se ([130.238.12.36]:58583 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261736AbVCGKQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:16:57 -0500
Date: Mon, 7 Mar 2005 11:16:49 +0100 (MET)
Message-Id: <200503071016.j27AGnDm016062@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: dap@mail.index.hu, linux-kernel@vger.kernel.org
Subject: Re: NMI watchdog question
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Mar 2005 01:53:25 +0100, Pallai Roland wrote:
> I'm playing with the NMI watchdog (nmi_watchdog=1) on a reproductable
>hard lockup (no keyboard, etc) but seems like it doesn't works and I
>can't understand why, please explain to me the possible causes.. I
>belive it should work in this situation..
...
>steps to the lockup:
> 1. booting the machine with sata drive on the promise controller
> 2. dd if=/dev/sda of=/dev/null bs=4k
> 3. unplug the power from drive
> 4. waiting about 2 seconds
> 5. plug the power back
>
> dd stucked in 'D' here for 10-15 seconds and than the kernel say:
>  ata1: command timeout
>
> and voila, the box is dead, but without any message from the NMI
>watchdog :(
...
>Kernel command line: auto BOOT_IMAGE=l2611-1S0 ro nfsroot=192.168.4.254:/mnt/daproot,v3 ip=192.
>168.4.5::192.168.4.254:255.255.255.0::eth0:none console=tty0 console=ttyS0,115200 nmi_watchdog=
>1 3

Please try nmi_watchdog=2.

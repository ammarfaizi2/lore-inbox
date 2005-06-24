Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263023AbVFXPhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbVFXPhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 11:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVFXPhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 11:37:54 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:15797 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S263023AbVFXPdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 11:33:50 -0400
Date: Fri, 24 Jun 2005 11:34:04 -0400
From: Frank Peters <frank.peters@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: Asus MB and 2.6.12 Problems
Message-Id: <20050624113404.198d254c.frank.peters@comcast.net>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For the very first time in the long history of the Linux kernel,
I am having significant problems.

After downloading and compiling the latest version 2.6.12, my
keyboard becomes unresponsive and dead following the boot process.
This doesn't occur all of the time, but only some of the time.
In particular, the follwing boot up message will be seen at
sporadic places among the other text output:

input: AT Translated Set 2 keyboard on isa0060/serio0

When this message does not occur anywhere in the boot messages,
the keyboard is not functional.  When the message does occur, then
the keyboard will respond, but sometimes with an erratic key
repeat rate.  After rebooting several times I can usually get
the system up and running smoothly, but with this current kernel
2.6.12, there is no guarantee that it will boot properly at any
given time.

Also, after a successful boot with 2.6.12, I will attempt to
connect with my cable Internet service using the following
commands:

modprobe 3c59x  (load the ethernet modules)
dhcpcd -t 240   (get the IP address from my ISP)

Formerly, with kernels 2.6.11 and earlier, the connection could
be established very quickly (about 10-15 seconds).  But with
kernel 2.6.12, it now requires about 3-4 minutes to establish
the link.

My system is an ASUS P4B533 motherboard with a Pentium 3.6 Ghz
Hyperthreaded processor and 1 GHz RAM.  The kernel is the stock
linux kernel (compiled with gcc-2.95.3) and the rest of my software
is self-compiled (i.e. no distribution).

If I disable ACPI, either by compiling a new 2.6.12 kernel or
through boot up parameters, the keyboard will respond normally
without any problems, but the kernel will not recognize my
hyperthreaded processor.  Only one CPU will be initialized and
active.

Thus, I can enjoy a problem-free 2.6.12 kernel if I choose to 
sacrifice ACPI and hyperthreading.

However in either case the cable Internet connection with DHCP
still takes 3-4 minutes, which is markedly different from previous
behavior.

If anyone has any suggestions or needs any more information,
please CC me at the address frank.peters@comcast.net as I am not
a subscriber to the list.

Frank Peters


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbTDYMC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTDYMCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:02:25 -0400
Received: from charentes.fr.clara.net ([212.43.194.76]:22287 "EHLO
	charentes.fr.clara.net") by vger.kernel.org with ESMTP
	id S263909AbTDYMCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:02:22 -0400
Date: Fri, 25 Apr 2003 14:13:23 +0200
From: Yves Colombani <yc@dash.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20: kbd/mouse problem (PS/2?)
Message-Id: <20030425141323.30e03119.yc@dash.co.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am having trouble with keyboard and mouse using Linux 2.4.20:
- the keyboard is a Logitech Internet Navigator and the mouse
  is a Logitech MX300: both can be plugged to usb but I use PS2
- the PC is a Dell 650 dual Xeon at 2.4Ghz with MPT SCSI controler
- I compiled the kernel from the original source plus:
  + update of the mpt driver (2.03.00)
  + patch-o-matic to add support for PPTP (but modules of netfilter
    are currently not loaded)

During boot the machine reports:
 keyboard: Timeout - AT keyboard not present?(00)

but seems to start correctly.
When I start X, the mouse does not work: to get it working I have to switch
to another terminal (using ctrl-alt-F1) then back to the graphical environement.
It seems that some initialisation is not performed correctly at this point
(maybe from the X server side?). If I disable numlock before starting X, the
mouse works.

Sometimes I get further 'keyboard: Timeout - AT keyboard not present?(XX)'
with various values for XX (ed,f4,02,04).
Finally I have 'lost' the keyboard a couple of times: when starting X or
after a period of inactivity. In such cases, unplugging and reconnecting
the keyboard fixes the problem (I am not sure this is something to do!).
Today the machine crashed after I pressed 'numlock'.

I noticed that someone reported a similar problem also on a Dell PC: could
it be related to the BIOS on these machines?

Thanks for your help,
Yves.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbUBIEL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 23:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUBIEL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 23:11:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:26241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264575AbUBIEL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 23:11:56 -0500
Date: Sun, 8 Feb 2004 20:09:21 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: M G Berberich <berberic@fmi.uni-passau.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2 wacom not working from /etc/modules
Message-Id: <20040208200921.24708dd4.rddunlap@osdl.org>
In-Reply-To: <20040207190039.GA1331@avaloon.intern>
References: <20040207190039.GA1331@avaloon.intern>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004 20:00:39 +0100 M G Berberich <berberic@fmi.uni-passau.de> wrote:

| Hello,
| 
| I have the strange problem that the wacom driver in 2.6.2 does not
| work if loaded from /etc/modules. If loaded "by hand" after the system
| is up it works fine. 
| 
| /proc/bus/input/devices is exactly the same in both cases:
| 
|   [...]
| 
|   I: Bus=0003 Vendor=056a Product=0042 Version=0126
|   N: Name="Wacom Intuos2 6x8"
|   P: Phys=usb-0000:00:0c.0-1/input0
|   H: Handlers=mouse1 event3
|   B: EV=1b
|   B: KEY=1cdf 0 1f0000 0 0 0 0 0 0 0 0
|   B: ABS=f000163
|   B: MSC=1
| 
| but if loaded from /etc/modules neither mouse1 nor event3 gives any
| sign of the wacom beeing alive. syslog entries are the same, but in
| different order:
| 
| input: PC Speaker
| input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
| input: AT Translated Set 2 keyboard on isa0060/serio0
| input: Wacom Intuos2 6x8 on usb-0000:00:0c.0-1
| drivers/usb/core/usb.c: registered new driver wacom
| drivers/usb/input/wacom.c: v1.30:USB Wacom Graphire and Wacom Intuos tablet driver
| 
| input: PC Speaker
| input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
| input: AT Translated Set 2 keyboard on isa0060/serio0
| drivers/usb/core/usb.c: registered new driver wacom
| drivers/usb/input/wacom.c: v1.30:USB Wacom Graphire and Wacom Intuos tablet driver
| input: Wacom Intuos2 6x8 on usb-0000:00:0c.0-1
| 
| System is a dual PIII, with stock 2.6.2-kernel
| 
| BTW: I'm not subscribed to the list.

Just to clarify, are you referring to /etc/modules.conf or
/etc/modprobe.conf ?  /etc/modules.conf is no longer used by the
current module-init-tools, it must be converted to /etc/modprobe.conf .

--
~Randy

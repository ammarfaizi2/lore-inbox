Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbUBPOyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbUBPOyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 09:54:38 -0500
Received: from zeus.kernel.org ([204.152.189.113]:27088 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265552AbUBPOyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 09:54:32 -0500
Date: Mon, 16 Feb 2004 15:12:29 +0100
From: M G Berberich <berberic@fmi.uni-passau.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2 wacom not working from /etc/modules
Message-ID: <20040216141229.GB5158@luthien.forwiss.uni-passau.de>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040207190039.GA1331@avaloon.intern> <20040208200921.24708dd4.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040208200921.24708dd4.rddunlap@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sunday, den 08. February 2004 20:09:21 schrieb Randy.Dunlap:
> On Sat, 7 Feb 2004 20:00:39 +0100 M G Berberich <berberic@fmi.uni-passau.de> wrote:
> 
> | Hello,
> | 
> | I have the strange problem that the wacom driver in 2.6.2 does not
> | work if loaded from /etc/modules. If loaded "by hand" after the system
> | is up it works fine. 
> | 
> | /proc/bus/input/devices is exactly the same in both cases:
> | 
> |   [...]
> | 
> |   I: Bus=0003 Vendor=056a Product=0042 Version=0126
> |   N: Name="Wacom Intuos2 6x8"
> |   P: Phys=usb-0000:00:0c.0-1/input0
> |   H: Handlers=mouse1 event3
> |   B: EV=1b
> |   B: KEY=1cdf 0 1f0000 0 0 0 0 0 0 0 0
> |   B: ABS=f000163
> |   B: MSC=1
> | 
> | but if loaded from /etc/modules neither mouse1 nor event3 gives any
> | sign of the wacom beeing alive. syslog entries are the same, but in
> | different order:
> | 
> | input: PC Speaker
> | input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
> | input: AT Translated Set 2 keyboard on isa0060/serio0
> | input: Wacom Intuos2 6x8 on usb-0000:00:0c.0-1
> | drivers/usb/core/usb.c: registered new driver wacom
> | drivers/usb/input/wacom.c: v1.30:USB Wacom Graphire and Wacom Intuos tablet driver
> | 
> | input: PC Speaker
> | input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
> | input: AT Translated Set 2 keyboard on isa0060/serio0
> | drivers/usb/core/usb.c: registered new driver wacom
> | drivers/usb/input/wacom.c: v1.30:USB Wacom Graphire and Wacom Intuos tablet driver
> | input: Wacom Intuos2 6x8 on usb-0000:00:0c.0-1
> | 
> | System is a dual PIII, with stock 2.6.2-kernel
> | 
> | BTW: I'm not subscribed to the list.
> 
> Just to clarify, are you referring to /etc/modules.conf or
> /etc/modprobe.conf ?  /etc/modules.conf is no longer used by the
> current module-init-tools, it must be converted to /etc/modprobe.conf .

No I'm referring to /etc/modules. 
A file where you can list modules that get loaded at boot-time.

	MfG
	bmg

-- 
"Des is völlig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!"          | berberic@fmi.uni-passau.de
(SPD-Stadtrat Kurt Schindler; Regensburg)  | www.fmi.uni-passau.de/~berberic

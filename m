Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSKHQBe>; Fri, 8 Nov 2002 11:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266465AbSKHQBe>; Fri, 8 Nov 2002 11:01:34 -0500
Received: from ns.tasking.nl ([195.193.207.2]:15891 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S262215AbSKHQBd>;
	Fri, 8 Nov 2002 11:01:33 -0500
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Greg KH <greg@kroah.com>, Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linux-USB-Users <linux-usb-users@lists.sourceforge.net>
Subject: Re: USB broken in 2.5.4[56]
In-Reply-To: <1036701797.2841.17.camel@ldb>
References: <20021106132022.GA2101@home.ldb.ods.org>
	<20021106183046.GA23770@kroah.com> <1036701797.2841.17.camel@ldb>
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: Kees Bakker <rnews@altium.nl>
Date: 08 Nov 2002 17:06:47 +0100
Message-ID: <si4rasuju0.fsf@koli.tasking.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Luca" == Luca Barbieri <ldb@ldb.ods.org> writes:

>> Anyway, which USB drivers are you using?  That might help us narrow this
>> down a bit.

Luca> speedtouch              8932   3
Luca> hid                    39652   0 (unused)
Luca> uhci-hcd               27900   0 (unused)
Luca> usbcore                88372   2 [speedtouch hid uhci-hcd]

Luca> Anyway the problems are obviously either in the USB core or in the uhci
Luca> driver.

For what it's worth. On my system I have problems with 2.5.4[56]. And they
seem to be related to USB. When I boot with nousb it boots OK. But without
this option I get OOPSes and panics everywhere. The system is happy with
2.5.44.

Some of these OOPSes happen during shutdown in device_shutdown. But panics
during boot are happening too. And then all I see on my screen is that the
call-trace in is reap_timer_fnc somewhere.

I've tried switching on USB_DEBUG, but that didn't help much. Neither the
DEBUG=1 in drivers/base/power.c.

My machine has a MSI K7T266 Pro motherboard with Athlon 1.3GHz. It has a
VIA chipset, 82C686b+VT8233. Harddisk: IBM Deskstar 60GXP, 40Gb.

I'm using CONFIG_USB_UHCI_HCD_ALT=y

		Kees

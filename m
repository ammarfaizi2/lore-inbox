Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265753AbTFSKFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 06:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265755AbTFSKFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 06:05:08 -0400
Received: from [193.219.88.42] ([193.219.88.42]:3210 "EHLO mg.homelinux.net")
	by vger.kernel.org with ESMTP id S265753AbTFSKFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 06:05:03 -0400
Date: Thu, 19 Jun 2003 13:18:58 +0300
From: Marius Gedminas <mgedmin@delfi.lt>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21: Bluetooth oopses with Acer USB dongle
Message-ID: <20030619101858.GA1745@gintaras>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org
References: <20030619072216.GB14665@gintaras> <1056014305.32273.90.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056014305.32273.90.camel@pegasus>
X-Message-Flag: If you do not see this message correctly, stop using Outlook.
X-GPG-Fingerprint: 8121 AD32 F00A 8094 748A  6CD0 9157 445D E7A6 D78F
X-GPG-Key: http://www.b4net.lt/~mgedmin/mg-pgp-key.txt
X-URL: http://www.b4net.lt/~mgedmin/
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 11:18:18AM +0200, Marcel Holtmann wrote:
> Hi Marius,

Hi, and thanks for the quick reply

> > When I insert an Acer USB Bluetooth dongle, 2.4.21 (vanilla + CPUfreq
> > patch found on Con Kolivas patch page, 1100_CFS_0306161356_2.4.21-ck1.patch)
> > immediately oopses:
> > 
> > Jun 19 02:38:56 perlas /etc/hotplug/usb.agent: Setup hci_usb for USB product b7a/7d0/134
> 
> what kind of Acer dongle is this?

Small and black ;)

I've a couple of photos that I was going to put on the web somewhere,
but at the moment usb-storage.o is stuck in the initialization phase.
Strange...  Perhaps 2.4.20 has other problems with this dongle confusing
the USB subsystem?  I haven't tried using it with another USB device at
the same time before.

> Please show us your data from
> /proc/bus/usb/devices for this device.

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0b7a ProdID=07d0 Rev= 1.34
S:  SerialNumber=3EC0B415
C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

> The following small patch should help.

Thank's, I'll try it.

Marius Gedminas
-- 
Power corrupts, but we need electricity.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbVHJUb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVHJUb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbVHJUb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:31:57 -0400
Received: from n1.cetrtapot.si ([212.30.80.17]:32493 "EHLO n1.cetrtapot.si")
	by vger.kernel.org with ESMTP id S1030257AbVHJUb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:31:56 -0400
Message-ID: <42FA6406.4030901@cetrtapot.si>
Date: Wed, 10 Aug 2005 22:31:02 +0200
From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C block reads with i2c-viapro: testers wanted
References: <20050809231328.0726537b.khali@linux-fr.org>
In-Reply-To: <20050809231328.0726537b.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:

> The easiest way to test the patch is to use i2c-viapro in conjunction
> with the eeprom driver. This supposes that you do actually have a VIA
> south bridge with EEPROMs (typically SPD) on the SMBus. If not, you
> won't be able to test, sorry.
> 
> In order to verify whether I2C block reads work for you, just compare
> the contents of this file:
>   /sys/bus/i2c/devices/0-0050/eeprom

I've tested your patch on gericom X5 with VIA chipset and it works fine 
without/with your patch (no diff in eeprom contents). Here is the lspci info:

noa linux # lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8753 [P4X266 AGP] (rev 01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
0000:00:03.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus 
Controller (rev 02)
0000:00:07.0 USB Controller: VIA Technologies, Inc. USB (rev 50)
0000:00:07.1 USB Controller: VIA Technologies, Inc. USB (rev 50)
0000:00:07.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
0000:00:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 46)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
0000:00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23)
0000:00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 
Audio Controller (rev 30)
0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 
Modem] (rev 70)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 70)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 440 
Go 64M] (rev a3)

regards,
hinko k

-- 
..because under Linux "if something is possible in principle,
then it is already implemented or somebody is working on it".

					--LKI

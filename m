Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVIAPLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVIAPLQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbVIAPLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:11:16 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:15585 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S1030190AbVIAPLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:11:14 -0400
Date: Thu, 1 Sep 2005 17:10:58 +0200 (CEST)
From: genoni@darkstar.linuxpratico.net
X-X-Sender: venom@Phoenix.oltrelinux.com
To: linux-kernel@vger.kernel.org
Subject: HELP: unable to use I-MATE SP3 as USB (HTC) gprs modem 
Message-ID: <Pine.LNX.4.63.0509011710430.27194@Phoenix.oltrelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I've got am I-mate SP3, running wince.

It works very well with every linux 2.6 kernel I tried (actually  2.6.13,
using the ipaq driver and synce. The phone is accessed trought ttyUSB0.

dmesg shows:

ipaq 1-1:1.0: PocketPC PDA converter detected
usb 1-1: PocketPC PDA converter now attached to ttyUSB0


in /proc/bus/usb/devices I read:

T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 24 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=ff(vend.) Sub=ff Prot=ff MxPS=64 #Cfgs=  3
P:  Vendor=0bb4 ProdID=0a51 Rev= 0.00
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=ipaq
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
C:  #Ifs= 1 Cfg#= 2 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
C:  #Ifs= 1 Cfg#= 3 Atr=c0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms


But I have a big problem.

I should use as an USB gprs modem.

Since it is possible to configure it to be a (HTC) modem, using it's menu,
when I enable it to act as a modem on the usb port the content of
/proc/bus/usb/devices who refers to the phone changes to: I


T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 37 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0bb4 ProdID=00cf Rev= 0.90
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=02(comm.) Sub=ff Prot=ff Driver=(none)
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=80ms

The hotplug does not work anymore using the ipaq driver (as I exspected),
and the device is not attacched to ttyUSB0.

I read Cls=02(comm.). I suppose there should be a way to use something
like cdc-acm driver. Unfortunatelly this driver does not seem to like my
phone.
All I get is a sad:

usb 1-1: new full speed USB device using uhci_hcd and address 39


Is there a way to solve this problem and to use I-mate SP3 smartphone as
gprs modem for linux or should I surrender?

Thanx in advance

Luigi Genoni




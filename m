Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbVBXVj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbVBXVj0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVBXVjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:39:25 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:40659 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262495AbVBXVjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:39:00 -0500
Date: Thu, 24 Feb 2005 22:38:53 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Greg KH <greg@kroah.com>
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 Mass storage device
Message-ID: <20050224213853.GA8646@mail.muni.cz>
References: <20050224175918.GA7627@mail.muni.cz> <20050224181347.GA10847@kroah.com> <20050224182300.GA7778@mail.muni.cz> <20050224184928.GA11490@kroah.com> <20050224190548.GA7978@mail.muni.cz> <20050224191243.GD11806@kroah.com> <20050224191809.GB7978@mail.muni.cz> <20050224192207.GB12018@kroah.com> <421E34B1.9050803@tiscali.de> <20050224211512.GC24969@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050224211512.GC24969@kroah.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 01:15:12PM -0800, Greg KH wrote:
> And if you look at the raw descriptors, which is what is displayed in
> /proc/bus/usb/devices in human readable form, the device itself tells
> the computer what speed it supports.  The host never tells the device
> what speed to run at.

I do not think so.

This is another device (Card reader) supporting USB 2.0. 

In this case I used only uhci_hcd driver and it reports speed 12.

T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=05dc ProdID=b018 Rev= 1.28
S:  Manufacturer=Lexar Media
S:  Product=Multi-Card Reader
S:  SerialNumber=0000246504
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

In this case I used both ehci_hcd and uhci_hcd drivers (ehci detected device)
and it reports speed 480. 

T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  2 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=05dc ProdID=b018 Rev= 1.28
S:  Manufacturer=Lexar Media
S:  Product=Multi-Card Reader
S:  SerialNumber=0000246504
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

So for me it looks like it reports speed according to USB driver or negotiated
speed.

-- 
Luká¹ Hejtmánek

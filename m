Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVBXTGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVBXTGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbVBXTGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:06:11 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:57274 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262451AbVBXTFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:05:54 -0500
Date: Thu, 24 Feb 2005 20:05:48 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 Mass storage device
Message-ID: <20050224190548.GA7978@mail.muni.cz>
References: <20050224175918.GA7627@mail.muni.cz> <20050224181347.GA10847@kroah.com> <20050224182300.GA7778@mail.muni.cz> <20050224184928.GA11490@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050224184928.GA11490@kroah.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 10:49:28AM -0800, Greg KH wrote:
> > This is the device:
> > http://www.msi.com.tw/program/support/download/dld/spt_dld_detail.php?UID=607&kind=6
> > 
> > Btw, I thought, that ehci-hcd driver handles both usb 2.0 and 1.1. Does it?
> 
> No, it hands off the usb 1.1 devices to the usb 1 core inside it.  This
> is either uhci or ohci, depending on your controller chip.
> 
> Unless you put a USB 2.0 hub in front of a usb 1.1 device, then it gets
> more complicated, but we'll just ignore that issue for now...
> 
> What does /proc/bus/usb/devices show for this device?

When connected through uhci-hcd:
T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1462 ProdID=5511 Rev=10.01
S:  Manufacturer=MSI
S:  Product=MEGA Player 5511
S:  SerialNumber=23DE7394D6198090
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

-- 
Luká¹ Hejtmánek

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316948AbSE1VcN>; Tue, 28 May 2002 17:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316950AbSE1VcM>; Tue, 28 May 2002 17:32:12 -0400
Received: from smtp02.fuse.net ([216.68.1.134]:61059 "EHLO smtp02.fuse.net")
	by vger.kernel.org with ESMTP id <S316948AbSE1VcL>;
	Tue, 28 May 2002 17:32:11 -0400
Message-ID: <3CF3F776.1040203@fuse.net>
Date: Tue, 28 May 2002 17:32:38 -0400
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020520 Debian/1.0rc2-3
X-Accept-Language: en
MIME-Version: 1.0
To: Colin Slater <hoho@binbash.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sony DSC-P71 Camera
In-Reply-To: <1022619053.894.35.camel@neptune>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Slater wrote:

>Hello, 
> I just got a Sony DSC-P71 digital camera (wonderful), but it doesn't
>seem to be working in linux. I beleive it uses the usb mass storage
>driver, it seems to use an equivilent driver in windows. I have scsi,
>usb, usb mass storage modules all loaded. 
>dmesg after I load the usb-storage module, and then plug the camera in:
>
>Initializing USB Mass Storage driver...
>usb.c: registered new driver usb-storage
>USB Mass Storage support registered.
>hub.c: USB new device connect on bus1/1, assigned device number 3
>scsi0 : SCSI emulation for USB Mass Storage devices
>
>I am useing devfs, and /dev/scsi is empty.
>
>cat /proc/bus/usb/devices:
><snip>
>T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
>D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
>P:  Vendor=054c ProdID=0010 Rev= 4.10
>S:  Manufacturer=Sony
>S:  Product=Sony DSC
>C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
>I:  If#= 0 Alt= 0 #EPs= 3 Cls=08(stor.) Sub=ff Prot=01 Driver=(none)
>E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
>E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
>E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
><snip>
>
>All this happens regardless of NVdriver being loaded or not.
>
>If someone with one of these cameras or the nearly identical DSC-P31
>could help me, it would be appreciated
>
>Colin
>
This camera doesn't use the mass storage driver (you don't show any log 
lines that indicate the driver claiming the device).  Instead I'd try 
the drivers under "USB Multimedia Devices" (you need v4l support).  A 
quick look doesn't look hopeful, but maybe one of those drivers will 
claim the device.  Anybody on LKML know for sure?

--Nathan


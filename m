Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVBXVtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVBXVtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVBXVtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:49:08 -0500
Received: from mail.stdbev.com ([63.161.72.3]:997 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S262503AbVBXVsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:48:46 -0500
Message-ID: <0c34ba38852752faa146731da6825252@stdbev.com>
Date: Thu, 24 Feb 2005 15:48:49 -0600
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: USB 2.0 Mass storage device
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: <matthias.christian@tiscali.de>, <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>
Reply-to: <jason@stdbev.com>
In-Reply-To: <20050224213853.GA8646@mail.muni.cz>
References: <20050224175918.GA7627@mail.muni.cz>
            <20050224181347.GA10847@kroah.com>
            <20050224182300.GA7778@mail.muni.cz>
            <20050224184928.GA11490@kroah.com>
            <20050224190548.GA7978@mail.muni.cz>
            <20050224191243.GD11806@kroah.com>
            <20050224191809.GB7978@mail.muni.cz>
            <20050224192207.GB12018@kroah.com>
            <421E34B1.9050803@tiscali.de>
            <20050224211512.GC24969@kroah.com>
            <20050224213853.GA8646@mail.muni.cz>
X-Mailer: Hastymail 1.3-CVS
x-priority: 3
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3:38:53 pm 02/24/05 Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> This is another device (Card reader) supporting USB 2.0.
>
> In this case I used only uhci_hcd driver and it reports speed 12.
>
> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=05dc ProdID=b018 Rev= 1.28
> S:  Manufacturer=Lexar Media
> S:  Product=Multi-Card Reader
> S:  SerialNumber=0000246504
> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50
> Driver=usb-storage E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>
> In this case I used both ehci_hcd and uhci_hcd drivers (ehci detected
> device) and it reports speed 480.
>
> T:  Bus=01 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  2 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=05dc ProdID=b018 Rev= 1.28
> S:  Manufacturer=Lexar Media
> S:  Product=Multi-Card Reader
> S:  SerialNumber=0000246504
> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50
> Driver=usb-storage E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
>
> So for me it looks like it reports speed according to USB driver or
> negotiated speed.

Same here with a new Seagate external USB 2.0 drive. If plugged into my
laptop which does not have USB 2.0 it shows 12 in /dev/bus/usb/devices,
however on a machine with USB 2.0 support it changes to 480.

\__  Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/


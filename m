Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751955AbWCFRZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbWCFRZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbWCFRZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:25:28 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:6065 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751955AbWCFRZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:25:27 -0500
Date: Mon, 6 Mar 2006 09:25:32 -0800
From: Greg KH <greg@kroah.com>
To: wixor <wixorpeek@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using usblp with ppdev?
Message-ID: <20060306172532.GB8697@kroah.com>
References: <c43b2e150603020732m42195b0dkf33d68fe64bc4a57@mail.gmail.com> <20060302165557.GA31247@kroah.com> <c43b2e150603030512l141c101va11300bcfbda4f60@mail.gmail.com> <20060303170752.GA5260@kroah.com> <c43b2e150603060631h494b920g84cf357f376d64bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43b2e150603060631h494b920g84cf357f376d64bb@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 03:31:32PM +0100, wixor wrote:
> >
> > What is the output of /proc/bus/usb/devices with your device plugged in?
> >
> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12 MaxCh=0
> D: Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P: Vendor=067b ProdID=2305 Rev= 2.02
> S: Manufacturer=Proliftic Technology Inc.
> D: Product=IEEE-1284 Controller
> C:* #Ifs=1 Cfg#= 1 Atr=a0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=07(print) Sub=01 Prot=01 Driver=usblp
> E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I: If#=0 Alt=1 #EPs=2 Cls=07(print) Sub=01 Prot=02 Driver=usblp
> E:  Ad=01(O) Atr=02(Bulk) MaxPS=64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MaxPS=64 Ivl=0ms
> I: If#=0 Alt=2 #EPs=3 Cls=ff(vend.) Sub=00 Prot=ff Driver=usblp
> E:  Ad=01(O) Atr=02(Bulk) MaxPS=64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MaxPS=64 Ivl=0ms
> E:  Ad=83(I) Atr=03(Int.) MaxPS=4 Ivl=1ms

That device says it is the USB Printer class, so odds are, it might not
do what you are trying to do here.

But if you want to play around and verify this, try modifying the USB
device table in the drivers/usb/misc/uss720.c file (look for the
structure called "uss720_table" and add a new entry with the vendor and
product id of your device there.)

good luck,

greg k-h

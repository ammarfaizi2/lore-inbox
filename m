Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbSJVQmc>; Tue, 22 Oct 2002 12:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264764AbSJVQmc>; Tue, 22 Oct 2002 12:42:32 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:22539 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264755AbSJVQmb>;
	Tue, 22 Oct 2002 12:42:31 -0400
Date: Tue, 22 Oct 2002 09:47:26 -0700
From: Greg KH <greg@kroah.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Take Vos <Take.Vos@binary-magic.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: USB mouse does not apear in /dev/input
Message-ID: <20021022164726.GA6471@kroah.com>
References: <200210221046.46700.Take.Vos@binary-magic.com> <200210221909.10753.bhards@bigpond.net.au> <200210221148.30286.Take.Vos@binary-magic.com> <200210222003.36872.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210222003.36872.bhards@bigpond.net.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 08:03:36PM +1000, Brad Hards wrote:
> On Tue, 22 Oct 2002 19:48, Take Vos wrote:
> > T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
> > D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> > P:  Vendor=046d ProdID=c00c Rev= 6.20
> > S:  Manufacturer=Logitech
> > S:  Product=USB Mouse
> > C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
> > I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=(none)
> > E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms
> So it looks like you don't have a driver for the mouse loaded (should be hid). 
> Can you check this in driverfs? (You used to be able to do this in 
> /proc/bus/usb/drivers,  but the maintainer knew better :-{)

The maintainer didn't have a choice :)
That info isn't known to the usb core anymore, only the driver core.

Do a:
	ls <driverfs_mount_point>/bus/usb/drivers
to see what USB drivers are registered.

thanks,

gre k-h

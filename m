Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbSJVKGF>; Tue, 22 Oct 2002 06:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbSJVKGF>; Tue, 22 Oct 2002 06:06:05 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:35037 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S262364AbSJVKGE>; Tue, 22 Oct 2002 06:06:04 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Take Vos <Take.Vos@binary-magic.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: USB mouse does not apear in /dev/input
Date: Tue, 22 Oct 2002 20:03:36 +1000
User-Agent: KMail/1.4.5
References: <200210221046.46700.Take.Vos@binary-magic.com> <200210221909.10753.bhards@bigpond.net.au> <200210221148.30286.Take.Vos@binary-magic.com>
In-Reply-To: <200210221148.30286.Take.Vos@binary-magic.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210222003.36872.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 22 Oct 2002 19:48, Take Vos wrote:
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=046d ProdID=c00c Rev= 6.20
> S:  Manufacturer=Logitech
> S:  Product=USB Mouse
> C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=(none)
> E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms
So it looks like you don't have a driver for the mouse loaded (should be hid). 
Can you check this in driverfs? (You used to be able to do this in 
/proc/bus/usb/drivers,  but the maintainer knew better :-{)
If you did this as modules, lsmod would be good to know too.

Also, there is a problem with 2.5.43, in that the core driver model stuff got 
screwed up. That caused problem if you turned on the usb test framework 
driver, and some other issues. Here is a simple patch that David Brownell 
did:
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=103457053803353&w=2

I'm not sure about 2.5.44 - you could try that too?

Brad

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9tSJ4W6pHgIdAuOMRAiCXAJ91Ytj7yQTE/pe6gQJjmVhKtl+2FACfQR3H
TANHmIIlvFR25uJF7scrSBA=
=N3g0
-----END PGP SIGNATURE-----


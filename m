Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262488AbSJVMYp>; Tue, 22 Oct 2002 08:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSJVMYp>; Tue, 22 Oct 2002 08:24:45 -0400
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:60544 "EHLO
	defiant.binary-magic.com") by vger.kernel.org with ESMTP
	id <S262488AbSJVMYn> convert rfc822-to-8bit; Tue, 22 Oct 2002 08:24:43 -0400
From: Take Vos <Take.Vos@binary-magic.com>
Organization: Binary Magic
To: Brad Hards <bhards@bigpond.net.au>
Subject: Re: PROBLEM: USB mouse does not apear in /dev/input (solved)
Date: Tue, 22 Oct 2002 14:23:18 +0200
User-Agent: KMail/1.4.7
References: <200210221046.46700.Take.Vos@binary-magic.com> <200210221311.19468.Take.Vos@binary-magic.com> <200210222121.04718.bhards@bigpond.net.au>
In-Reply-To: <200210222121.04718.bhards@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210221423.22790.Take.Vos@binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 22 October 2002 13:21, Brad Hards wrote:
> On Tue, 22 Oct 2002 21:11, Take Vos wrote:
> > On Tuesday 22 October 2002 12:03, you wrote:
> > > On Tue, 22 Oct 2002 19:48, Take Vos wrote:
> > > > T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
> > > > D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> > > > P:  Vendor=046d ProdID=c00c Rev= 6.20
> > > > S:  Manufacturer=Logitech
> > > > S:  Product=USB Mouse
> > > > C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
> > > > I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=(none)
> > > > E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms
> > >
> > > So it looks like you don't have a driver for the mouse loaded (should
> > > be hid).
> >
> > Yes, I compared it with the 2.4.19 output, which has the Driver=hid
> > thing. I have enabled the HID (full HID) and HID input layer in the
> > kernel
>
> Looks OK.
>
> > > Can you check this in driverfs? (You used to be able to do this in
> > > /proc/bus/usb/drivers,  but the maintainer knew better :-{)
> >
> > /devices/bus/usb/drivers
> > total 0
> > drwxr-xr-x    2 root     root            0 Oct 22 12:43 generic
> > drwxr-xr-x    2 root     root            0 Oct 22 12:43 hid
> > drwxr-xr-x    2 root     root            0 Oct 22 12:43 hub
> > drwxr-xr-x    2 root     root            0 Oct 22 12:43 usb-storage
> > drwxr-xr-x    2 root     root            0 Oct 22 12:43 usbfs
> > drwxr-xr-x    2 root     root            0 Oct 22 12:43 usblp
> > drwxr-xr-x    2 root     root            0 Oct 22 12:43 usbscanner
> >
> > The hid directory is empty, but so are the other, I don't know how
> > driverfs works yet.
>
> That is OK.
>
> > > Also, there is a problem with 2.5.43, in that the core driver model
> > > stuff got screwed up. That caused problem if you turned on the usb test
> > > framework driver, and some other issues. Here is a simple patch that
> > > David Brownell did:
> >
> > Well, I have had USB testing driver off.
>
> May turn up other problems too. Did you try the patch?
I just tried 2.5.44 the issue is solved.

Take
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9tUM5MMlizP1UqoURAqGJAKCZI85zSZYaEZSbQcPUKmSRX40wIgCdF+Al
3VvsHeQRHEQeiONIPTRnUmU=
=gbRQ
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265693AbSIRHRu>; Wed, 18 Sep 2002 03:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265706AbSIRHRu>; Wed, 18 Sep 2002 03:17:50 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:27590 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S265693AbSIRHRt>; Wed, 18 Sep 2002 03:17:49 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Greg KH <greg@kroah.com>, Duncan Sands <duncan.sands@wanadoo.fr>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
Date: Wed, 18 Sep 2002 17:15:50 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200207180950.42312.duncan.sands@wanadoo.fr> <200209152353.41285.duncan.sands@wanadoo.fr> <20020918065225.GB6840@kroah.com>
In-Reply-To: <20020918065225.GB6840@kroah.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209181715.51314.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 18 Sep 2002 16:52, Greg KH wrote:
> On Sun, Sep 15, 2002 at 11:53:41PM +0200, Duncan Sands wrote:
> > A simple fix is to change the test to [ $COUNT -lt 2 ];
>
> Good catch, yes the drivers file disappeared, and until now, almost no
> one noticed it :)
I assume that /proc/bus/usb/drivers went to driverfs. Everyone likes the new 
guy :)

I'd like the file back. We have a lot of debugging advice that asks people to 
send that particular file to us, and it is very useful. Even if you update 
the few places that you can find, then you will still have a lot of confusion 
(well, if you have 2.4, then send this, and if you have 2.6, send this, and 
if that doesn't exist, and you're on 2.4, mount this filesystem, else mount 
this filesystem). Ugly, and increases the support workload.

A symlink will do, assuming both filesystems are mounted. If we only have 
usbfs, I still want the data.

Please fix this before 2.6.

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9iCgnW6pHgIdAuOMRAgRcAJ9+i0ksw2S4qS8wvA+SD5prjA4IEwCcCulE
APZsrWY1WlNoY42cG8pXUTI=
=GNYM
-----END PGP SIGNATURE-----


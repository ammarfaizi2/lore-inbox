Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317872AbSIOGjm>; Sun, 15 Sep 2002 02:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317874AbSIOGjm>; Sun, 15 Sep 2002 02:39:42 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:19707 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S317872AbSIOGjl>; Sun, 15 Sep 2002 02:39:41 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Greg KH <greg@kroah.com>, oliver@neukum.name
Subject: Re: delay before open() works
Date: Sun, 15 Sep 2002 16:38:32 +1000
User-Agent: KMail/1.4.5
Cc: Brian Craft <bcboy@thecraftstudio.com>, linux-kernel@vger.kernel.org
References: <20020914094225.A1267@porky.localdomain> <200209151525.01920.bhards@bigpond.net.au> <20020915061026.GA484@kroah.com>
In-Reply-To: <20020915061026.GA484@kroah.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209151638.32883.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 15 Sep 2002 16:10, Greg KH wrote:
> This "second" hotplug event will happen when the driver registers with
> the "class".  So for the example of the USB scanner driver, it registers
> itself with the USB "class" to set up the file_ops structure (this is
> done in usb_register_dev().  At that point in time, /sbin/hotplug will
> be called again.
This is too soon, at least for the scanner driver. Look at how much code runs 
in scanner_probe() between the fops registration and the devfs registration.

Hmmm, that is probably a race anyway. Oliver?

Brad
- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9hCroW6pHgIdAuOMRAgJpAJ9WpQ66Oj5v7zaXqxqqTvVVhiukqACeJ3IP
T2oB/3+HODH36m9gSivzERw=
=Ov+1
-----END PGP SIGNATURE-----


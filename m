Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVGDIqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVGDIqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 04:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVGDIqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 04:46:43 -0400
Received: from relay.rost.ru ([80.254.111.11]:128 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S261287AbVGDIpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 04:45:23 -0400
Date: Mon, 4 Jul 2005 12:45:17 +0400
To: Lenz Grimmer <lenz@grimmer.com>
Cc: hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050704084517.GB24025@pazke>
Mail-Followup-To: Lenz Grimmer <lenz@grimmer.com>,
	hdaps-devel@lists.sourceforge.net,
	LKML List <linux-kernel@vger.kernel.org>
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <42C8D06C.2020608@grimmer.com>
X-Uname: Linux 2.6.12-mm1-pazke i686
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 185, 07 04, 2005 at 08:00:12AM +0200, Lenz Grimmer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hi Jesper,
>=20
> Jesper Juhl wrote:
>=20
> > I just had a nice chat with the guys there and we got some
> > improvements made by them and us merged up. And I /think/ we agreed
> > that I'll maintain the driver, merge fixes/features etc and eventually
> > try to get it merged.
>=20
> Thanks a ton! I am really excited to see that you guys made so much
> progress over the past few days! Of course, I immediately had to give it
> a try :)
>=20
> > Currently the driver loads, initializes the accelerometer and we can
> > read data from it.
>=20
> And here is a first support request - the kernel module does not load
> for me :(
>=20
> I have a Thinkpad T42, running SUSE Linux 9.3 (Kernel 2.6.11 with SUSE
> patches). The APS works on Windows, so I know the accelerometer is there.
>=20
> I have downloaded the sources from your site mentioned below, ran "make"
> and "make install". Then I created the /dev/hdaps0 device node by
> running "mknod hdaps0 c 228 0". (I picked this out of another message in
> the discussion)
>=20
> However, running "modprobe ibm_hdaps" only yields an error:
>=20
> FATAL: Error inserting ibm_hdaps
> (/lib/modules/2.6.11.4-21.7-default/kernel/drivers/misc/ibm_hdaps.ko):
> No such device or address
>=20
> In /var/log/messages, I only see:
>=20
> Jul  4 07:17:20 metis kernel: ibm_hdaps: unsupported module, tainting
> kernel.
> Jul  4 07:17:20 metis kernel: init 1 50239260

Looks like io port region is already busy.

> (The last number differs every time I load the module)
> Passing "debug=3D1" did not really reveal any more info. How could I
> provide you with more detail?

Run cat /proc/ioports
=20
> I also tried to load Henrik's module, but it also spits out an error
> "failed to allocate I/O", then a long number of "latch_check" lines and
> "initialize() ret: -5".
>=20
> Maybe the accelerometer on the T42 uses a different port range? Or could
> it be that some other kernel module is blocking this I/O range? I have
> no clue...
>=20
> > I'll be working on adding sysfs stuff to it tomorrow so it's generally
> > useful (at least for monitoring things - not yet for parking disk
> > heads).
>=20
> Maybe there is some kind of all-purpose ATA command that instructs the
> disk drive to park the heads? Jens, could you give us a hint on how a
> userspace application would do that?
>=20
> > Once I've got the sysfs stuff sorted I'll publish a new version.
> >=20
> > The most recent version of the driver is currently at
> > http://lemonshop.dk/ibm_hpaps/ (note: this is most likely not going to
> > be the permanent home of this driver, but it's where it lives for
> > now).
>=20
> Should we try to move the sources over to the hdaps.sf.net CVS tree?
> Even though I am more a Subversion fan, having at least some kind of
> version control would make it easier for others to participate and make
> sure we can send patches against the latest version.
>=20
> > Patches are welcome at jesper.juhl@gmail.com
>=20
> Attached please find a diff against ibm_hdaps.c I found on the URL above
> - - I moved some stuff to a separate header file (attached) and added
> printing out the driver name and copyright during module initialization
> (taken from Henrik's files). I also added an "uninstall" target to the
> Makefile.
>=20
> I hope you find it useful!
>=20
> Bye,
> 	LenZ
> - --
> - ------------------------------------------------------------------
>  Lenz Grimmer <lenz@grimmer.com>                             -o)
>  [ICQ: 160767607 | Jabber: LenZGr@jabber.org]                /\\
>  http://www.lenzg.org/                                       V_V
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.0 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>=20
> iD8DBQFCyNBpSVDhKrJykfIRAmLjAJwI1xaQEeW98M4yLVema2u+b9gX9wCfSufx
> BuNm1Kcfk48FAn1e3pMa27M=3D
> =3Dyy24
> -----END PGP SIGNATURE-----

> --- ibm_hdaps.c.org	2005-07-04 07:33:17.000000000 +0200
> +++ ibm_hdaps.c	2005-07-04 07:42:58.000000000 +0200
> @@ -34,31 +34,18 @@
>  #include <linux/delay.h>
>  #include <asm/io.h>
>  #include <asm/uaccess.h>
> +#include "ibm_hdaps.h"
> =20
> =20
> +#define DRV_NAME        "ibm_hdaps"
> +#define DRV_DESCRIPTION	"IBM ThinkPad Accelerometer driver"
> +#define DRV_COPYRIGHT  	"Copyright (c) 2005 Jesper Juhl <jesper.juhl@gma=
il.com>"
> +#define DRV_VERSION     "0.2"
> =20
> -#define HDAPS_LOW_PORT	0x1600	/* first port used by accelerometer */
> -#define HDAPS_NR_PORTS	0x30	/* nr of ports total - 0x1600 through 0x162f=
 */
> -
> -#define STATE_STALE	0x00	/* accelerometer data is stale */
> -#define STATE_FRESH	0x50	/* accelerometer data fresh fresh */
> -
> -#define REFRESH_ASYNC	0x00	/* do asynchronous refresh */
> -#define REFRESH_SYNC	0x01	/* do synchronous refresh */
> -
> -/*=20
> - * where to find the various accelerometer data
> - * these map to the members of struct hdaps_accel_data
> - */
> -#define HDAPS_PORT_STATE	0x1611
> -#define	HDAPS_PORT_XACCEL	0x1612
> -#define HDAPS_PORT_YACCEL	0x1614
> -#define HDAPS_PORT_TEMP		0x1616
> -#define HDAPS_PORT_XVAR		0x1617
> -#define HDAPS_PORT_YVAR		0x1619
> -#define HDAPS_PORT_TEMP2	0x161b
> -#define HDAPS_PORT_UNKNOWN	0x161c
> -#define HDAPS_PORT_KMACCT	0x161d
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR(DRV_COPYRIGHT);
> +MODULE_DESCRIPTION(DRV_DESCRIPTION);
> +MODULE_VERSION(DRV_VERSION);
> =20
>  static short debug =3D 0;
>  =20
> @@ -345,6 +332,9 @@
>  	int retval;
>  	struct hdaps_accel_data data;
> =20
> +	printk(KERN_INFO DRV_NAME ": " DRV_DESCRIPTION ", " DRV_VERSION "\n");
> +	printk(KERN_INFO DRV_NAME ": " DRV_COPYRIGHT "\n");
> +
>  	printk(KERN_WARNING "init 1 %08ld\n", jiffies);
>  	if (!request_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS, "ibm_hdaps"))
>  		return -ENXIO;
> @@ -367,7 +357,6 @@
>  	}
>  =09
>  	if (0) for (i =3D 0; i < 50; i++) {
> -		int j;
>  		unsigned long tmp;
>  		accelerometer_read(&data);
>  		printk(KERN_WARNING "state =3D %d\n", data.state);
> @@ -405,8 +394,3 @@
>  module_init(ibm_hdaps_init);
>  module_exit(ibm_hdaps_exit);
> =20
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Jesper Juhl");
> -
> -MODULE_DESCRIPTION("IBM ThinkPad Accelerometer driver");
> -MODULE_VERSION("0.2");

> /*
>  * Driver for IBM HDAPS (HardDisk Active Protection system)
>  *
>  * Based on the document by Mark A. Smith available at
>  * http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html
>  *
>  * Copyright (c) 2005  Jesper Juhl <jesper.juhl@gmail.com>
>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
>  * the Free Software Foundation; either version 2 of the License, or
>  * (at your option) any later version.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program; if not, write to the Free Software
>  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, =
USA.
>  */
>=20
> #ifndef __IBM_HDAPS_H__
> #define __IBM_HDAPS_H__
>=20
> #define HDAPS_LOW_PORT	0x1600	/* first port used by accelerometer */
> #define HDAPS_NR_PORTS	0x30	/* nr of ports total - 0x1600 through 0x162f =
*/
>=20
> #define STATE_STALE	0x00	/* accelerometer data is stale */
> #define STATE_FRESH	0x50	/* accelerometer data fresh fresh */
>=20
> #define REFRESH_ASYNC	0x00	/* do asynchronous refresh */
> #define REFRESH_SYNC	0x01	/* do synchronous refresh */
>=20
> /*=20
>  * where to find the various accelerometer data
>  * these map to the members of struct hdaps_accel_data
>  */
> #define HDAPS_PORT_STATE	0x1611
> #define	HDAPS_PORT_XACCEL	0x1612
> #define HDAPS_PORT_YACCEL	0x1614
> #define HDAPS_PORT_TEMP		0x1616
> #define HDAPS_PORT_XVAR		0x1617
> #define HDAPS_PORT_YVAR		0x1619
> #define HDAPS_PORT_TEMP2	0x161b
> #define HDAPS_PORT_UNKNOWN	0x161c
> #define HDAPS_PORT_KMACCT	0x161d
>=20
> #endif /*  __IBM_HDAPS_H__  */

> --- Makefile.org	2005-07-04 07:58:53.000000000 +0200
> +++ Makefile	2005-07-04 07:57:50.000000000 +0200
> @@ -26,3 +26,7 @@
>  	install -d $(KMISC)
>  	install -m 644 -c $(addsuffix .ko,$(list-m)) $(KMISC)
>  	/sbin/depmod -a
> +
> +uninstall:
> +	rm -f $(KMISC)/$(addsuffix .ko,$(list-m))
> +	/sbin/depmod -a


--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCyPcdR2OTnxNuAyMRAneqAKCJSydRQR9P476EHphCkjmIOVloVwCgrj1O
9z+wjp5k51qZCdtLTDI+2Ls=
=UnZF
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

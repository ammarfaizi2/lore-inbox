Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKAJSS>; Wed, 1 Nov 2000 04:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129068AbQKAJSJ>; Wed, 1 Nov 2000 04:18:09 -0500
Received: from wiiusc.wii.ericsson.net ([192.36.108.17]:53452 "EHLO
	hell.wii.ericsson.net") by vger.kernel.org with ESMTP
	id <S129055AbQKAJSB>; Wed, 1 Nov 2000 04:18:01 -0500
From: aer-list@mailandnews.com
Message-Id: <200011010916.KAA19911@hell.wii.ericsson.net>
X-Mailer: exmh version 2.2_20001026 06/23/2000 with nmh-1.0.3
To: David Woodhouse <dwmw2@infradead.org>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: / on ramfs, possible? 
In-Reply-To: Message from David Woodhouse <dwmw2@infradead.org> 
   of "Mon, 30 Oct 2000 23:32:23 GMT." <Pine.LNX.4.21.0010302329140.16675-100000@imladris.demon.co.uk> 
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-23702752P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Nov 2000 10:16:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-23702752P
Content-Type: text/plain; charset=us-ascii


> On Mon, 30 Oct 2000, H. Peter Anvin wrote:
> 
> > Pardon?!  This doesn't make any sense...
> > 
> > The question was: how do switch from the initrd to using the ramfs as /? 
> > Using pivot_root should do it (after the pivot, you can of course nuke
> > the initrd ramdisk.)
> 
> My question is: What do you want to do that for? You can nuke the initrd
> ramdisk, but you can't drop the rd.c code, or ll_rw_blk.c code, etc. So
> why not just keep your root filesystem in the initrd where it started off?
> 

Because the stuff on the initrd is not at all what I want in the resultant filesystem. The machine(s) in question are some disk-based some disk-less. I have a system for remote installation/removal of packages (--> the "partition" _has_ to be able to grove/shrink). 

The package builder should not have to worry about these details, so the directory hierarcy cannot contain any traces of _how_ the packges got there in the first place.

/Anders 






--==_Exmh_-23702752P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: Exmh version 2.2_20000822 06/23/2000

iD8DBQE5/99g/X4RQObd8qERAjQJAJ0Z9MZ3mFnjGVapIU8wvAqnf/aPyQCdH9j7
Whufdw43UyQtYRrs+fRitGE=
=h//7
-----END PGP SIGNATURE-----

--==_Exmh_-23702752P--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

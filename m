Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265757AbTL3LVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265758AbTL3LVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:21:32 -0500
Received: from port117.ds1-abc.adsl.cybercity.dk ([212.242.125.56]:39778 "EHLO
	mail.imaginere.dk") by vger.kernel.org with ESMTP id S265757AbTL3LVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:21:22 -0500
Date: Tue, 30 Dec 2003 12:21:19 +0100
From: Nuno Alexandre <na@imaginere.dk>
To: <linux-kernel@vger.kernel.org>
Cc: "Nicklas Bondesson" <nicke@nicke.nu>
Subject: Re: IDE-RAID Drive Performance
Message-Id: <20031230122119.1566247a@Genbox>
In-Reply-To: <S265736AbTL3KoB/20031230104401Z+18387@vger.kernel.org>
References: <S265736AbTL3KoB/20031230104401Z+18387@vger.kernel.org>
Organization: Fluxmod - www.imaginere.dk
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__30_Dec_2003_12_21_19_+0100_Eg6RwAbu6uQOXPfU"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__30_Dec_2003_12_21_19_+0100_Eg6RwAbu6uQOXPfU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2003 11:44:01 +0100 
Mr(s): Nicklas Bondesson wrote:

> Hi!
> 
> I think i'm getting really bad values from my disks. It's two Western
> Digital WD800JB-00DUA3 (Special Edition 8 MB cache) disks connected to a
> Promise TX2000 (PDC20271) card (RAID1 using ataraid under Linux 2.4.23).
> 
> The disks are setup with hdparm at boot time:
> 
> /sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hda 
> /sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hdc
> 
> When running hdparm -tT I get the following:
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
>  Timing buffered disk reads:  64 MB in  2.46 seconds = 26.02 MB/sec
> 
> /dev/hdc:
>  Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
>  Timing buffered disk reads:  64 MB in  2.47 seconds = 25.91 MB/sec
> 
> Are these normal values? I don't think so. Please advise.
> 
> /Nicke

Hi.
This is what i get with a Maxtor 6Y120L0 (2MB cache):

/dev/hda:
 Timing buffer-cache reads:   1320 MB in  2.00 seconds = 659.44 MB/sec
 Timing buffered disk reads:  140 MB in  3.02 seconds =  46.40 MB/sec

Using:
-d1 -u1 -m16 -c3 -W1 -A1 -k1 -X70 -a 8192

I'm not using raid, its a single disk connected to IDE1 on the motherboard.

Maybe you can try those parameters and see if it helps :)
-- 
Best regards - Nuno Alexandre - na@imaginere.dk
Gpg: EA74637D - http://imaginere.dk - iM:ikaro@jabber.org

--Signature=_Tue__30_Dec_2003_12_21_19_+0100_Eg6RwAbu6uQOXPfU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8V+vYtUZn+p0Y30RApNQAJ9rgC4mTg5Cb3iMw2eDeIDc1lJ7WACeLc0x
2vcqgWipfO7IGZKuT3O04jY=
=7TmD
-----END PGP SIGNATURE-----

--Signature=_Tue__30_Dec_2003_12_21_19_+0100_Eg6RwAbu6uQOXPfU--

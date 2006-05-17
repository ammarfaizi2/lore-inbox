Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWEQKPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWEQKPO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 06:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWEQKPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 06:15:14 -0400
Received: from pool-71-254-71-216.ronkva.east.verizon.net ([71.254.71.216]:62406
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750842AbWEQKPM (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 06:15:12 -0400
Message-Id: <200605171014.k4HAETHT011371@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore partition table on disks with AIX label
In-Reply-To: Your message of "Wed, 17 May 2006 11:10:56 +0200."
             <20060517091056.GA21219@suse.de>
From: Valdis.Kletnieks@vt.edu
References: <20060517081314.GA20415@suse.de> <200605170853.k4H8rn8K009466@turing-police.cc.vt.edu>
            <20060517091056.GA21219@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147860865_4166P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 06:14:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147860865_4166P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 May 2006 11:10:56 +0200, Olaf Hering said:
>  On Wed, May 17, Valdis.Kletnieks@vt.edu wrote:
> > One has to wonder if it might not be better to treat this case as
> > "one partition covering the entire disk", or even better, decode the AIX LVM
> > info and see if there's any LVM segments present on the disk, so as to limit
> > the chances of accidentally splatting live data.
> The check can go once someone has implemented proper support to read the
> drives. Up to now the bogus partitions cause only confusion and practical
> doesnt help anyone. So let it go.

Is there any interest in being able to deal with AIX's LVM and/or JFS/JFS2
(probably only read-only)?  If so, what level of support would be needed
to make it useful?

(Personally, being able to deal with it on a read-only basis for forensics
work would be useful - currently there's no really good way to deal with
an AIX system in a forensically sound manner, because 'importvg' and
friends have a tendency to scribble on the disks....)

Sanest way to approach it would probably be a mostly-userspace that
grovels out the LVM data and creates a device-mapper target.  ISTR there
was such a beast for the EVMS code, but I haven't gone digging for it yet.

--==_Exmh_1147860865_4166P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEaveBcC3lWbTT17ARAjpHAKDwiSgA8lh9yt0pxDhEXQaXcaSGwQCff+XD
YiUw/pgO3hmwk03cCmchSCc=
=94X7
-----END PGP SIGNATURE-----

--==_Exmh_1147860865_4166P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbTHUHZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 03:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbTHUHZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 03:25:41 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:14976 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S262469AbTHUHZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 03:25:38 -0400
Date: Thu, 21 Aug 2003 09:25:34 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t3: vfs/ext3 do_lookup bug?!
Message-Id: <20030821092534.0eb08a89.martin.zwickel@technotrend.de>
In-Reply-To: <20030820234119.33362f7a.akpm@osdl.org>
References: <20030820171431.0211930e.martin.zwickel@technotrend.de>
	<20030820113625.6a75d699.akpm@osdl.org>
	<bi0grq$49r$1@build.pdx.osdl.net>
	<20030821083337.6fc701b9.martin.zwickel@technotrend.de>
	<20030820234119.33362f7a.akpm@osdl.org>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.3claws36 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.fTG7o/4mAiH2fH"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.fTG7o/4mAiH2fH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2003 23:41:19 -0700
Andrew Morton <akpm@osdl.org> bubbled:

> Martin Zwickel <martin.zwickel@technotrend.de> wrote:
> >
> > cutted-dmesg.txt  text/plain (15496 bytes)
> 
> Try `dmesg -s 1000000'.   The silly thing has too small a buffer.

too late.. :(
rebooted and fscked.
on reboot, my console did hang up while unmounting fs's and i got tons of
strange errors about something on my fs(where the processes got stuck). can't
remeber the outputs, was too much and too fast.
only a sysrq-b helped.

on another fs i got some "Deleted inode ###### has zero dtime.  Fix<y>?".
(on other boxes i get them sometimes too if i manually check a ext3
fs)
shouldnt ext3 prevent those errors, since it has a journal and should
recover them???

on the fs where the processes got stuck i got some unattached inodes:
Unattached inode 1035466
Connect to /lost+found<y>? yes

Inode 1035466 ref count is 2, should be 1.  Fix<y>? yes

Unattached inode 1053163
Connect to /lost+found<y>? yes

Inode 1053163 ref count is 2, should be 1.  Fix<y>? yes

Inode 1053382 ref count is 1, should be 2.  Fix<y>? yes

Pass 5: Checking group summary information

is this the normal behaviour, to e2fsck the ext3 fs's after some time?
i thought that ext3 handles those errors itself.

well, after the reboot and fsck i can access my files again.

ps.: 2.6.0-t3 scheduler performance is not that good...

Regards,
Martin

-- 
MyExcuse:
Zombie processes detected, machine is haunted.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--=.fTG7o/4mAiH2fH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/RHPxmjLYGS7fcG0RAjB7AJ9qWNsnJ5WoYaJdURPRlKIQWck94ACgqulC
B5b44CXhZG58fnTD6PxSBBI=
=spOD
-----END PGP SIGNATURE-----

--=.fTG7o/4mAiH2fH--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266739AbUHTPfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266739AbUHTPfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUHTPfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:35:25 -0400
Received: from mail007.syd.optusnet.com.au ([211.29.132.55]:11501 "EHLO
	mail007.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266739AbUHTPe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:34:57 -0400
Message-ID: <41261A15.5050609@kolivas.org>
Date: Sat, 21 Aug 2004 01:34:45 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.8.1-ck3
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF9E69D6099FEC2AD8D0300D0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF9E69D6099FEC2AD8D0300D0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patchset update.

These are patches designed to improve system responsiveness with
specific emphasis on the desktop, but configurable to any workload.

Web site with faq:
http://kernel.kolivas.org
Patches:
http://ck.kolivas.org/patches/2.6/2.6.8.1/2.6.8.1-ck3/

ck2 was very similar for internal testing and didn't have the final fix 
for the cd audio burning problem making a new version necessary.


Added since 2.6.8.1-ck1:

+limit_hz.diff
minimise the lower Hz setting until I get a better fix for the rare
problem that occurs low Hz into staircase.

+cddvd-cmdfilter-drop.patch
back out changes that prevent non-root users writing cds until userspace
catches up

+cool-spinlocks-i386.diff
completely out of line spinlocks decrease kernel size and may decrease
cache trashing

+bio_uncopy_user-mem-leak.patch
+bio_uncopy_user2.diff
These are the bugfixes for the memory leak and the dud cds burnt when
burning audio and videocds

+fbsplash-0.9-r5-2.6.8-rc3.patch.bz2
Early release of gensplash (replacement for bootsplash) patch for
graphical bootup; see: http://dev.gentoo.org/~spock/projects/gensplash/

+make-tree_lock-an-rwlock.patch.bz2
+invalidate_inodes-speedup.patch
Compatibility patches for reiser4 from -mm

+2.6.8.1-mm2-reiser4.diff.bz2
Reiser4 filesystem


Changed:
~kiflush3.diff
Fixed the software suspend bug; changed the daemon to sleep for a minute
if it goes idle and be put to sleep if kswapd wakes up.

~akpm-latency-fix.patch
Rolled up latency hacks


Removed:
-token-thrashing-control
This was adversely affecting performance at low to medium levels of swap 
usage which is far more common than swap trashing.


Full patch series:
from_2.6.8.1_to_staircase7.I.bz2
schedrange.diff
schedbatch2.4.diff
schediso2.5.diff
sched-adjust-p4gain
hard_swappiness1.diff
supermount-ng204.diff.bz2
defaultcfq.diff
config_hz.diff
limit_hz.diff
1g_lowmem_i386.diff
kiflush3.diff
akpm-latency-fix.patch
9000-SuSE-117-writeback-lat.patch
cddvd-cmdfilter-drop.patch
cool-spinlocks-i386.diff
bio_uncopy_user-mem-leak.patch
bio_uncopy_user2.diff
fbsplash-0.9-r5-2.6.8-rc3.patch.bz2
make-tree_lock-an-rwlock.patch.bz2
invalidate_inodes-speedup.patch
2.6.8.1-mm2-reiser4.diff.bz2
2.6.8.1-ck3-version.diff


Cheers,
Con


--------------enigF9E69D6099FEC2AD8D0300D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBJhoXZUg7+tp6mRURAqfDAJ9aEXvwkoP0lJRPt/4Jw1usAgDyYgCfVSWD
tuUk34zZ939kR30IBI9PUPY=
=7FPl
-----END PGP SIGNATURE-----

--------------enigF9E69D6099FEC2AD8D0300D0--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUJXNsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUJXNsN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbUJXNqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:46:08 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:62340 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261499AbUJXNkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:40:01 -0400
Message-ID: <417BB099.1050501@kolivas.org>
Date: Sun, 24 Oct 2004 23:39:37 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>
Subject: 2.6.9-ck2
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC8B8B4D8CF5B7252211E3735"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8B8B4D8CF5B7252211E3735
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

These are patches designed to improve system responsiveness with
specific emphasis on the desktop, but configurable to any workload.

http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-ck2/patch-2.6.9-ck2.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches and a server specific patch available.


Added:
  +mwII-oc.diff
Linking hardmaplimit to overcommit is no longer required as hardmaplimit
is not set by default, and there was a compile problem with modules.
This backs it out.

  +back-sched-net-fix-scheduling-latencies-in-__release_sock.patch
Something about this patch from the low latency hacks in combination
with -ck causes a panic on nmap with some hardware (only on -ck). Remove
it for now.

  +ll-config1.diff
Change the default low latency config options to have the debug off by
default.

  +fix-bad-segment-coalescing-in-blk_recalc_rq_segments.patch
A bugfix for i/o scheduler which improves performance under heavy i/o load.

  +vm-pages_scanned-active_list.patch
A nasty bug that caused kswapd to get stuck consuming heaps of cpu which
was in mainline 2.6.9 was tracked down by some of my users (thanks!) and
fixed by Nick Piggin (thanks!).

  +269ck2-version.diff
Version


Removed:
  -ll-config.diff
This disabled preempting the BKL which actually seems quite safe on
further testing.


Full Patchlist:
2.6.9_to_staircase9.0.diff
schedrange.diff
schedbatch2.5.diff
schediso2.8.diff
mwII.diff
mwII-oc.diff
1g_lowmem1_i386.diff
cfq2-20041019.patch
block_fix.diff
defaultcfq.diff
269rc4-mingo_ll.diff
back-sched-net-fix-scheduling-latencies-in-__release_sock.patch
269rc4-mingo-bkl.diff
ll-config1.diff
cddvd-cmdfilter-drop.patch
nvidia_compat.diff
fix-bad-segment-coalescing-in-blk_recalc_rq_segments.patch
vm-pages_scanned-active_list.patch
269ck2-version.diff


Cheers,
Con


--------------enigC8B8B4D8CF5B7252211E3735
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBe7CnZUg7+tp6mRURAna1AJ9mLwF1MFZNTxYuhg5PJ3+ccsAOrwCePUwQ
iE0hqq8ZaPa0fINqgOP7o5Y=
=axRj
-----END PGP SIGNATURE-----

--------------enigC8B8B4D8CF5B7252211E3735--

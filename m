Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbVAKXZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbVAKXZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVAKXZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:25:19 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:56982 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262878AbVAKXWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:22:01 -0500
Message-ID: <41E45F8D.2050204@kolivas.org>
Date: Wed, 12 Jan 2005 10:21:49 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>
Subject: 2.6.10-ck3
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3F16CB2CF97EC4A82154C889"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3F16CB2CF97EC4A82154C889
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

These are patches designed to improve system responsiveness. It is 
configurable to any workload but the default ck3 patch is aimed at the 
desktop and ck3-server is available with more emphasis on serverspace.

http://ck.kolivas.org/patches/2.6/2.6.10/2.6.10-ck3/

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/


Changed since 2.6.10-ck2:
-nvidia_6111-6629_compat.diff
+nvidia_6111-6629_compat2.diff
Respun the nvidia compatibility patches to make them _really_ work with 
both the 6111 and 6629 drivers

-cfq-ts-050104.patch
+cfq-ts-19g.diff
Latest stable version of Jens' cfq-timeslices I/O scheduler with full 
I/O read and write priority support (stable and safe).

-2610ck2-version.diff
+2610ck3-version.diff
Version


Added:
+rt_ionice.diff
Set ionice level to best possible for real time tasks

+2.6.10-mm1-brk-locked.patch
+random-poolsize-int-overflow.diff
+rlimit-memlock-dos.diff
+scsi-int-overflow-information-leak.diff
+moxa-int-overflow.diff
A whole swag of security patches

+i2.8_i2.9.diff
+i2.9_i2.10.diff
This makes the SCHED_ISO scheduling far more robust. The soft realtime 
properties are more aggressive, and SCHED_ISO extends to -nice values 
behaviour as well now.

+s9.3_s9.4.diff
+s9.4_s10.diff
Behavioural bugs in the staircase scheduler were addressed. This brings 
up the version to staircase10. Specifically, s9.4 addresses yet another 
issue that would make tasks get stuck at lowest priority. s10 fixes the 
problem of frequent waking tasks (like sound servers) being seen as cpu 
bound.

+b2.6_b2.7.diff
First attempt at making batch tasks cooperate with swsusp. Does not 
succeed yet. You'll need to change batch tasks to SCHED_NORMAL if 
they're running to be able to suspend at the moment.

+cfq_writeprio_on.diff
Turn on the write priority support by default


Full patchlist:
2.6.10_to_staircase9.2.diff
schedrange.diff
schedbatch2.6.diff
schediso2.8.diff
mwII.diff
1g_lowmem1_i386.diff
defaultcfq.diff
2.6.10-mingoll.diff
cddvd-cmdfilter-drop.patch
vm-pageout-throttling.patch
inc_total_scanned.diff
2.6.10-capabilities_fix.diff
nvidia_6111-6629_compat2.diff
linux-2.6.7-CAN-2004-1056.patch
linux-2.6.9-smbfs.patch
fix-ll-resume.diff
cfq-ts-19g.diff
isobatch_ionice.diff
rt_ionice.diff
s9.2_s9.3.diff
2.6.10-mm1-brk-locked.patch
random-poolsize-int-overflow.diff
rlimit-memlock-dos.diff
scsi-int-overflow-information-leak.diff
moxa-int-overflow.diff
i2.8_i2.9.diff
s9.3_s9.4.diff
i2.9_i2.10.diff
b2.6_b2.7.diff
s9.4_s10.diff
cfq_writeprio_on.diff
2610ck3-version.diff

and available as an addon:
supermount-ng208-10ck1.diff


Cheers,
Con


--------------enig3F16CB2CF97EC4A82154C889
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5F+NZUg7+tp6mRURAhhbAJ9NuIYnw5C4VkTnBhOFZk/PJd7cQwCgg6hy
/ma7+q0+qzyZIUHnuyXwho4=
=aCfO
-----END PGP SIGNATURE-----

--------------enig3F16CB2CF97EC4A82154C889--

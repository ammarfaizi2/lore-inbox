Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVADIHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVADIHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 03:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVADIHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 03:07:43 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:47063 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261531AbVADIH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 03:07:28 -0500
Message-ID: <41DA4EB9.2030007@kolivas.org>
Date: Tue, 04 Jan 2005 19:07:21 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>
Subject: 2.6.10-ck2
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7315CFA49179CB0B0FEF27D1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7315CFA49179CB0B0FEF27D1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

These are patches designed to improve system responsiveness. It is 
configurable to any workload but the default ck1 patch is aimed at the 
desktop and ck1-server is available with more emphasis on serverspace.

http://ck.kolivas.org/patches/2.6/2.6.10/2.6.10-ck2/

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/

*Note do not enable full write i/o priority support it is currently broken*


Added since 2.6.10-ck1
+2.6.10-capabilities_fix.diff
+linux-2.6.7-CAN-2004-1056.patch
+linux-2.6.9-smbfs.patch
Security fixes

+nvidia_6111-6629_compat.diff
A more comprehensive set of compatibility changes to allow the nvidia 
6111 and 6629 driver versions to work

+fix-ll-resume.diff
Fixes the problem of acpi resuming by removing a small change from the 
low latency patches

+cfq-ts-050104.patch *
The latest version of the timeslice cfq I/O scheduler with i/o priority 
support

+isobatch_ionice.diff
Add discrete support for i/o priorities being linked with SCHED_BATCH 
and SCHED_ISO classes in the staircase cpu scheduler

+s9.2_s9.3.diff
A small change to the staircase scheduler. This backs out special quirk 
treatment of interactive tasks (so every task is now treated the same) 
and is a fix for some fluctuating interactivity issues people would have 
seen. It is a win in most settings but some people will notice bad 
behaviour with wine based games and audio while others will notice 
better behaviour with these games (go figure). A workaround is to run 
your games nice +19.

+2610ck2-version.diff
version


Removed:
-2.6.10-nvidia-fix.diff
Not needed with newer nvidia compat patch
-fix_noswap.diff
Not needed


Cheers,
Con


--------------enig7315CFA49179CB0B0FEF27D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2k65ZUg7+tp6mRURAh7VAJ9a95sz/Fucps1HD+fFHdXCJsnDigCfX0ra
CqimnjuLyoyCLDboR7dwCu0=
=9J3f
-----END PGP SIGNATURE-----

--------------enig7315CFA49179CB0B0FEF27D1--

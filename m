Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVAMOHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVAMOHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVAMOHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:07:53 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:34223 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261627AbVAMOHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:07:40 -0500
Message-ID: <41E680A2.3010000@kolivas.org>
Date: Fri, 14 Jan 2005 01:07:30 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>
Subject: 2.6.10-ck4
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig12038C89A387350008C08465"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig12038C89A387350008C08465
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

These are patches designed to improve system responsiveness. It is 
configurable to any workload but the default ck4 patch is aimed at the 
desktop and ck4-server is available with more emphasis on serverspace.

http://ck.kolivas.org/patches/2.6/2.6.10/2.6.10-ck4/

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/

I recommend all ck3 users upgrade.

2.6.10-ck3 was a brown paper bag release. A poorly considered last 
minute change made for some odd starvation problems. For this release I 
rewrote a large section of the staircase code that had been troubling me 
and been getting steadily worse. In the process I've made the semantics 
of resuming an old timeslice much simpler and more predictable.


Changed:
-cfq-ts-19g.diff
+cfq-ts-20.diff
Jens' latest incarnation of the cfq-timeslices patch with i/o priority 
support for read and write has much smoother read vs write 
characteristics now.


Added:
+s10_test1.diff
+s10_s10.1.diff
+s10.1_s10.2.diff
+s10.2_s10.3.diff
Staircase updates

+1504_vmscan-writeback-pages.patch
A fix for more oom-kill problems.


Thanks to the many people involved in testing the staircase changes and 
reporting back.

Cheers,
Con


--------------enig12038C89A387350008C08465
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5oClZUg7+tp6mRURArclAJ0cS0pz7yAi3cFEBueihghYtRXBJQCfeUDm
/2nUe8sB6uF8xdwW4kUBbQA=
=sMCd
-----END PGP SIGNATURE-----

--------------enig12038C89A387350008C08465--

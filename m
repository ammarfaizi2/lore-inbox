Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268435AbUI2Nta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268435AbUI2Nta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUI2NtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:49:16 -0400
Received: from mgw-x2.nokia.com ([131.228.20.22]:5819 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id S268448AbUI2NnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:43:23 -0400
X-Scanned: Wed, 29 Sep 2004 16:39:52 +0300 Nokia Message Protector V1.3.31 2004060815 - RELEASE
Message-ID: <415ABA96.6010908@nokia.com>
Date: Wed, 29 Sep 2004 16:37:26 +0300
From: =?ISO-8859-1?Q?Timo_Ter=E4s?= <ext-timo.teras@nokia.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>, Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: kobject events questions
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF2B9608A5BB0AEA74DAE270F"
X-OriginalArrivalTime: 29 Sep 2004 13:39:47.0139 (UTC) FILETIME=[C91FC930:01C4A629]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF2B9608A5BB0AEA74DAE270F
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I've been following the evolution of kobject events patch. This is 
because I'd like to implement a netfilter target that is able to send an 
event to userland using it.

There's a small description of it and some background in the netfilter 
mailing list:
http://lists.netfilter.org/pipermail/netfilter-devel/2004-August/016342.html

Now that the events are strictly associated with kobjects (the original 
patch had a way to send arbitrary events) I have two choices:

1) Send the events so that they are always associated with the network 
devices class_device kobject. I guess this would be quite clean way to 
do it, but it'd require adding a new signal type and would limit the 
iptables target to be associated always with a interface.

2) Create a device class that has virtual timer devices that trigger 
events (ie. /sys/class/utimer). Each timer could have some attributes 
(like expired, expire_time, etc.) and would emit "change" signals 
whenever timer expires.

I'd like to hear what you think of the thing I'm trying to do?

And especially how "bad" idea the option 2 is (since the new class might 
not be useful for others)?

Any ideas how this could be done better?

- Timo

--------------enigF2B9608A5BB0AEA74DAE270F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBWrqZFlRU9HaAsIcRAg1BAJ43n0lbfNdQ9jWNvxdtdFOJfzHoJgCfW9EM
VCwaIYHB30HW0X/unoL42+s=
=MfE6
-----END PGP SIGNATURE-----

--------------enigF2B9608A5BB0AEA74DAE270F--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbUJZSdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbUJZSdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbUJZSdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:33:52 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:62656 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261367AbUJZSdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:33:49 -0400
Message-ID: <417E988B.3060402@comcast.net>
Date: Tue, 26 Oct 2004 14:33:47 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Baron <jbaron@redhat.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix altsysrq deadlock
References: <Pine.LNX.4.44.0410261413240.12088-100000@dhcp83-105.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0410261413240.12088-100000@dhcp83-105.boston.redhat.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Jason Baron wrote:
| On Tue, 26 Oct 2004, John Richard Moser wrote:
|
|

[...]

|
|
| The patch only drops a sysrq that is about to cause a system deadlock. So
| if you haven't had any deadlocks this patch shouldn't have a noticeable
| affect.
|
| If a caller wants to rely on handle_sysrq, then it should not be called
| from interrupt context. handle_sysrq can not defer the work, since the
| point of sysrq is to be able get information out when the system is
| potentially unusable. How would you know when to defer the work and when
| not to?

Eh?  Wha?  I was just pointing out that it's useful beyond just
debugging, not proposing any feature changes or stuff.

|
| -Jason
|
|
|
|
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfpiKhDd4aOud5P8RAlyhAJ9/qfkA27SGGvgZ4WDPOzVm2VaKKQCdHrsk
R4V/S9phuxUVOXB8Zq7d5oI=
=9UZt
-----END PGP SIGNATURE-----

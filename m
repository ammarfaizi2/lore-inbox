Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWF1XqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWF1XqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWF1XqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:46:21 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:8594 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751786AbWF1XqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:46:20 -0400
References: <200606211716.01472.a1426z@gawab.com> <200606272302.16950.kernel@kolivas.org> <44A1C4D4.3080805@bigpond.net.au> <200606282306.14498.a1426z@gawab.com> <44A30F60.6070001@bigpond.net.au>
Message-ID: <cone.1151538362.930767.14982.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Incorrect CPU process accounting using
         =?ISO-8859-1?B?Q09ORklHX0haPTEwMA==?=
Date: Thu, 29 Jun 2006 09:46:02 +1000
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-14982-1151538362-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-14982-1151538362-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Peter Williams writes:

> Al Boldi wrote:
>> Peter Williams wrote:

>> twice:
>> 	1. for external proc monitoring, using a probed approach
>> 	2. for scheduling, using an inlined approach
> 
> Not exactly (e.g. there's no separation between user and sys time 
> available in line) but the possibilities are there.
> 
>> 
>> Wouldn't merging the two approaches be in the interest of conserving cpu 
>> resources, while at the same time reflecting an accurate view of cpu 
>> utilization?
> 
> I think that this would be a worthwhile endeavour once/if sched_clock() 
> is fixed.  This is especially the case as CPUs get faster as many tasks 
> may run to completion in less than a tick.

That may not be as simple as it seems. To properly account system v user 
time using the sched_clock we'd have to hook into arch dependant asm code to 
know when entering and exiting kernel context. That is far more invasive 
than the simple on/off runqueue timing we currently do for scheduling 
accounting.

--
-ck


--=_mimegpg-kolivas.org-14982-1151538362-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBEoxS7ZUg7+tp6mRURAqFzAJkBWM20gagmqwC0ogng3z9JtRWE7gCfeSqR
KGHjiq9yK7x4eF0w1xwulzg=
=+K7Y
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-14982-1151538362-0001--

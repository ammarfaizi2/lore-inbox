Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbUALQ5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266159AbUALQ5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:57:37 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:25845 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S265603AbUALQ5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:57:34 -0500
Date: Mon, 12 Jan 2004 11:57:12 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <3FFC9CC6.6010701@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Message-id: <4002D1E8.1010407@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enigEA5111B083A6672DC7BEA1FA;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1b5GC-29h-1@gated-at.bofh.it> <1b6CO-3v0-15@gated-at.bofh.it>
 <m3ad50tmlq.fsf@averell.firstfloor.org> <3FFC46EB.9050201@zytor.com>
 <3FFC7469.3050700@sun.com> <3FFC7469.3050700@sun.com>
 <3FFC790A.3060206@pobox.com> <3FFC9A76.4070407@sun.com>
 <3FFC9CC6.6010701@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEA5111B083A6672DC7BEA1FA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

>
>
> You're still using arguments -against- putting software in the kernel. 
> You don't decrease software's chances of "being broken" by putting it 
> in the kernel, the opposite occurs -- you increase the likelihood of 
> making the entire system unstable.  This is one point that Solaris and 
> Win32 have both missed :)
>
>     Jeff
>
I get what you're saying. :)

However, doing so achieves two goals:
    - I want kernelspace to provide mechanism, and let userspace define 
policy. In this case, the policy is even finer grained than what we had 
before and can be set at trigger time, rather than at initscript start time.
    - I want to get rid of the old ioctl poll interface that didn't work 
in namespaces.

The namespace problem effectively limits what we can do in userspace to 
simply prodding the kernel to tell _it_ to unmount stuff.  A daemon 
alone cannot unmount across namespaces. 

I hope this clarifies where I stand :)

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


--------------enigEA5111B083A6672DC7BEA1FA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAAtHrdQs4kOxk3/MRAjctAJ4tAkREzPP3F5pjC2wwSKvBUBZCAgCfck1W
T6n9VgibtHbzimekyzCohHE=
=Q0/q
-----END PGP SIGNATURE-----

--------------enigEA5111B083A6672DC7BEA1FA--


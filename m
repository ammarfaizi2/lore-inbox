Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbUAGQTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUAGQTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:19:54 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:11693 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S265603AbUAGQTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:19:34 -0500
Date: Wed, 07 Jan 2004 11:19:19 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <3FFB34C9.5010305@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tim Hockin <thockin@hockin.org>, autofs <autofs@linux.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <3FFC3187.4010004@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig15D01383AAD1AD33F2E88DFC;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com>
 <20040106215018.GA911@sun.com> <3FFB316A.6000004@zytor.com>
 <20040106221502.GA7398@hockin.org> <20040106221502.GA7398@hockin.org>
 <3FFB34C9.5010305@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig15D01383AAD1AD33F2E88DFC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:
> Tim Hockin wrote:
> 
>>On Tue, Jan 06, 2004 at 02:06:34PM -0800, H. Peter Anvin wrote:
 >>
>>>
>>>First of all, I'll be blunt: namespaces currently provide zero benefit
>>>in Linux, and virtually noone uses them.  I have discussed this with
>>>Linus in the past, and neither one of us see namespaces as being worth
>>
>>Let's get rid of them, then.  Make life that much easier.
>>
> 
> 
> That's what the Linux community is doing, de facto.  The Linux userspace
> simply is not set up to handle namespaces, and the autofs daemon is no
> exception.  Consider such a simple thing as /etc/mtab - /proc/mounts
> which is necessary for most of the mount(8) functionality to work.  It
> doesn't support namespaces and really cannot be made to.
> 
> namespace support in Linux is at the best a far-off future goal.  It is
> one thing to put in infrastructure, especially since it has some other
> nice benefits; it's another thing to revamp all of userspace to use it;
> it's nowhere close and autofs is no exception.
> 

This is clearly not 'all of userspace'.  Autofs is an exception.  As is 
/etc/mtab.  The way I see it, automounting is a 'mount facility', as are 
namespaces.  The two should be made to work together.  Yes, mount(8) 
should probably be fixed one way or another as well due to /etc/mtab 
breakage. Why? Because it too is a mount facility.

There are a couple problems inherent with namespaces.  Most of these are 
mount facilities that are broken such as mentioned above.  They *should* 
be fixed to work nicely.

Other parts of userspace get confused with namespaces, eg: cron and atd. 
  These programs clearly need infrastructure added that somehow allows 
for arbitrary namespace joining/saving.  If you have suggestions for how 
we can solve this issue, please do let me know.  I'm stumped :\  I'd be 
more than happy to discuss this with you.

One not-so-far fetched approach would be to associate cron/at jobs with 
automount configurations so that a namespace can be re-constructed at 
runtime.


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

--------------enig15D01383AAD1AD33F2E88DFC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//DGKdQs4kOxk3/MRAiiNAKCWzFHvVYY3ZxkwvEbjuY7iDA3TwgCeKw0R
yxVfKgv/doq7BAsGUEjs7NI=
=x36B
-----END PGP SIGNATURE-----

--------------enig15D01383AAD1AD33F2E88DFC--


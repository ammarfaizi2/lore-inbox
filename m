Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268911AbUJPVqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268911AbUJPVqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 17:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUJPVqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 17:46:23 -0400
Received: from hamlet.e18.physik.tu-muenchen.de ([129.187.154.223]:52905 "EHLO
	hamlet.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S268899AbUJPVpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 17:45:23 -0400
In-Reply-To: <20041016062512.GA17971@mark.mielke.cc>
References: <20041016043540.GA17514@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKOELCPAAA.davids@webmaster.com> <20041016062512.GA17971@mark.mielke.cc>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-3--603223085"
Message-Id: <89DD4021-1FBC-11D9-942F-000A9567DDDE@e18.physik.tu-muenchen.de>
Content-Transfer-Encoding: 7bit
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
       David Schwartz <davids@webmaster.com>
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sat, 16 Oct 2004 23:44:21 +0200
To: Mark Mielke <mark@mark.mielke.cc>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-3--603223085
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Mark!

On Oct 16, 2004, at 8:25 AM, Mark Mielke wrote:

> On Fri, Oct 15, 2004 at 09:58:38PM -0700, David Schwartz wrote:
>>> You're thinking too fast, and skipping the most important point here:
>>>     1) packet was dropped earlier (or was never sent)
>>>          - if select() is issued, it blocks
>>>          - if recvmesg() is issued, it blocks
>>>     2) packet was received, but is corrupt
>>>          - if select() is issued, it does not block
>>>          - if recvmesg() is issued, it blocks
>>> See the problem?
>> I'm talking about the case where it is dropped after the 'select' hit 
>> but
>> before the call to 'recvmsg'. In that case, the select does not block 
>> but
>> the recvmsg does.
>
> You are talking about the make believe case that only exists due to
> the *current* implementation of Linux UDP packet reading. It doesn't
> have to exist. It exists only behaviour nobody saw fit to implement it
> with semantics that were reliable, because the implentors didn't 
> foresee
> blocking file descriptors being used. It's an implementation oversight.
>
Well, I haven't read the source to see what would be necessary to 
create this behaviour, but David was talking about the situation where 
the UDP packet is dropped because of memory pressure. This event cannot 
possibly be foretold by select()...

Ciao,
					Roland

--
TU Muenchen, Physik-Department E18, James-Franck-Str. 85747 Garching
Telefon 089/289-12592; Telefax 089/289-12570
--
A mouse is a device used to point at
the xterm you want to type in.
Kim Alm on a.s.r.

--Apple-Mail-3--603223085
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFBcZY5I4MWO8QIRP0RAqjCAJ9KnXR3C8pmXmIIPX397SCp/wtauwCfb7nr
aZNN2eJ5bvdMYW+g+pJNkss=
=0A9Q
-----END PGP SIGNATURE-----

--Apple-Mail-3--603223085--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUCDEC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 23:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbUCDEC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 23:02:58 -0500
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:49027 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261442AbUCDECM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 23:02:12 -0500
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Wed, 3 Mar 2004 23:02:10 -0500
To: linux-kernel@vger.kernel.org
Cc: Davi Leal <davi@leals.com>
Subject: Re: Linux 2.6.2, AMD kernel: MCE: The hardware reports a non fatal, correctable incident
Message-ID: <20040304040210.GA3823@rivenstone.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Davi Leal <davi@leals.com>
References: <200403021900.16085.davi@leals.com> <20040302215554.GA29752@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20040302215554.GA29752@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02, 2004 at 09:55:54PM +0000, Dave Jones wrote:
> On Tue, Mar 02, 2004 at 07:00:16PM +0100, Davi Leal wrote:
>> What about this message?. Note that the system works. I have not had to=
=20
>> reboot. What meens the below message?.
>>
>
> The original plan behind that option was to find hardware faults early,
> but it seems to trigger a lot of false positives for various reasons.
> Part of this problem is that MCEs can also be generated on some hardware
> by doing something silly like reading from a reserved part of your
> motherboard chipset..

    The MCE stuff truly did find a hardware fault early for me; my
Athlon system was MCE'ing and I ignored it, and later I got sig11
errors and fs corruption, which I finally traced to a failing stick
of memory.

> There are also CPU errata that can cause them to falsely trigger in
> some unusual cases, but I've not had time to go through the various
> errata datasheets to blacklist affected CPUs unfortunatly.
>
> I'm toying with the idea of marking it CONFIG_BROKEN for 2.6,
> and fixing it up later.

    I wouldn't be so quick to write off MCEs as bugs or errata,
especially if the exceptions have only just begun showing up.
Running CPUBurn, memtest86 and the like is still probably a good
idea, especially if you value the data on your file system.

--
Joseph Fannin
jhf@rivenstone.net

"Anyone who quotes me in their sig is an idiot." -- Rusty Russell.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARqpBWv4KsgKfSVgRAoa2AJwMNfOmuHkte5MasX/HOKaZY044XwCfXZqK
mgmYX6IUj4h/0ZMQrfM/ySI=
=SYDD
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

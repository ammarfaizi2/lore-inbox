Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUDKLhx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 07:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUDKLhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 07:37:53 -0400
Received: from smtp-out3.xs4all.nl ([194.109.24.13]:47117 "EHLO
	smtp-out3.xs4all.nl") by vger.kernel.org with ESMTP id S262311AbUDKLht
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 07:37:49 -0400
In-Reply-To: <20040410190230.GD1056@selene>
References: <1Ijzw-4ff-5@gated-at.bofh.it> <1Ijzv-4ff-3@gated-at.bofh.it> <1IntE-7wn-39@gated-at.bofh.it> <m3isgb69xx.fsf@averell.firstfloor.org> <407826DF.9030506@clanhk.org> <20040410184904.GA12924@colin2.muc.de> <20040410190230.GD1056@selene>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-23-297051083"
Message-Id: <A716F1DA-8BAC-11D8-A41D-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
Cc: "J. Ryan Earl" <heretic@clanhk.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>
From: Paul Wagland <paul@wagland.net>
Subject: Re: amd64 questions
Date: Sun, 11 Apr 2004 13:37:46 +0200
To: Hugo Mills <hugo-lkml@carfax.org.uk>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-23-297051083
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Apr 10, 2004, at 21:02, Hugo Mills wrote:

> On Sat, Apr 10, 2004 at 08:49:04PM +0200, Andi Kleen wrote:
>>> line either?  Or we can if we use AMD64 [DM] libraries with a AMD64
>>> kernel?  DM = Device Mapper right?
>>
>> You can't use Device Mapper with 32bit user tools on a 64bit kernel
>> right now.
>
>    Well, you can, because that's what I'm doing on this machine. Joe
> Thornber posted a patch[1] here a few weeks ago which fixes the
> problem in a "sealing-wax-and-string" kind of way. It Works For
> Me(tm), which is about all you can say about it -- it's not the
> prettiest piece of code, even to my non-kernel eyes. :)

Ah, yes, but you missed the bit slightly later in the thread where Andi 
requested that this not be added to the kernel since it would then 
break all currently existing 64bit DM user tools. Newly compiled ones 
would, of course, work, but you introduce a DM user tool versioning 
problem, where the old 64 bit utils need to be used with old kernels, 
and the new tools need to be used with the new kernels. As far as I 
understood, this is the "official" line for the mainstream kernel. It 
is my hope that the disties all decide to use Thornbers patch when they 
do release, but only time will tell...

Of course, this also means that you can't "dual boot" your linux 
partition based if you use DM on the fact that you cannot use the same 
DM tools. For this reason I would like the problem to be fixed in the 
mainline kernel, but that is primarily a selfish concern ;-) as it 
makes my own migration harder.

Cheers,
Paul

--Apple-Mail-23-297051083
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAeS4Ntch0EvEFvxURAm3XAKC8pmbgaYqxIBFMqejm7y7b+Uy4DgCgy2Xa
2TPYlIm3OuMiaKgb/R6emno=
=RUJW
-----END PGP SIGNATURE-----

--Apple-Mail-23-297051083--


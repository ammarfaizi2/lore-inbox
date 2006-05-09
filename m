Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWEIM3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWEIM3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWEIM3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:29:08 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:20159 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932479AbWEIM3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:29:07 -0400
Message-ID: <44608B0D.3050300@stesmi.com>
Date: Tue, 09 May 2006 14:29:01 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Madhukar Mythri <madhukar.mythri@wipro.com>,
       Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: How to read BIOS information
References: <445F5228.7060006@wipro.com>	 <1147099994.2888.32.camel@laptopd505.fenrus.org>	 <445F5DF1.3020606@wipro.com>	 <1147101329.2888.39.camel@laptopd505.fenrus.org>	 <445F63B3.2010501@wipro.com> <20060508152659.GG1875@harddisk-recovery.com>	 <4460273E.5040608@wipro.com> <1147172624.3172.60.camel@localhost.localdomain>
In-Reply-To: <1147172624.3172.60.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enigAA491EB772670D94168290B6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA491EB772670D94168290B6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> On Maw, 2006-05-09 at 10:53 +0530, Madhukar Mythri wrote:
> 
>>  yeah, your are correct. but, the thing is my superiors want, even if 
>>kernel not reconize/use HT, we have to capture it from BIOS...
>>Thats why i asked as, how to read BIOS information?
> 
> 
> You ask the BIOS vendor for the exact board in question.
> 
> If you want to ask the processor itself then you can use the model
> specific registers. These are accessible via /dev/cpu/<cpuid>/msr so you
> can perform the Intel recommended sequence for checking if the processor
> has HT enabled.
> 
> It might be simpler to look in /proc/cpuinfo if you just need the basic
> information

He's actually asking if the BIOS has turned on HT, not if some other
means has...

BUT, the only thing I can think of is turning OFF HT in the BIOS,
reading the CMOS, storing it somewhere, turning ON HT, storing
that somewhere and comparing them. Then he'll know that in his
specific BIOS revision on his specific mainboard that bit is
stored in one specific place and he can go from there.

Messy, definately not recommended, stupid but hey, if the bosses
ask for it and you gotta give it ..

Just make triple sure you tell them that if you upgrade the BIOS
the test might fail or if you change mainboard, etc.

// Stefan

--------------enigAA491EB772670D94168290B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEYIsRBrn2kJu9P78RA+KiAKC9nZpkundhTv7IRF/7ERmiKDI4RgCgkuBV
RTi2M60BiNG1N3U+4tslB18=
=QTvN
-----END PGP SIGNATURE-----

--------------enigAA491EB772670D94168290B6--

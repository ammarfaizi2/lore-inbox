Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWGEH3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWGEH3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 03:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWGEH33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 03:29:29 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:54172 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932178AbWGEH33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 03:29:29 -0400
Message-ID: <44AB6A57.2060205@stesmi.com>
Date: Wed, 05 Jul 2006 09:29:27 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Lee Revell <rlrevell@joe-job.com>,
       James Courtier-Dutton <James@superbug.co.uk>,
       alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       Olivier Galibert <galibert@pobox.com>, perex@suse.cz,
       Olaf Hering <olh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
References: <20060629192128.GE19712@stusta.de>  <44A54D8E.3000002@superbug.co.uk> <20060630163114.GA12874@dspnet.fr.eu.org>  <1151702966.32444.57.camel@mindpipe>  <20060701073133.GA99126@dspnet.fr.eu.org> <44A6279C.3000100@superbug.co.uk>  <44A76DDF.4020307@superbug.co.uk>  <Pine.LNX.4.61.0607021153220.5276@yvahk01.tjqt.qr> <1151854092.12026.39.camel@mindpipe> <Pine.LNX.4.61.0607022304230.5218@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607022304230.5218@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig13E2E95B9D3C5BE8E7325CDA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig13E2E95B9D3C5BE8E7325CDA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Engelhardt wrote:
>>>Well you could patch the affected plugin's .dynstr table so that it should at
>>>best try to call a function that has not yet been defined somewhere else (like
>>>open); IOW, you change the .dynstr entry from 'open' to say 'my_open', and
>>>regularly include libmy.so through e.g. LD_PRELOAD.
>>>
>>>Of course the MD5 won't match afterwards, but I think the plugin should execute
>>>as usual afterwards, since .dynstr is something no app should rely on.
>>
>>Is this likely to work with an app like Skype that takes extensive steps
>>to thwart reverse engineers?
> 
> 
> We do not reverse engineer the .text section, but change the .dynstr 
> section that is specific to the ELF format. I doubt any app out there md5s 
> itself.

There is at least one. True that it doesn't do sound (it's an antivirus
scanner for mailservers :)) but regardless, it checksums the whole
thing.

// Stefan

--------------enig13E2E95B9D3C5BE8E7325CDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEq2pXBrn2kJu9P78RAx1+AJ9b5byLxkX71UGNDeClxqI+Qz0rCACgi9i6
Ir6p5tAoaGOVaLStgaEUfeM=
=pChO
-----END PGP SIGNATURE-----

--------------enig13E2E95B9D3C5BE8E7325CDA--

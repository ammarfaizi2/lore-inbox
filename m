Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVDNW2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVDNW2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVDNW2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:28:50 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:57045 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S261593AbVDNW2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:28:32 -0400
Message-ID: <425EEE2B.2000606@tin.it>
Date: Thu, 14 Apr 2005 17:26:51 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de> <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it> <20050412224357.GE3631@stusta.de> <425EAAF9.8060506@tin.it> <20050414201527.GD3628@stusta.de>
In-Reply-To: <20050414201527.GD3628@stusta.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5D3BD1EA3B155CBA99AC4FFE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5D3BD1EA3B155CBA99AC4FFE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> Linux kernel development is working different.
> 
> Getting changes quickly to the users is considered more important than 
> API or even ABI compatibility.

I don't agree about API, but that's how it goes :) APIs are too 
important to bring them down from my point of view.

> Offering improvements and new drivers to the users quickly is one way to 
> care about the users.

Of course!

> I do not claim to agree with all details of kernel development - but 
> that's how it works.

I know, I can bring ideas but I think most of them are already somewhere :)

> If you upgrade the kernel, simply get a version of your external modules 
> that support your new kernel, compile them against the new kernel, and 
> ship the external modules as part of the rollout of the new kernel.

That should be an option.

> Kernel development is based on the fact that all drivers should be 
> shipped with the kernel.

That can be partly true. There are many things which are gpl (so no 
licence problems) but are not in the kernel (see the pwc module).

> If you buy hardware where no open source driver exists (often because 
> the hardware manufacturer doesn't publish the hardware specifications) 
> that's your problem.

I don't buy hardware not already tested with linux...

> Space for the code behind all the obsolete interfaces.

I see.

> There are optimizations that are not possible without breaking 
> compatibility.
> 
> Documentation/stable_api_nonsense.txt contains examples.

Mh. Good thing to know.

> You can't care about everything.
> 
> What you propose has both advantages and disadvantages for users of the 
> kernel. It's general consensus among the kernel developers that the 
> advantages are not worth the disadvantages.

That's why I was thinking about high modularity. Increasing the 
modularity and of course, having the same api gives extreme flexibility 
in changing the internal representation.

You know what? I was amazed about the /dev directory. When in 96 I first 
approached linux, I simply said: that's a smart thing, handling every 
kind of device the same way. Writing in a console is not different from
writing in /dev/hda. Amazing.

I was just thinking about something like that for kernel developing. 
Having an external representation which is stabe like it's /dev, but 
flexible internally (I don't mean that the kernel shoud provide a 
``devfs'' for module!). When a new piece should be added, it doesn't 
matter the version, the way of accessing things are still the same. How 
it works may differ a lot.

I strongly believe in high modularity. No questions about micro/macro 
kernel. Both have pros and cons. But I strongly believe that a very 
small kernel providing means for modules to work (in kernel space) is 
something at least easier to mantain, other than having a single piece. 
Modules were very nice when I began to write some of them (it was kernel 
2.0.x though --- slack 3.0) just for fun. Just add a new piece and 
you'll be able to use a new device, and they can be provided by anyone. 
New file systems, new sound cards, everything, just adding a ``small'' 
piece of code --- it was painful using isapnp package and have my weird 
soundcard work! Ah, good memories... :)

Cheers

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enig5D3BD1EA3B155CBA99AC4FFE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXu4u4LBKhYmYotsRAo3hAJ9AsYWz/SCIaAt4Zrvy5EQPNSzXjACfV7Ni
z9KO05g2lOkeOfnMDk5aUww=
=kTuL
-----END PGP SIGNATURE-----

--------------enig5D3BD1EA3B155CBA99AC4FFE--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVDNRpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVDNRpg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVDNRpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:45:36 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:57340 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S261576AbVDNRpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:45:07 -0400
Message-ID: <425EAAF9.8060506@tin.it>
Date: Thu, 14 Apr 2005 12:40:09 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de> <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it> <20050412224357.GE3631@stusta.de>
In-Reply-To: <20050412224357.GE3631@stusta.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig760342C8E89769EA4DE67E40"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig760342C8E89769EA4DE67E40
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
>>When a new component is added to the kernel, let's say support for a new 
>>file system, a .config entry is created (CONFIG_MYFS=y|m). Why is this 
>>entry breaking compatibility? I mean, symbols still remains the same. 
>>The addition of symbols is not a breaking point.
> 
> That's clear.
> 
> You said you've read Documentation/stable_api_nonsense.txt .
> Please read the USB example in this document as an example when even API 
> compatibility was a problem.

The example says that the usb layer changed from synchronous to 
asynchronous and changed the data model. I'd say changing drastically is 
a big issue. I'd say it would be a change from 2.4 to 2.6 series. It 
does not mean that in a year we have to stick with the same version, in 
a year things can change drastically and so should be the version.

I see one big thing: developement should be careful about who uses the 
kernel and not caring about it alone, since it's not something useful by 
itself :)

> If you upgrade your kernel, you'll also upgrade the modules shipped with 
> the kernel.

Yes! You said it yourself: shipped with the kernel. The world does not 
rely only on the kernel. I have to administer a department, and I use 
other modules that won't be in the kernel, such as afs.

> -> it doesn't matter whether the code shipped with the kernel is 
>    compiled static or modular

Static fills the memory, modular is better :) If I don't use a module, 
that should be unloaded from the memory automatically. Modular things 
makes them less complex to mantain if properly designed.

> What's an "optimal kernel"?

I don't know... in the thread someone said sub-optimal. Probably he 
referred to a kernel with lots of useless things, while I can compile 
only the things I need (optimal).

> In a closed-sourse system, there's usually the OS plus API+ABI for 
> driver writers and the drivers are often shipped with the hardware.
> Therefore API+ABI compatibility is required.

Not only in closed-source.

> In an open source system, it's usually more common that all drivers are 
> shipped with the kernel. Therefore, there isn't such a big need for 
> API+ABI compatibility since you can change all modules using an API when 
> changing an API. And ABI compatibility isn't required because you can 
> recompile the modules every time you recompile the kernel.

That's not entirely true. Kernel does not have all the modules someone 
can use, and I made an example with my own department. The kernel should 
make the machine work, providing means to operate the hardware. So, in 
no case one can imagine having every single driver on this earth built 
in the kernel...

> ABI compatibility between kernel versions costs the following:
> - space for all users of the kernel

I don't understand. Space of what?

> - speed of the kernel

Mmh... why should it be? Optimizing the kernel is possible, speeding it 
up, without affecting ABI. Adding new components can't affect speed as 
long as it won't affect it wihout ABI (adding parts does of course 
affect the speed, but it's not different from ABI to non-ABI).

> - much extra work and checking when doing any changes

Of course! You're developing a kernel to be used by other people! It's 
quite... straightforward to be really careful about changes.

> Nobody claims API+ABI compatibility was technically impossible in the 
> Linux kernel. It's simply a consensus among the kernel developers that 
> the small advantages of ABI compatibility are not worth the costs.

I don't know. As linux spreads, things should be simply changing. 
Carefulness, API stability and of course ABI helps in that sense. Kernel 
by itself is just useless. A kernel with other layers is an os. The core 
of an OS should have special care.

If IDE driver is completely rewritten breaking my ability to use all the 
other modules, it's a shame... nothing I had made (modules) will work, 
and I know. If cdrecord is completely rewritten, I don't care, as long 
as it works.

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enig760342C8E89769EA4DE67E40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXqr84LBKhYmYotsRAlqiAJsG8lJ4vHUc2Vpwf+Y+SwmnsDXUlwCbBnVd
r+OECtNPRmWIMQE2UzWt2vg=
=GTGG
-----END PGP SIGNATURE-----

--------------enig760342C8E89769EA4DE67E40--

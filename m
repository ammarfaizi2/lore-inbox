Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVDLRad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVDLRad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVDLR3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 13:29:30 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:54759 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S262500AbVDLR1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:27:18 -0400
Message-ID: <425C03D6.2070107@tin.it>
Date: Tue, 12 Apr 2005 12:22:30 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de>	<425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de>	<425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain>
In-Reply-To: <m3mzs4kzdp.fsf@defiant.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8CB8D3FF0ED9F95EC9AD2D16"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8CB8D3FF0ED9F95EC9AD2D16
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Krzysztof Halasa wrote:
> It isn't enough. The same compiler and the same .config - yes. But that
> means you'd have no progress within, say, 2.6. Only bug fixes.
> There _is_ a tree like that - 2.6.11.Xs are only bugfixes.

Ok, this adds a new information. Let me explain what I understand now.

When a new component is added to the kernel, let's say support for a new 
file system, a .config entry is created (CONFIG_MYFS=y|m). Why is this 
entry breaking compatibility? I mean, symbols still remains the same. 
The addition of symbols is not a breaking point.

> But remember that changing a single config option may make your kernel
> incompatible. You can't avoid that without making the kernel suboptimal
> for most situations - basically you'd have to disable non-SMP builds,
> disable (or permanently enable) 4KB pages etc.

What about making extensive use of modules? If everything (acceptable) 
is built on modules, can you still have abi, can you still change 
modules and api implementation without breaking anything? What are the 
requisites to abi?

I'm really curious about it. How abi can be made actual, and how would 
it be if we had a completely modular kernel (not micro, but something 
alike, modular in kernel-space, not in user-space).

> If you make a proprietary closed-sourse system (with kernel modules), you
> probably have to make the system suboptimal. But with open source there
> is a better alternative.

No, I wouldn't. Closed source is out of discussion. Optimal kernel, even 
in open source can be achieved.

> Asking for one modules dir only is similar to asking for only one
> /boot/vmlinuz-2.6 kernel file.

Quite the same, yes. You can still have different kernels of course! By 
the way, another stupid curiosity is why /lib/modules instead of /boot? 
Because boot can be a partition and not be mounted? The same thing for 
/lib (crazy, but you can do it). I would expect a kernel and all its 
parts all in one place, not different locations...

> First, each 2.6.X would have to be binary-compatible with itself.

That's the only point for me. I wouldn't make 2.6 and 2.8 kernels binary 
compatibles.

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enig8CB8D3FF0ED9F95EC9AD2D16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXAPa4LBKhYmYotsRApA5AKCVJyY8ZCmKLNzZxnkJ6J1osbVirQCgoW3n
EY2MjN21VMRoBlL5BDW90Dg=
=rqB+
-----END PGP SIGNATURE-----

--------------enig8CB8D3FF0ED9F95EC9AD2D16--

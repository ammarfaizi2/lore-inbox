Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261890AbSI3A6a>; Sun, 29 Sep 2002 20:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261919AbSI3A63>; Sun, 29 Sep 2002 20:58:29 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:32725
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261918AbSI3A6X>; Sun, 29 Sep 2002 20:58:23 -0400
Message-ID: <3D97A2F0.2030002@redhat.com>
Date: Sun, 29 Sep 2002 18:03:44 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cwhmlist@bellsouth.net
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 oops
References: <20020930005203.GUNU26495.imf20bis.bellsouth.net@localhost>
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

cwhmlist@bellsouth.net wrote:
> I am having a 2.5.39 oops on boot up.  Here is what I have been able to gleen from the bootstrap screen:
> 
> printing eip:
> c0218f17
> *pde = 00000000
> Oops: 0002
> 
> CPU: 1
> EIP: 0060:[<c0218f17>] Not tainted
> EFLAGS: 00010282
> EIP is at attach+0x63/0xb8
> eax: c13a409c ebx: c03e4650 ecx: 00000000 edx: c03f0b68
> esi: c13a4084 edi: c03e4650 ebp: 00000000 esp: c13dff84
> ds: 0068 es: 0068 ss 0068
> Process swapper (pid: 1, threadinfo=c13de000 task=c13e0080)
> Stack: 00000000 c13a408c c0219027 c13a4084 c13a4084 c02193ab c13a4084 c13a4084
>        c128aa4c c03f09c0 c128aa0c 00000001 c0416cb0 c13a4084 c04234e0 00000000
>        00000000 00000000 c128aa4c 00000000 c0402866 c13de000 c040288c c0105101
> Call Trace:
>  [<c0219027>device_attach+0x33/0x3c
>  [<c02193ab>device_register+0x173/0x260
>  [<c0105101>init+0x75/0x214
>  [<c010508c>init+0x0/0x214
>  [<c01055a1>kernel_thread_helper+ox5/0xc
> 
> Code: 89 01 81 3d 54 46 3e c0 ad de 74 0b 0f 0b 4a 00 a0 50

This has to do with isapnp.  I have the same problem with isapnp
compiled in.  In my case the kernel just detected the sound chip on the
motherboard.  Not compiling isapnp makes the oops disappear.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9l6Lw2ijCOnn/RHQRAvFdAJ0ddM+2ozcQiFPLx+5J9J/9+qkIFACfW4Mf
RWA4yBXOf6znqgq9nUeryOk=
=OocT
-----END PGP SIGNATURE-----


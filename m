Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbSJRI0A>; Fri, 18 Oct 2002 04:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265060AbSJRI0A>; Fri, 18 Oct 2002 04:26:00 -0400
Received: from mithra.wirex.com ([65.102.14.2]:3338 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S265058AbSJRIZ6>;
	Fri, 18 Oct 2002 04:25:58 -0400
Message-ID: <3DAFC6E7.9000302@wirex.com>
Date: Fri, 18 Oct 2002 01:31:35 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, greg@kroah.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
References: <20021017201030.GA384@kroah.com>	<20021017211223.A8095@infradead.org>	<3DAFB260.5000206@wirex.com> <20021018.000738.05626464.davem@redhat.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enigE5DA74FC7419581687B3DC38"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE5DA74FC7419581687B3DC38
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:

>Anything which passes a completely opaque value through a system
>call is a sign of trouble, design wise.
>
That's interesting. Passing a completely opaque value (actually an 
integer) through the system call was exactly what we designed it to do, 
because we saw a design need for pecisely that: so that applications 
with awareness of a specific module can talk to the module.

Could you elaborate on why this is a sign of trouble, design wise?

>There is simply no way we can enfore proper portable typing by
>all these security module authors such that we can do any kind
>of proper 32-bit/64-bit syscall translation on the ports that
>need to do this.
>
THAT I would love to hear about. If all we have to do to save 
sys_security is change its signature, that'd be great.

>If we do things such as the fs stacking or fs filter ideas,
>that eliminates a whole swath of the facilities the security_ops
>"provide".  No ugly syscalls passing opaque types through the kernel
>to some magic module, but rather a real facility that is useful
>to many things other than LSM.
>
Yes, that will be wonderful. And the LSM team will be pleased to re-work 
the desing when stackable file systems appear and we can take advantage 
of them.

Crispin


--------------enigE5DA74FC7419581687B3DC38
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9r8bo5ZkfjX2CNDARAUbhAJ9AF/j5AfE1C0jyvZ3VXF0f/xey8wCgpYp8
oYE696LCdKVsgvBPyMDbRrQ=
=ciE8
-----END PGP SIGNATURE-----

--------------enigE5DA74FC7419581687B3DC38--


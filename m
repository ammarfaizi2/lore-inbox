Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbTBKJWd>; Tue, 11 Feb 2003 04:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbTBKJWc>; Tue, 11 Feb 2003 04:22:32 -0500
Received: from desnol.ru ([217.150.58.11]:40457 "EHLO desnol.ru")
	by vger.kernel.org with ESMTP id <S267332AbTBKJW3>;
	Tue, 11 Feb 2003 04:22:29 -0500
Date: Tue, 11 Feb 2003 12:33:57 +0300
From: =?ISO-8859-1?Q?=F7=C9=D4=C1=CC=C9=CA?= <manushkinvv@desnol.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: allocate more than 2 GB on IA32
Message-Id: <20030211123357.54f9de94.manushkinvv@desnol.ru>
In-Reply-To: <200302111015.54223.manz@intes.de>
References: <200302111015.54223.manz@intes.de>
Organization: =?ISO-8859-1?Q?=E4=C5=D3=CE=CF=CC?=
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.9; )
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.ESdQwWr)Q/1(M_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.ESdQwWr)Q/1(M_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> I tought it should be possible to allocate up to 2.9 GB of memory to a
> process, with this kernel settings.
Obviously, No.
Unfortunatly kernel do not use segments (fully). So even you have HIMEM at the kernel it's not possible to user program to address more than 4 gb a ram at the same time. And as far as i know program can not have more than 1 gm of usable readwrite memory.

THe only way for u is to use 64 bit architecture... or remap default address range splitting increase address range for pgrogram data (it's require to recompile all programs).

Agri

On Tue, 11 Feb 2003 10:15:54 +0100
Hartmut Manz <manz@intes.de> wrote:

> Hello,
> 
> i would like to allocate more than 2 GB of memory on an IA32 architecture.
> 
> The machine is a dual XEON_DP with 3 GB of Ram and 4 GB of swap space.
> 
> I have tried with the default SUSE 8.1 kernel as well as with a
> 2.4.20-pre4aa1 Kernel compile by my own using these Options:
> 
> CONFIG_HIGHMEM4G=y
> CONFIG_HIGHMEM=y
> CONFIG_1GB=y
> 
> but I am only able to allocate 2 GB with a single malloc call.
> I tought it should be possible to allocate up to 2.9 GB of memory to a
> process, with this kernel settings.
> 
> Thank You for any help
> 
> Hartmut Manz
> 
> -- 
> -----------------------------------------------------------------------------
> Hartmut Manz                                      WWW:    http://www.intes.de
> INTES GmbH                                        Phone:  +49-711-78499-29
> Schulze-Delitzsch-Str. 16                         Fax:    +49-711-78499-10
> D-70565 Stuttgart                                 E-mail: manz@intes.de
>    Ein Mensch sieht, was vor Augen ist; der Herr aber sieht das Herz an.
> ------------------------------------------------------- 1. Samuel 16, 7 -----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


--=.ESdQwWr)Q/1(M_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+SMOIXLqYWeM+eNsRAkU8AJ0fsbBfOHnYE1+DOCXEsnNXi38eQACeLXCG
fxt354Mq+DNP6pbzkjEHbWs=
=YDTC
-----END PGP SIGNATURE-----

--=.ESdQwWr)Q/1(M_--

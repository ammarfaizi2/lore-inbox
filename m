Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263616AbUFDJDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUFDJDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUFDJDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:03:10 -0400
Received: from vhost-13-248.vhosts.internet1.de ([62.146.13.248]:19666 "EHLO
	spotnic.de") by vger.kernel.org with ESMTP id S263616AbUFDJDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:03:03 -0400
In-Reply-To: <200406041000.41147.cijoml@volny.cz>
References: <200406041000.41147.cijoml@volny.cz>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2-658394093"
Message-Id: <F84CE3DA-B605-11D8-B781-000A958E35DC@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Daniel Egger <de@axiros.com>
Subject: Re: jff2 filesystem in vanilla
Date: Fri, 4 Jun 2004 11:02:56 +0200
To: cijoml@volny.cz
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-2-658394093
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 04.06.2004, at 10:00, Michal Semler wrote:

> I use my flash disk only in linux environment. So I would like use 
> jffs2
> filesystem on it. Is it possible ? It works like a charm on my 
> linux-enabled
> iPAQ.
> I have 2.4.26 and 2.6.6 kernel vanillas running on i386 architectures.

> Any patch exits ? And is including of this filesystem expected?

JFFS2 is included in the standard kernels IIRC, however I'd recommend
using the CVS version from the official repository as there are huge
improvements in there.

To use it on a non-MTD[1] device you will need an emulation layer,
the pseudo Block-MTD device. And you will need some additional partition
using ext2/ext3/reiserfs/FAT containing the kernel for your Grub/LILO
bootloader.

[1] Memory technology devices, e.g. flash chips soldered on some board
     with direct access

Servus,
       Daniel

--Apple-Mail-2-658394093
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQMA6wDBkNMiD99JrAQL4DQf+IGxAzjsiFsEbxYAIMSN/dAMyCfo+7VAU
1hlem/NkQYbZjOad1NTeTGbJS1qIgKvHzgk3Bk12LpQCTn+LOqkxv78Kv26kSPcn
hCrkhEk9P80gO3pAm86wcuqtwGLoS2vAhy7DlfMYgbEdDnxvvFRnObn06GhFZqEZ
k8Qz9RauuZV0GGjspUGi8ZHzUSkEiSv4WYVhnw1mfjd36O1Cl4rGdo7zR3FJTK5+
5PTKEe7HobDQhjA8FdWlCyFaqf39ZsA5uJn25PnCo2i0pxXyysbu69BZUA6R1OzA
Vbvd+MK5cSNgjI3hy6ItLtyFg+BZlzqmdp2yJSe7SIjzzyD+l1mWgg==
=at+B
-----END PGP SIGNATURE-----

--Apple-Mail-2-658394093--


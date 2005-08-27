Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbVH0MXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbVH0MXa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 08:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVH0MXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 08:23:30 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:16361 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1030370AbVH0MX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 08:23:29 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] acpi: Handle cpu_index greater than 256 properly in processor_core.c
Date: Sat, 27 Aug 2005 14:22:40 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>
References: <20050826170701.A27226@unix-os.sc.intel.com>
In-Reply-To: <20050826170701.A27226@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15417046.6c03UQoGFE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508271422.46473.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart15417046.6c03UQoGFE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Venkatesh,

On Saturday 27 August 2005 02:07, Venkatesh Pallipadi wrote:
> Fix convert_acpiid_to_cpu function to handle cpu_index greater than 256. =
This=20
> patch also prevents a warning in IA64 cross-compile of this file=20
> (drivers/acpi/processor_core.c:517: warning: comparison is always false d=
ue=20
> to limited range of data type).

Why don't you just change the datatype to "unsigned int" and=20
the return failure value to NR_CPUS?

That reduces the code changes and leaves the code quite clear.
It should also reduce compiled code size by some bytes, but I'm not
sure about that one.


Regards

Ingo Oeser


--nextPart15417046.6c03UQoGFE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDEFsWU56oYWuOrkARAhzhAJwIJ3zrGkyDbfVoAMxdNV184h2AQgCgjDRR
gOB3sHPwHJ3vpG2VBaIfe04=
=e8E/
-----END PGP SIGNATURE-----

--nextPart15417046.6c03UQoGFE--

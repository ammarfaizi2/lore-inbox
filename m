Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRASFQN>; Fri, 19 Jan 2001 00:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129375AbRASFQD>; Fri, 19 Jan 2001 00:16:03 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:26301 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129441AbRASFPw>; Fri, 19 Jan 2001 00:15:52 -0500
Message-ID: <004701c081ef$e32dcb90$8501a8c0@gromit>
From: "Michael Rothwell" <rothwell@holly-springs.nc.us>
To: "Mo McKinlay" <mmckinlay@gnu.org>, "Peter Samuelson" <peter@cadcamlab.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0101182129050.1089-100000@nvws005.nv.london>
Subject: Re: named streams, extended attributes, and posix
Date: Fri, 19 Jan 2001 00:14:12 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, unix allows everything but "/" in filenames. This was
probably a mistake, as it makes it nearly impossible to augment the
namespace, but it is the reality.

Did you read the "new namespace" section of the paper?

It also talked a bit about supporting Extended Attributes, which are access
via an API and not with a filename separator. We could, perhaps, begin by
supporting EAs. That would take care of HFS, HPFS, XFS, and BeFS, and half
of NTFS. Then we could go on to tackle the Named Streams problem.

-M

----- Original Message -----
From: "Mo McKinlay" <mmckinlay@gnu.org>
To: "Peter Samuelson" <peter@cadcamlab.org>
Cc: "Mo McKinlay" <mmckinlay@gnu.org>; <linux-kernel@vger.kernel.org>
Sent: Thursday, January 18, 2001 1:30 PM
Subject: Re: named streams, extended attributes, and posix


> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Yesterday, Peter Samuelson (peter@cadcamlab.org) wrote:
>
>   > Yeah, I agree, 'file/stream' is lousy syntax as well.  If it weren't
>   > for the possibility of having streams on directories, it would almost
>   > be acceptible.  I still don't know which (':' or '/') is the worse
>   > hack.
>
> Me neither :/
>
>   > As I've said elsewhere in this thread, I can't think of *any* clean
way
>   > to shoehorn forks into nice, transparent posix calls.  It really wants
>   > a new API.
>
> Likewise. This was my standpoint the last time around - a clear concise
> portable API for accessing streams (even if it *started out*
> Linux-specific) - without imposing silly semantics on existing
> applications which currently ignore streams anyway.
>
> Mo.
>
> - --
> Mo McKinlay
> mmckinlay@gnu.org
> - ------------------------------------------------------------------------
-
> GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22
>
>
>
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.4 (GNU/Linux)
> Comment: For info see http://www.gnupg.org
>
> iEYEARECAAYFAjpnYGQACgkQRcGgB3aidfmWBQCfXgNq/vqltt76mApoDiNI9HnH
> ws8AoJZ2vvlH1iCAeUu7yktWWN0Bncc3
> =gEmD
> -----END PGP SIGNATURE-----
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

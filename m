Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281716AbRKULQb>; Wed, 21 Nov 2001 06:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281718AbRKULQW>; Wed, 21 Nov 2001 06:16:22 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:45113 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281716AbRKULQQ>; Wed, 21 Nov 2001 06:16:16 -0500
Date: Wed, 21 Nov 2001 11:16:15 +0000
From: Tim Waugh <twaugh@redhat.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Message-ID: <20011121111615.K24766@redhat.com>
In-Reply-To: <01112112401703.01961@nemo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="R8vV2+AjVNGd/4x/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01112112401703.01961@nemo>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Nov 21, 2001 at 12:40:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R8vV2+AjVNGd/4x/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2001 at 12:40:17PM +0000, vda wrote:

> drivers/block/paride/pf.c:      if (l==0x20) j--; targ[j]=0;
> drivers/block/paride/pg.c:      if (l==0x20) j--; targ[j]=0;
> drivers/block/paride/pt.c:      if (l==0x20) j--; targ[j]=0;
>     (these files need Lindenting too)
> ----------
> Missing {}
> Either a bug or a very bad style (so bad that I can even imagine
> that it is NOT a bug). Please double check before applying the patch!

This seems to be just bad indentation rather than a bug. 'targ[j]=0'
seems to have the purpose of zero-terminating the string, if you look
at the callers of those functions. (But yes, the code is extremely
hard to read, and I can't convince myself either way about whether the
|| two lines earlier should or shouldn't be an &&.)

Tim.
*/

--R8vV2+AjVNGd/4x/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7+4z+yaXy9qA00+cRAmCuAJ9IkLsbtSQcgEDuVAJvTpdgMNLRjQCeINaM
CQQKEcxY3yHdyZb3fx0d40M=
=+LrR
-----END PGP SIGNATURE-----

--R8vV2+AjVNGd/4x/--

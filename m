Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbULLX2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbULLX2s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 18:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbULLX2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 18:28:48 -0500
Received: from mollusk.mweb.co.za ([196.2.24.27]:27484 "EHLO
	mollusk.mweb.co.za") by vger.kernel.org with ESMTP id S262172AbULLX2p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 18:28:45 -0500
From: Bongani Hlope <bhlope@mweb.co.za>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: how to detect a 32 bit process on 64 bit kernel
Date: Mon, 13 Dec 2004 01:30:45 +0200
User-Agent: KMail/1.7.1
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20040901072245.GF13749@mellanox.co.il> <20041212215110.GA11451@mellanox.co.il> <20041212223740.GF17946@alpha.home.local>
In-Reply-To: <20041212223740.GF17946@alpha.home.local>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10818342.iEt6YSjzlx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412130130.51647.bhlope@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10818342.iEt6YSjzlx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 13 December 2004 00:37, Willy Tarreau wrote:
> On Sun, Dec 12, 2004 at 11:51:10PM +0200, Michael S. Tsirkin wrote:
> > Hello!
> > Is there a reliable way e.g. on x86-64 (or ia64, or any other
> > 64-bit system), from the char device driver,
> > to find out that I am running an operation in the context of a 32-bit
> > task?
>
> aren't there informations in /proc/$$/maps or other things which will
> change their format or contents in 32 or 64 bits addressing, which would
> help you detect the mode you're currently running ?
>

ugly bash script

ps -A | file `awk '{print "file /proc/"$1"/exe"}'` | grep "symbolic link to=
" |=20
sed s%\`%% | sed s%\'%% | awk '{print "file "$5}' | sh | grep 32

--nextPart10818342.iEt6YSjzlx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBvNSr+pvEqv8+FEMRAgEyAJwKnSA52pZfy8zl+WdN+c7mIwbUQgCgjAqs
1MqZUTE9mgNgKN8wSdaP9d4=
=+KL/
-----END PGP SIGNATURE-----

--nextPart10818342.iEt6YSjzlx--

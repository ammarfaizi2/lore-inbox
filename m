Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288987AbSAIT5y>; Wed, 9 Jan 2002 14:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288994AbSAIT5k>; Wed, 9 Jan 2002 14:57:40 -0500
Received: from [213.171.51.190] ([213.171.51.190]:1420 "EHLO ns.yauza.ru")
	by vger.kernel.org with ESMTP id <S288985AbSAITz1>;
	Wed, 9 Jan 2002 14:55:27 -0500
Date: Wed, 9 Jan 2002 22:55:17 +0300
From: Nikita Gergel <fc@yauza.ru>
To: linux-kernel@vger.kernel.org
Cc: Brendan Burns <bburns@genet.cs.umass.edu>
Subject: Re: MINOR(inode->i_rdev) vs. minor(inode->i_rdev)
Message-Id: <20020109225517.182c8e24.fc@yauza.ru>
In-Reply-To: <1010604024.2904.0.camel@epiphany>
In-Reply-To: <1010604024.2904.0.camel@epiphany>
Organization: YAUZA-Telecom
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-alt-linux)
X-Face: /kH/`k:.@|9\`-o$p/YBn<xFr)I]mglEQW0$I${i4Q;J|JXWbc}de_p8c1;:W~5{WV,.l%B S|A4'A1hnId[
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha1; boundary="=.jmsM,88Of)Y?_Y"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.jmsM,88Of)Y?_Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 09 Jan 2002 14:20:23 -0500
Brendan Burns <bburns@eksl.cs.umass.edu> wrote:

> Hello,
Hello!

> In the process of compiling ALSA for my new 2.5.2pre10 kernel I noticed
> that MINOR(inode->i_rdev) causes compile errors and should be replaced
> with minor(inode->i_rdev) Looking at a number of the OSS sound drivers
> in the kernel I noticed that they to would not compile in 2.5.2pre10 (eg
> Turtle Beach Pinnacle)  I fixed all of these modules and a patch is
> attached.  However, looking further I noticed that there were similar
> problems in a number of other drivers.  Before I undertook cleaning all
> of them I thought I would check in and make sure I was doing the right
> thing.  Namely that every instance of MINOR(inode->i_rdev) or
> MINOR(i_rdev) should be replaced with minor(inode->i_rdev) or
> minor(i_rdev).

I've contributed patch for emu10k1, because tests after 'MINOR' replacement successed. You're on the right way.

Regards.

-- 
Nikita Gergel					System Administrator
Moscow, Russia					YAUZA-Telecom

--=.jmsM,88Of)Y?_Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8PKAnFP8BYTTFfXkRAowLAKCs9cOXROjKRpyD3Q0hN26y5wgFpwCfYDlk
SBfaUEyQnG8RZ2vlbAlqzwY=
=/xEn
-----END PGP SIGNATURE-----

--=.jmsM,88Of)Y?_Y--


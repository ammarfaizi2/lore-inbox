Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275098AbRJYPwU>; Thu, 25 Oct 2001 11:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275126AbRJYPwK>; Thu, 25 Oct 2001 11:52:10 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:36578 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S275098AbRJYPvv>; Thu, 25 Oct 2001 11:51:51 -0400
Date: Thu, 25 Oct 2001 16:52:26 +0100
From: Tim Waugh <twaugh@redhat.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.12 / linux-2.4.13 parallel port problem
Message-ID: <20011025165226.T7544@redhat.com>
In-Reply-To: <20011024230917.H7544@redhat.com> <ioWB7.5038$rR5.921319585@newssvr17.news.prodigy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Lfdj09rG01n7l08B"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <ioWB7.5038$rR5.921319585@newssvr17.news.prodigy.com>; from davidsen@tmr.com on Thu, Oct 25, 2001 at 03:41:02PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Lfdj09rG01n7l08B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 25, 2001 at 03:41:02PM +0000, bill davidsen wrote:

> Thank you... that sure doesn't jump out at someone, it generates no
> error message, etc.

See
<ftp://people.redhat.com/twaugh/patches/linux24/linux-ignore.patch>.

> Question: is this intended behaviour? I would think that you would
> normally want to just say irq=auto and let the driver find the io
> address just as it does normally.

It is intended behaviour.  'irq=auto' in this case didn't help because
the ECP chipset would not tell us what IRQ it was assigned (it just
said "it's set by jumpers, or alternatively I'm not telling you".

The problem with just specifying 'irq=7' on its own is that in the
case of there being more than one port it isn't clear what it should
mean.

When there is only one port to consider, it would make sense to use
that IRQ, but by the time we know how many ports there are we've
already decided not to use the supplied parameter.  Patches
welcome. :-)

Tim.
*/

--Lfdj09rG01n7l08B
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE72DU5yaXy9qA00+cRAnUyAJ48mR/aggtT3YyCu37jP8xrrjQP5ACffFPG
mdorihk3SzIwqITRMrMDnV8=
=hnw+
-----END PGP SIGNATURE-----

--Lfdj09rG01n7l08B--

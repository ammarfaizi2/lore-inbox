Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131544AbRCUOxl>; Wed, 21 Mar 2001 09:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131546AbRCUOxc>; Wed, 21 Mar 2001 09:53:32 -0500
Received: from t2.redhat.com ([199.183.24.243]:7932 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S131544AbRCUOxU>; Wed, 21 Mar 2001 09:53:20 -0500
Date: Wed, 21 Mar 2001 14:49:07 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Will Newton <will@misconception.org.uk>,
        Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org
Subject: Re: VIA audio and parport in 2.4.2
Message-ID: <20010321144907.D1323@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0103211333440.1541-100000@dogfox.localdomain> <3AB8B877.D36E8719@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AB8B877.D36E8719@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Mar 21, 2001 at 09:19:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2001 at 09:19:35AM -0500, Jeff Garzik wrote:

> Attempting to pretend that the parallel port is not in an interrupt
> driven mode by passing irq=none is folly.

No, that's not what it's for.  It means 'for Christ sake don't use
interrupts, I know what I'm doing'.

> If irq=none is passed to tell the Via code to -force- the parallel
> port into a non-irq-driven mode is one thing.  If irq=none is passed
> to hide a problem with spurious interrupts, we need to fix that
> problem, not hide it.

irq=none is passed in order to diagnose whether a problem happens on
only the interrupt-driven path or not.  Read the trouble-shooting
section parport.txt.  Understand that there are lots of printing code
paths nowadays (polling, interrupt-driven, PIO, DMA, etc).

> I still am not convinced that irq=<anything> should affect the Via
> code at all.  Maybe I can print out a message "irq=foo ignored".

Jeff, it needs to.  If you want to make irq=auto the default
(currently it's 'probe only'), then that is an entirely different
thing.

When the user tells you not to use interrupts, you'd better not.

> Optionally, I could handle irq=none by force-disabling the parallel
> port's interrupt driven modes, if they are active.

What the hell for?  Just don't use the interrupts.

Tim.
*/

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6uL9iONXnILZ4yVIRAlBVAKCVhPHYiPcZL95d1GWUlanCcTkDwwCdGSbl
Q1FmhNfIdboogHFfWoZAMLY=
=fjZu
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--

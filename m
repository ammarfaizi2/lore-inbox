Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269763AbUJGMc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269763AbUJGMc6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269714AbUJGMbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:31:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36075 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263795AbUJGM2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:28:37 -0400
Date: Thu, 7 Oct 2004 14:28:15 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Probable module bug in linux-2.6.5-1.358
Message-ID: <20041007122815.GC23612@devserv.devel.redhat.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com> <1097143144.2789.19.camel@laptop.fenrus.com> <Pine.LNX.4.61.0410070753060.9988@chaos.analogic.com> <20041007121741.GB23612@devserv.devel.redhat.com> <Pine.LNX.4.61.0410070823300.10118@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410070823300.10118@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 07, 2004 at 08:26:22AM -0400, Richard B. Johnson wrote:
> On Thu, 7 Oct 2004, Arjan van de Ven wrote:
> 
> >On Thu, Oct 07, 2004 at 08:01:47AM -0400, Richard B. Johnson wrote:
> >>Also, when this driver is running, transferring large volumes
> >>of data, the kernel decides that there have been too many interrupts, and
> >>does:
> >>
> >>Message from syslogd@chaos at Wed Oct  6 21:22:57 2004 ...
> >>chaos kernel: Disabling IRQ #18
> >>
> >>This, in spite of the fact that interrupts occur only when
> >>DMA completion happens and new data are available, i.e.,
> >>one interrupt every 16 megabytes of data transferred.
> >>
> >>Who decided that it had a right to disable my interrupt????
> >
> >the kernel did because you don't return the proper value for "I handled the
> >IRQ" from your ISR.
> 
> Do you know what that value is? I can't find it. I just returned 0
> and it worked for awhile.

IRQ_HANDLED is you handled the irq, IRQ_NONE if you didn't


> The kernel calls cleanup_module() and the printk() shows that it
> was truly called.

I fail to find where you declare module_exit() in your sources

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBZTZexULwo51rQBIRAlHQAJwLm9fEvk0f2Gb5hrzDM1iUUn+0lgCgqJeu
nmF/dwsXHlDeafAll3KNoAc=
=P0L6
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUB2IhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 03:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbUB2IhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 03:37:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32180 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262014AbUB2IhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 03:37:12 -0500
Date: Sun, 29 Feb 2004 09:36:57 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Michael Frank <mhf@linuxmail.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>, mgross@linux.co.intel.com,
       tim.bird@am.sony.com, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
Message-ID: <20040229083656.GB7264@devserv.devel.redhat.com>
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com> <20040226190259.7965cc76.rddunlap@osdl.org> <opr34h04mx4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <opr34h04mx4evsfm@smtp.pacific.net.th>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 29, 2004 at 04:32:54PM +0800, Michael Frank wrote:
> 
> Most interrupt controllers can read back IRQ's to see whether it is
> active. A shared IRQ would be readback active while any device
> connected to it desires service.
> 
> x86 example for 8259A AT-PIC's Returns the state of IRQ0-15 in ax
> Note that jmp $+2 is only needed on some old 286/386 hardware
> to meet (real) 8259A cycle time requirements.
> 
> - Intel syntax :)
> 
> 	mov	al,0ah
> 	out	0a0h,al
> 	jmp	$+2
> 	in	al,0a0h
> 	mov	ah,al
> 	mov 	al,0ah
> 	jmp	$+2
> 	out 	20h,al
> 	jmp	$+2
> 	in 	al,20h

interesting; however with modern cpus I suspect that a series of in/outs
like that is more expensive than one or two "surious" hardirq handler
calls...


--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAQaSoxULwo51rQBIRAqrVAJ91rt4pIJGF/i57EVG0B2q90L+2fwCgjrEZ
4646RzUMtKXg3oHhbew6rig=
=S8tc
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--

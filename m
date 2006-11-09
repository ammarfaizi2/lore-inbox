Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754731AbWKIEue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbWKIEue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 23:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbWKIEue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 23:50:34 -0500
Received: from pool-72-66-197-94.ronkva.east.verizon.net ([72.66.197.94]:48067
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1754731AbWKIEue (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 23:50:34 -0500
Message-Id: <200611090449.kA94nqsZ007282@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Corey Minyard <minyard@acm.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi_si_intf.c: fix "&& 0xff" typos
In-Reply-To: Your message of "Wed, 08 Nov 2006 16:15:46 CST."
             <45525712.8020103@acm.org>
From: Valdis.Kletnieks@vt.edu
References: <20061108220925.GB4972@martell.zuzino.mipt.ru>
            <45525712.8020103@acm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1163047780_5988P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 23:49:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1163047780_5988P
Content-Type: text/plain; charset=us-ascii

On Wed, 08 Nov 2006 16:15:46 CST, Corey Minyard said:
> Ouch, I guess we've never had a system with these address types.  Thanks.

If we never had a system with these address types..

> >  static unsigned char intf_mem_inw(struct si_sm_io *io, unsigned int offset)
> >  {
> >  	return (readw((io->addr)+(offset * io->regspacing)) >> io->regshift)
> > -		&& 0xff;
> > +		& 0xff;
> >  }

Is this dead code that isn't called by anybody?

--==_Exmh_1163047780_5988P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFUrNkcC3lWbTT17ARAt1aAJ9apLuZ7I8kMcg//4uqEmG5IADk4QCglHBl
uscBzF5+xXNZxvuabRNkI3g=
=tVkZ
-----END PGP SIGNATURE-----

--==_Exmh_1163047780_5988P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUHVPIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUHVPIW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUHVPIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:08:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2776 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267388AbUHVPH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:07:59 -0400
Date: Sun, 22 Aug 2004 17:07:47 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Ville Herva <vherva@viasys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-ID: <20040822150747.GB13131@devserv.devel.redhat.com>
References: <20040820035142.3bcdb1cb.akpm@osdl.org> <20040820131825.GI23741@viasys.com> <20040820144304.GF8307@viasys.com> <20040820151621.GJ23741@viasys.com> <20040820114518.49a65b69.akpm@osdl.org> <20040821062927.GM23741@viasys.com> <20040821134918.GA1585@devserv.devel.redhat.com> <20040821190027.GQ3024@viasys.com> <20040821190730.GA25932@devserv.devel.redhat.com> <20040822143112.GB24092@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20040822143112.GB24092@vana.vc.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 22, 2004 at 04:31:12PM +0200, Petr Vandrovec wrote:
> Whole situation (with originally released vmmon) looked like that vmware binary
> issued ioctl() to allocate memory, marked that page PG_RESERVED, and returned
> physical page number to userspace. Userspace then opened /dev/mem, and mapped
> that page to the process.  On cleanup /dev/mem was unmapped, PG_RESERVED bit
> was cleared, and page released (in my updates PG_RESERVED setting/clearing is
> removed, as it badly intereferes with page's refcounting).

I've sent andrew a patch that allows such mmaps again for PG_RESERVED pages.
The approach vmware did is rather questionable (as you say) and thankfully
fixed later, but breaking it is not entirely required.
--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBKLbDxULwo51rQBIRAgdVAKChC6mVrzvzpPcXZhMkuGJXR3OkGgCeLKb3
agfDz1PEg9gO5qk1OKvHdfY=
=mXSv
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--

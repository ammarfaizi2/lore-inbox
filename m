Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUGTFZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUGTFZk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 01:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUGTFZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 01:25:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:1677 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263448AbUGTFZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 01:25:38 -0400
Date: Sun, 18 Jul 2004 18:13:38 +0200
From: Kurt Garloff <garloff@suse.de>
To: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040718161338.GC12527@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	linux-kernel@vger.kernel.org,
	William Lee Irwin III <wli@holomorphy.com>,
	Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
	andrea@suse.de
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home> <20040714154427.14234822.akpm@osdl.org> <1089851451.15336.3962.camel@abyss.home> <20040715015431.GF3411@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <20040715015431.GF3411@holomorphy.com>
X-Operating-System: Linux 2.6.5-19-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 14, 2004 at 06:54:31PM -0700, William Lee Irwin III wrote:
> On Wed, Jul 14, 2004 at 05:30:52PM -0700, Peter Zaitsev wrote:
> > Why can't it be moved to other zone if there is a lot of place where ?
> > In general I was not pushing system in some kind of stress mode - There
> > was still a lot of cache memory available. Why it could not be instead
> > shrunk to accommodate allocation ?=20
>=20
> The only method the kernel now has to relocate userspace memory is IO.

But that could be changed.
If we can swap out and modify the page tables (to mark the page paged
out) and page in to some other location (and modify the pagetables
again), we can as well just copy a page and modify the page tables.

Any fundamental reason why that should not be possible?=20

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG / Novell, Nuernberg, DE               Director SUSE Labs

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+qGyxmLh6hyYd04RAt4EAKCtwZhy+p6khCpnHi/kUrxvTl8rVQCggrWF
cNNWS+qyLAuIuxO61NpwBSg=
=M7nV
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--

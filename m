Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269023AbUI2Ui3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269023AbUI2Ui3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269026AbUI2Ug4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:36:56 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:19328 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S269045AbUI2Uf5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:35:57 -0400
Date: Wed, 29 Sep 2004 22:33:47 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, dsaxena@plexity.net,
       linux-kernel@vger.kernel.org, herbertb@cs.vu.nl
Subject: Re: strange NFS problems (ARM client, x86 server)
Message-ID: <20040929203347.GD21770@thundrix.ch>
References: <20040929082307.GA19666@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <20040929082307.GA19666@xi.wantstofly.org>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Wed, Sep 29, 2004 at 10:23:07AM +0200, Lennert Buytenhek wrote:
> chdir("")                               = -1 ENOENT (No such file or directory)

Interestingly,  rpm requested an  empty chdir.  This narrows  down the
problem.

The following miniapp should be able to reproduce the problem:

cat << EOT > blah.c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
	if (chdir("")) {
		perror("chdir");
		exit(1);
	}
	exit(0);
}
EOT

Does it?

			    Tonnerre

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBWxwq/4bL7ovhw40RAqWFAKCsJSYbs4XFp1GbY57AXy/WUZsSzACghmi1
ceK1So6t8FnY+3QEFO2eRvo=
=lym0
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--

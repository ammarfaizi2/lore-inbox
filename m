Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVGFUXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVGFUXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVGFUUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:20:21 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:27566 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S262288AbVGFUNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:13:08 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] add securityfs for all LSMs to use
Date: Wed, 6 Jul 2005 22:12:59 +0200
User-Agent: KMail/1.7.2
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
References: <20050706081725.GA15544@kroah.com>
In-Reply-To: <20050706081725.GA15544@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1339000.2MjMhP4ciA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507062213.05337.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1339000.2MjMhP4ciA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Greg,

On Wednesday 06 July 2005 10:17, Greg KH wrote:
> + * TODO:
> + *   I think I can get rid of these default_file_ops, but not quite sure=
=2E..
> + */
> +static ssize_t default_read_file(struct file *file, char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	return 0;
> +}
> +
> +static ssize_t default_write_file(struct file *file, const char __user *=
buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	return count;
> +}

Yes, you can get rid of both, if you move read_null and write_null from=20
drivers/char/mem.c to fs/libfs.c and export them.

But for what do you need a successful dummy read/write?


Regards

Ingo Oeser


--nextPart1339000.2MjMhP4ciA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCzDtRU56oYWuOrkARAuEnAJ4/udnTIGSb3wZBjnu7cNAtgBesSgCgqtUv
4aM+IAVGGU1ctCEReD5Lsvo=
=e4oy
-----END PGP SIGNATURE-----

--nextPart1339000.2MjMhP4ciA--

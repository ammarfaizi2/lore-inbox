Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbUKCINK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUKCINK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 03:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUKCINK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 03:13:10 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:10644 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261455AbUKCIMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 03:12:49 -0500
Message-ID: <418892E8.6090002@kolivas.org>
Date: Wed, 03 Nov 2004 19:12:24 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] add requeue task
References: <418707E5.90705@kolivas.org>	<41877F2D.6070200@yahoo.com.au> <16775.42190.9404.303359@thebsh.namesys.com>
In-Reply-To: <16775.42190.9404.303359@thebsh.namesys.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDBB6E9781EC395055F76B451"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDBB6E9781EC395055F76B451
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nikita Danilov wrote:
>  > Con Kolivas wrote:
>  > > +	list_del(&p->run_list);
>  > > +	list_add_tail(&p->run_list, array->queue + p->prio);
>  > > +}
> 
> Shouldn't this be
> 
> list_move_tail(&p->run_list, array->queue + p->prio);

Yes indeed thanks! Fortunately they're one and the same thing. I've 
already resent this patch once, let akpm's tree settle for a bit before 
I throw more at him.

Cheers,
Con

--------------enigDBB6E9781EC395055F76B451
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBiJLrZUg7+tp6mRURAuMaAJ9rrnDQamudF3DSFQL6EDmWeibcBQCdGW3n
0TIsZV0Viu431qcJYz2id50=
=0EW4
-----END PGP SIGNATURE-----

--------------enigDBB6E9781EC395055F76B451--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVBQAvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVBQAvv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 19:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVBQAvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 19:51:51 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:5040 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S262175AbVBQAv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 19:51:27 -0500
Message-ID: <4213EA7F.4070107@arrakis.dhis.org>
Date: Thu, 17 Feb 2005 00:51:11 +0000
From: Pedro Venda <pjvenda@arrakis.dhis.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Noel Maddy <noel@zhtwn.com>
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible leak in kernel 2.6.10-ac12
References: <4213D70F.20104@arrakis.dhis.org> <200502161835.26047.kernel-stuff@comcast.net> <4213DF19.10209@arrakis.dhis.org> <20050217003846.GA5615@uglybox.localnet>
In-Reply-To: <20050217003846.GA5615@uglybox.localnet>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Noel Maddy wrote:
| On Thu, Feb 17, 2005 at 12:02:33AM +0000, Pedro Venda wrote:
|
|
|>admin proc # cat slabinfo
|
| ...
|
|>biovec-1           74224  74354     16  226    1 : tunables  120   60    0 :
slabdata    329    329      0
|>bio                74212  74237     64   61    1 : tunables  120   60    0 :
slabdata   1217   1217      0
|
|
| If you're using md, you need this patch to fix a bio leak:
|
| http://linux.bkbits.net:8080/linux-2.6/diffs/drivers/md/md.c@1.234

thanks.

has this patch been included in the recent rc's?

and howcome the other servers work normally [all with md]? at least so far the
memory usages aren't concerning, although the linear increase is starting to
show. perhaps the [different] apps running on them don't expose the leak as well
the one that broke today... is that reasonable?

regards,

- --

Pedro João Lopes Venda
email: pjvenda@arrakis.dhis.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCE+p/eRy7HWZxjWERArOTAKDmZ0fG1DpfN7pW9UNaVpLWK3LX2gCg0/Kr
u4kzp1PaId8tmo61oHFISuk=
=jGB3
-----END PGP SIGNATURE-----

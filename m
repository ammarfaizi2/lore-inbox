Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVBQCoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVBQCoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 21:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVBQCoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 21:44:15 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:56255 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S262196AbVBQCoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 21:44:08 -0500
Message-ID: <421404F3.5030502@arrakis.dhis.org>
Date: Thu, 17 Feb 2005 02:44:03 +0000
From: Pedro Venda <pjvenda@arrakis.dhis.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pedro Venda <pjvenda@arrakis.dhis.org>
Cc: Noel Maddy <noel@zhtwn.com>, Parag Warudkar <kernel-stuff@comcast.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible leak in kernel 2.6.10-ac12
References: <4213D70F.20104@arrakis.dhis.org> <200502161835.26047.kernel-stuff@comcast.net> <4213DF19.10209@arrakis.dhis.org> <20050217003846.GA5615@uglybox.localnet> <4213EA7F.4070107@arrakis.dhis.org>
In-Reply-To: <4213EA7F.4070107@arrakis.dhis.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pedro Venda wrote:
| Noel Maddy wrote:
| | On Thu, Feb 17, 2005 at 12:02:33AM +0000, Pedro Venda wrote:
| |
| |
| |>admin proc # cat slabinfo
| |
| | ...
| |
| |>biovec-1           74224  74354     16  226    1 : tunables  120
| 60    0 :
| slabdata    329    329      0
| |>bio                74212  74237     64   61    1 : tunables  120
| 60    0 :
| slabdata   1217   1217      0
| |
| |
| | If you're using md, you need this patch to fix a bio leak:
| |
| | http://linux.bkbits.net:8080/linux-2.6/diffs/drivers/md/md.c@1.234
|
| thanks.
|
| has this patch been included in the recent rc's?
|
| and howcome the other servers work normally [all with md]? at least so
| far the
| memory usages aren't concerning, although the linear increase is
| starting to
| show. perhaps the [different] apps running on them don't expose the leak
| as well
| the one that broke today... is that reasonable?

correction: after looking at /proc/slabinfo, the counters around the bio lines
are 10-100 times bigger than all the other, so their also leaking.

I read some discussion on this list around this issue and people were not
positive the leak came from md...

any comments?

regards.
- --

Pedro João Lopes Venda
email: pjvenda@arrakis.dhis.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCFATzeRy7HWZxjWERApHtAKDsX1UVnKP1JICe1/RrzuzF00P84QCfac4+
Mtxq0Y31MFhdsIgBf5S0n/Y=
=u/li
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbVIUHCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVIUHCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 03:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVIUHCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 03:02:39 -0400
Received: from main.gmane.org ([80.91.229.2]:18575 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750732AbVIUHCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 03:02:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: SATA suspend-to-ram patch - merge?
Date: Tue, 20 Sep 2005 23:59:44 -0700
Message-ID: <433104E0.4090308@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig14918BB404C2C240BAC5433D"
X-Complaints-To: usenet@sea.gmane.org
Cc: jgarzik@pobox.com, axboe@suse.de
X-Gmane-NNTP-Posting-Host: lal-99-128.reshall.berkeley.edu
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig14918BB404C2C240BAC5433D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Debugging a friend's new IBM Thinkpad T43, I found that I had to use
this patch by Jens Axboe to get suspend-to-RAM working on his machine,
to prevent SATA from completely flipping out on resume and hanging on
any disk activity:

http://seclists.org/lists/linux-kernel/2005/May/0447.html

The patch is not in 2.6.13, and currently doesn't apply to either that
or 2.6.12 - a quick-and-(very-)dirty rediff for only the drivers needed
(ata_piix) worked for my purposes, and the machine suspends and resumes
correctly now.

I investigated a little and noticed that the patch in its current form
doesn't seem to exist in 2.6.14-rc1, but there are some new ATA commands
 -- ATA_CMD_STANDBY etc. that have been introduced, which seem vaguely
relevant to the problem. I'm not sure whether those changes do any of
the work that Jens' patch did, and I also haven't tested that kernel yet
on my friend's machine.

Is Jens' patch still relevant? If so, should it be rediffed and merged
into mainline? It doesn't seem to cause any weird side-effects.

More importantly, I would be inclined to properly rediff Jens' patch and
merge it into Debian 2.6.12 kernel sources if there aren't any such
side-effects, since it benefits everyone using SATA and suspend-to-ram
(that is, users of relatively modern laptops.)

Thanks!

-- 
Joshua Kwan

--------------enig14918BB404C2C240BAC5433D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQzEE56OILr94RG8mAQL1pQ/+PxfSQ1AcfaZdgBfhIrEP1lSCS3MLC/s5
3stomAU7HkY3IOeprOhwIKxG504iKoaCo6L/1gAZKV3g01RIrNCYmdPJzwRpyf5f
eTgAO1DEHMQTH3hR4ETs56lZDM8aCH8ee9MncgV1dbjuaJ+YSLieILvASesjMPX0
Lcs1cUeuyj9m57TSFxvptIW/74nRHDC9yKSNYf7N7oR4hgc3nfFNawCtP596cU1N
LcXXCBFPefaMXxmHz2Zr4aP/sE6XlV+DUDaCXqGZCRZA6uZTT1HYBnbZMeB0GGYD
Ygjt1miIb5zreng2EZ9+xh5PLJOGFYdvI7ofQe1Cx82ff8ZCb6dHXYE4ucBGZvu/
UaGPfvGWoOWqSBZCRyCV5ydYl+wUtj6UckkILYSRnRRrniMXvCmLgwPr8IiBVtro
gE1HsRoRlS2lZzMA9pvXWgfW71+8lwU5pr8g4qemkP34HcqMx8SqMw7RmYzuVfbS
FQ5N+HVoP/LHEJawNepoW+Hq+J7kQFArwuErAnh8CZfEq3la7KGuHFypppOmFOr+
JWgxw/0V/hPYwJQwVhSI045GeUkXIUgk+5hx4CbGzKyKNFwioDfw8lxF5niMqtqL
60KHuqhWT92vMoRlMdK/p9I4cguVYhWwfrGeeoinZpRMmI13slgXsgFl5YfY1QiN
1dtBUv+8jkU=
=abQo
-----END PGP SIGNATURE-----

--------------enig14918BB404C2C240BAC5433D--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbTFLLKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264823AbTFLLKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:10:41 -0400
Received: from camus.xss.co.at ([194.152.162.19]:16136 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S264821AbTFLLKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:10:38 -0400
Message-ID: <3EE862DC.1010809@xss.co.at>
Date: Thu, 12 Jun 2003 13:24:12 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christopher Chan <lkml@graffiti.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sudden instabilty of mysql boxen
References: <20030612101744.7207.qmail@graffiti.net>
In-Reply-To: <20030612101744.7207.qmail@graffiti.net>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Christopher Chan wrote:
> Can somebody help out with pointers to why my boxes would suddenly
> become unstable?
>
> I have two boxes running mysql servers. The first one is running RH
> 7.3 with a 2.4.18-26 kernel that has the 3ware no bounce buffer patch
> enabled (the src.rpm was downloaded, 3ware patch enabled and
> rpmbuild) and the second one is running Rh 7.0 with a 2.4.2-ac28
> kernel. The 3ware box handles over 600 queries per second.
>
> The first box runs on a linux software mirrored array but has the
> mysql data on a 3ware stripped mirrored array while the second one
> runs on a linux software mirrored array (got two disks only).
>
I assume you didn't change anything of the (previously
working) setup?

> They both suddenly started vomiting messages like:
>
> Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04
>  <1>Unable to handle kernel NULL pointer dereference at virtual
> address 00000004
>
> Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04
>  Oops: 0000
>
> and any commands you run on shells (if you them in the first place)
> would exit with a segmentation fault. All attempts to ssh into the
> box would fail after successful authentication with the connection
> being closed (bash segfault?)
>
> A reboot would cause them to run normally until they start acting up
> again minutes later.
>

Are both boxes located in the same room?
Maybe they're getting too hot now for some reason (ambient air
temperature too high, cooler and/or fan not working right)?
Also check your mains power supply. If it's unstable (e.g. voltage
too low), it could cause such effects, too (but this is usually
less likely than overheating).

HTH

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+6GLZxJmyeGcXPhERAtLxAJ9SVAGIDzfSZ8z4MArmleVpii7sKgCgmiiQ
4SsZpxlL7jWac3F3UKODaPo=
=mHtP
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271820AbTGRVzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270396AbTGRVy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:54:29 -0400
Received: from mail47-s.fg.online.no ([148.122.161.47]:9682 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP id S270380AbTGRVyN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:54:13 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: Nachman Yaakov Ziskind <awacs@egps.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD-RAM crashing system
Date: Sat, 19 Jul 2003 00:08:31 +0200
User-Agent: KMail/1.5.2
References: <20030718160643.A21755@egps.egps.com>
In-Reply-To: <20030718160643.A21755@egps.egps.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307190008.32137.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

fredag 18. juli 2003, 22:06, skrev Nachman Yaakov Ziskind:
> Anyone out there with tips on how to resolve this? Perhaps I can
> force the kernel to think that DMA has been disabled?

No tips, I'm afraid, but don't even *think* about doing that.
As the technician said, the problem is with the chipset not accepting commands 
properly; fortunately, the kernel appears to catch the situation and avoid 
(potential) severe damage.

Forcing the kernel to act as if DMA is fully disabled when in fact it isn't 
sounds like a very bad idea indeed; the best you could probably hope for is 
to have the machine crash without losing any data.


My suggestion is this: As the hardware is obviously broken, and disabling DMA 
would cause a horrendous performance drop anyway, you should get a new 
chipset. Return the one you have as broken.

If that isn't an option, for whatever reason, you might try switching to a 
lower-speed DMA mode using hdparm. Something like "hdparm -Xudma0 /dev/hdx" 
might help, if you're lucky.

- - Svein Ove Aas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/GG/f9OlFkai3rMARApCiAKCojeoY+nfskcM6EKFco8xktnSfjQCfTq6u
rkZjj7+DtP90zv8cHuTorrA=
=lr9Y
-----END PGP SIGNATURE-----


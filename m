Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbUCYTvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbUCYTvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:51:40 -0500
Received: from 011.081.dsl.concepts.nl ([213.197.11.81]:22749 "EHLO
	server.thuis.lan") by vger.kernel.org with ESMTP id S263587AbUCYTvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:51:39 -0500
Message-ID: <40633843.3090300@xs4all.nl>
Date: Thu, 25 Mar 2004 20:51:31 +0100
From: Rik van Ballegooijen <sleightofmind@xs4all.nl>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: sleightofmind@xs4all.nl, m.c.p@wolk-project.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, len.brown@intel.com
Subject: Re: [BUG 2.6.5-rc2-bk5 and 2.6.5-rc2-mm3] ACPI seems to be broken
References: <200403251432.32787@WOLK>	<4062E986.2080508@xs4all.nl> <20040325090232.15e8f59f.akpm@osdl.org>
In-Reply-To: <20040325090232.15e8f59f.akpm@osdl.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
| Rik van Ballegooijen <sleightofmind@xs4all.nl> wrote:
|
|> with acpi on it can also run, but not if you supply vga=. I tried with
|> vga=0x317 and it stalls after "Freeing unused kernel memory". When i
|> turn off acpi using acpi=off and also supply vga=0x317 it continues
|> booting, but hangs during execution of bootscripts.
|
|
| It would be interesting to try reverting probe_roms-02-fixes.patch and
| probe_roms-01-move-stuff.patch.

Reverting these two patches does nothing. The result is exactly the same
as above.
Reverting the acpi stuff that went into -bk some days ago does solve the
problem. I haven't checked yet which part to be exact causes this though.

- -Rik
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAYzhDq1cnhHKeD68RAv0bAJ0Xt5LaLsizdw8SLENi8AGdsnJmvACgj8L3
dWQa/6iEvC1ilyfZwlWgHok=
=sEZU
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265000AbUF1PEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265000AbUF1PEf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUF1PEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:04:35 -0400
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:25224 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265000AbUF1PEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:04:30 -0400
Message-ID: <40E03376.20705@kolivas.org>
Date: Tue, 29 Jun 2004 01:04:22 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nice 19 process still gets some CPU
References: <40E035CE.1020401@techsource.com>
In-Reply-To: <40E035CE.1020401@techsource.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Timothy Miller wrote:
| Given how much I've read here about schedulers, I should probably be
| able to answer this question myself, but I just thought I might talk to
| the experts.
|
| I'm running SETI@Home, and it has a nice value of 19.  Everything else,
| for the most part, is at zero.
|
| I'm running kernel gentoo-dev-sources-2.6.7-r6 (I believe).
|
| When I'm not running SETI@Home, compiler threads (emerge of a package,
| kernel compile, etc.) get 100% CPU.  When I AM running SETI@Home,
| SETI@Home still manages to get between 5% and 10% CPU.
|
| I would expect that nice 0 processes should get SO MUCH more than nice
| 19 processes that the nice 19 process would practically starve (and in
| the case of a nice 19 process, I think starvation by nice 0 processes is
| just fine), but it looks like it's not starving.
|
| Why is that?

It definitely should _not_ starve. That is the unixy way of doing
things. Everything must go forward. Around 5% cpu for nice 19 sounds
just right. If you want scheduling only when there's spare cpu cycles
you need a sched batch(idle) implementation.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA4DN2ZUg7+tp6mRURAul+AJ4v3CXwD/XZtjarmTCo7ntISETHdACfYIWT
MdJ8lxP3+Z/A4tTipWSDlgA=
=MeGN
-----END PGP SIGNATURE-----

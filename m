Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVAQHkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVAQHkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 02:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVAQHkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 02:40:46 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:64462 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262723AbVAQHkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 02:40:10 -0500
Message-ID: <41EB6BD6.5070702@comcast.net>
Date: Mon, 17 Jan 2005 02:40:06 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Audit Project?
References: <41EB6691.10905@comcast.net>
In-Reply-To: <41EB6691.10905@comcast.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On the same line, I've been graphing Ubuntu Linux Security Notices for a
while.  I've noticed that in the last 5, the number of kernel-related
vulnerabilities has doubled (3 more).  This disturbs me.

I categorized the vulns I'd found into fairly arbitrary categories; upon
looking at a graph, I noticed that some bars were short and others were
unbelievably long (duh).  Reordering things, I came up with what looks
suspiciously like a standard normal distribution.

Kernel vulnerabilities appear to be falling within the first two
standard distributions now, at a glance.  95% of vulnerabilities land
here; 8.3% (kernel vulns excluding buffer overflows) fall within this
range, I'm guessing about . . . well, 8.3% chance.  Total I have 10% of
the vulnerabilities graphed as being from the kernel.

Every time a new kernel vulnerability is made (whether I see it or not),
that bar moves towards the center.  Every time a userspace vulnerability
is made, that bar moves outwards.  I can only graph what I can see, but
I'm very worried; if that bar keeps moving the way it's going, faster
than US vulns, then the probability of KS exploits is probably genuinely
increasing in probability.

Kernel space exploits can never be sanely protected against.  Even if
you can catch and kill them, you cause a system crash (major DoS), which
is hardly a good solution.  At least in userspace when SSP or PaX kills
something, the user either restarts it, or init is running it as a
daemon and just auto-restarts it immediately.  And at least it only
causes a small burp.

SELinux won't help either.  If you exploit the kernel, you're in.
Sometimes this is root access and you get lucky because SE doesn't know
who you think you want to be; other times this is arbitrary code
execution from inside the kernel and it doesn't matter who the kernel
thinks you are, you're in control.

Oh well, at least they still get fixed when they're seen.

John Richard Moser wrote:
> Is there an official Linux Kernel Audit Project to actively and
> aggressively security audit all patches going into the Linux Kernel, or
> do they just get a cursory scan for bugs and obvious screwups?

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB62vUhDd4aOud5P8RAlNDAJ91Om3VdcNXpHJ/Yamm9cG3JyYMugCfaSzb
Ngq2bR/PtAC+q0wASg5frng=
=xsfz
-----END PGP SIGNATURE-----

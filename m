Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266920AbUFZCFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266920AbUFZCFl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 22:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266923AbUFZCFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 22:05:41 -0400
Received: from mail012.syd.optusnet.com.au ([211.29.132.66]:52387 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266920AbUFZCFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 22:05:38 -0400
Message-ID: <40DCD9EA.1030906@kolivas.org>
Date: Sat, 26 Jun 2004 12:05:30 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
Cc: Willy Tarreau <willy@w.ods.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de> <200406252044.25843.mbuesch@freenet.de> <20040625190533.GI29808@alpha.home.local> <200406252148.37606.mbuesch@freenet.de>
In-Reply-To: <200406252148.37606.mbuesch@freenet.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michael Buesch wrote:
| On Friday 25 June 2004 21:05, you wrote:
|
|>>Hi Michael,
|>>
|>>On Fri, Jun 25, 2004 at 08:44:22PM +0200, Michael Buesch wrote:
|>>
|>>
|>>>I don't know what the file wchan is good for, but here is
|>>>it's output:
|>>>mb@lfs:/proc/11000> cat wchan
|>>>sys_wait4
|>>
|>>I bet the process is waiting for a SIGCHLD from a previously forked
|>>process. Con, would it be possible that under some circumstances,
|>>a process does not receive a SIGCHLD anymore, eg if the child runs
|>>shorter than a full timeslice or something like that ? In autoconf
|>>scripts, there are lots of very short operations that might trigger
|>>such unique cases.
| But as the load grows, the system is usable as with load 0.0.
| And it really should be usable with 76.0% nice. ;) No problem here.
| This really high load is not correct.

I think you're right about having no timeslice.

It does appear that I fixed two things and introduced 2 more bugs. I'll
fix it in the next couple of days.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3NnqZUg7+tp6mRURAk7tAJ9bKHWsnnNOf9j0PGXKh23rvBAbPQCfWC+8
w+VCt4GhvaR/bL6s9+GjrOQ=
=KIkQ
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbTIEU11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbTIEU10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:27:26 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:18863
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265951AbTIEUY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:24:57 -0400
Message-ID: <3F58F0F7.4090105@redhat.com>
Date: Fri, 05 Sep 2003 13:24:23 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030904 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: today's futex changes
X-Enigmail-Version: 0.81.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

... broke NPTL.  Tests which worked with previous kernels fail now.  One
test eventually succeeded, but the process somehow got stuck for about
30-40 seconds.  Then it finished.  Running strace showed a call to
clone() as the last operation but there were other threads running at
that time.

I tried to login (via ssh) into the system when the process hang and
this, too, was delayed and succeeded immediately when the strace'd
process continued.

I haven't looked at the changes made and wouldn't expect to understand
all the details either.  And I can understand if you don't want to run
the glibc test suite.  What I can offer are statically linked versions
of the tests.  One is here:

  http://people.redhat.com/drepper/tst-cond2.bz2

358572ec100de9b27833d6c4ee5ecdb5  tst-cond2


Let me know if you need more help.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/WPD32ijCOnn/RHQRApLUAJ9SiIelIOnUA/pOmol04AaM+hMvaQCgoA86
VNLbS7nFXoVggjDtWAJxZ5g=
=tNkI
-----END PGP SIGNATURE-----


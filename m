Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWJTS3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWJTS3h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWJTS3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:29:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29392 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030199AbWJTS3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:29:36 -0400
Message-ID: <4539158C.2090801@redhat.com>
Date: Fri, 20 Oct 2006 13:29:32 -0500
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: time warp on 2.6.18-rt6 (2nd try)
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo,

I sent this yesterday morning and haven't seen it show up. I wonder if
my attached configs/logs were too large? Now referenced as URLs...

I'm still seeing the time warp ("It's just a jump to the left!" :))*
being triggered on both my Athlon64x2 (32-bit kernel) and my Athlon64 up
box (64-bit kernel). A boot log that shows the failure and the config
files for both systems can be found at:

http://people.redhat.com/williams/rt

To trigger this, I was running pi_stress test from:

http://people.redhat.com/williams/tests/pi_tests-1.3.tar.gz

I was running it like this:

$ sudo pi_stress --verbose

Note: Be aware that I still haven't got pi_stress to stop reliably.
It will catch SIGINT sometimes and sometimes it just blithely ignores it
and sails on. Since in the default run there are ten groups of three
threads all running SCHED_FIFO and performing a priority inversion
scenario, this will mean a uniprocessor box will be almost unusable for
other tasks. On my SMP box I can ssh into the box and kill the test with
"kill <pid>".

Let me know if you need me to reconfigure and try something else.

Clark

* lame "Rocky Horror Picture Show" reference

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFORWMHyuj/+TTEp0RAq8QAJ9t30GOTjRmKD0Tkif94wQVyOyRTQCfbmX7
Qm3mAzmnnH8KDqpP2hoDwSE=
=kkAj
-----END PGP SIGNATURE-----

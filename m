Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264762AbUFSXKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbUFSXKz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 19:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUFSXKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 19:10:55 -0400
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:53993 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264762AbUFSXKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 19:10:53 -0400
Message-ID: <40D4C7F3.7060001@kolivas.org>
Date: Sun, 20 Jun 2004 09:10:43 +1000
From: Con Kolivas <conman@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: AshMilsted <thatistosayiseenem@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-ck1
References: <20040619205038.27491.qmail@gawab.com>
In-Reply-To: <20040619205038.27491.qmail@gawab.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

AshMilsted wrote:
| 2.6.7-ck1 is very useable on my Celeron 500 (medochino) system
| (using cfq I/O sched). It seems more responsive than the recent
| stock kernels, and staircase 7.0/7.1 is a big improvement over
| 6.3, which stalled in annoying places. In fact, the only problem
| I have with the patchset is that when I run foobar2000 under
| wine the sound skips when I load a new web page in epiphany. If
| I make wine an ISO task with schedtool then it no longer skips,
| but it also hangs the system for a few seconds while browsing
| the foobar preferences dialogue. I guess I'll have to keep a
| launcher without schedtool ready for when I need to mess with
| the prefs for now.
| Anyway, great work - makes this old system seem that little bit
| snappier.

Great!

Running wine as an ISO task will give it short periods of high priority
over and above your web browser - that's the point since it is soft real
time scheduling.

You may want to try disabling the interactive setting as well
echo 0 > /proc/sys/kernel/interactive

as some very resource hungry applications (eg games and perhaps wine)
seem better behaved in that setting too.

Thanks for feedback.
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA1MfzhVgilAM1lAgRAsBGAKDy//DEmBw77T8L9Xe/NLhE4GuHXACgrlZc
U6ZNj8RTBIyTDWfwGejvGos=
=5Wmh
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVEKCtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVEKCtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 22:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVEKCtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 22:49:42 -0400
Received: from imap.infopop.com ([63.251.4.15]:58150 "EHLO imap.infopop.com")
	by vger.kernel.org with ESMTP id S261884AbVEKCti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 22:49:38 -0400
Message-ID: <428172BB.60704@unixgrrl.net>
Date: Tue, 10 May 2005 19:49:31 -0700
From: liz <liz@unixgrrl.net>
Reply-To: liz@unixgrrl.net
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel cache and NFS
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greetings,

I can't seem to find an answer to this issue anywhere.

A box running a 2.4.21 smp kernel is holding 2G of ram in the system
cache, despite being heavily into swap:

~        total:    used:    free:  shared: buffers:  cached:
Mem:  4224462848 4206002176 18460672        0 41304064 2938032128
Swap: 2146754560 1073373184 1073381376
MemTotal:      4125452 kB
MemFree:         18028 kB
MemShared:           0 kB
Buffers:         40336 kB
Cached:        2095616 kB                        <---- 2G disk cache
SwapCached:     773556 kB
Active:        3186300 kB
ActiveAnon:    1707252 kB
ActiveCache:   1479048 kB
Inact_dirty:    607944 kB
Inact_laundry:  117300 kB
Inact_clean:     65180 kB
Inact_target:   795344 kB
HighTotal:     3276224 kB
HighFree:         1200 kB
LowTotal:       849228 kB
LowFree:         16828 kB
SwapTotal:     2096440 kB                      <-- 1G swap usage
SwapFree:      1048224 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

Why is this memoy being held in the disk cache? Is this perhaps an NFS
issue?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgXK7lt/irWun80cRAqPJAKCJZBt6z4MJmkXGOJ1TNKbRJ2VDOQCeJIAU
VXk/mPxV0otv9C7VZ7t/NwA=
=ZmEs
-----END PGP SIGNATURE-----


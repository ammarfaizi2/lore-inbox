Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266240AbUFYN0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUFYN0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 09:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266335AbUFYN0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 09:26:47 -0400
Received: from [195.124.124.201] ([195.124.124.201]:33028 "EHLO
	nt-49613145.zdf.de") by vger.kernel.org with ESMTP id S266240AbUFYN0n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 09:26:43 -0400
Message-ID: <40DC27EC.5040802@zdf.de>
Date: Fri, 25 Jun 2004 15:26:04 +0200
X-Sybari-Trust: fa2e2505 2335e436 9ff3b9e4 00000139
From: Ulrich Brand <brand.u@zdf.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040514
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kswapd problem
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

i've just the same prob's whith 2.4.26 smp, build
whith p4/smp 64 GB config running on fujitsu siemens
dual xeon/3.06 GHz servers with 12 G ram.
my "magic tail" is still a grep thrue the filesystem.
the system work's well if the memory utilisation is lower
then ~ 1 gig ram. if you start th database (oracle 9i),
which takes ca. 2 gig ram (about 130 oracle prcesses),
the machine feezes for about 5 to 10 minutes !!!
the load grows up to 200!! top shows 99,5 % cpu time
on kswapd. the machine has 2 GB swap, and uses nothing.
is there a problem with highmem ?
i've attatched some snipplet's with "top" output.
the freeze occures between snipp 2 and 3.
please help.

Thanks in advance & kind regards,
ulrich

- --1--
top - 13:13:50 up  4:38,  5 users,  load average: 6.48, 5.59, 2.90
Tasks: 290 total,   2 running, 288 sleeping,   0 stopped,   0 zombie
Cpu(s):  33.8% user,  16.9% system,   0.0% nice,  49.3% idle
Mem:  12230636k total,  7377644k used,  4852992k free,   151156k buffers
Swap:  2097136k total,        0k used,  2097136k free,  6375056k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
14453 oracle    16   0 1074m 1.0g 1.0g S 52.3  9.0   1:57.47 oracle
    5 root       9   0     0    0    0 S 19.6  0.0   1:34.22 kswapd
14950 oracle     9   0 1071m 1.0g 1.0g S  6.6  9.0   1:55.53 oracle
15377 oracle     9   0 1028m 1.0g 1.0g S  5.3  8.6   3:21.81 oracle


- --2--
top - 13:14:01 up  4:38,  5 users,  load average: 5.94, 5.51, 2.91
Tasks: 290 total,   8 running, 282 sleeping,   0 stopped,   0 zombie
Cpu(s):   7.2% user,  21.6% system,   0.0% nice,  71.2% idle
Mem:  12230636k total,  7401996k used,  4828640k free,   152544k buffers
Swap:  2097136k total,        0k used,  2097136k free,  6397888k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    5 root      19   0     0    0    0 R 20.9  0.0   1:36.42 kswapd
25064 root      18   0  1008 1008  668 R  7.5  0.0   0:27.06 top
15377 oracle     9   0 1029m 1.0g 1.0g S  4.1  8.6   3:22.24 oracle
17803 oracle     9   0  965m 965m 961m S  3.8  8.1   0:53.31 oracle
25442 root       9   0   708  708  492 D  3.4  0.0   0:00.74 grep
25441 root       9   0   708  708  492 D  2.6  0.0   0:00.60 grep
14946 oracle     9   0 1120m 1.1g 1.1g S  2.1  9.4   1:54.74 oracle
14439 oracle     9   0  996m 993m 990m S  1.6  8.3   0:52.79 oracle
14453 oracle     9   0 1075m 1.0g 1.0g R  0.9  9.0   1:57.57 oracle
25425 oracle    10   0  273m 273m 271m R  0.9  2.3   0:05.02 oracle
14

- --3--
top - 13:14:15 up  4:39,  5 users,  load average: 21.55, 8.85, 4.03
Tasks: 290 total,  12 running, 278 sleeping,   0 stopped,   0 zombie
Cpu(s):   2.2% user,  96.9% system,   0.0% nice,   1.0% idle
Mem:  12230636k total,  7286604k used,  4944032k free,   152580k buffers
Swap:  2097136k total,        0k used,  2097136k free,  6281600k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 6888 root      20   0  7872 7868 1160 D 84.8  0.1   0:18.87 oracm
14461 root      10   0  7872 7868 1160 S 52.1  0.1   0:17.65 oracm
 6891 root      14   0  7872 7868 1160 S 31.5  0.1   0:13.18 oracm
    5 root      15   0     0    0    0 R  9.9  0.0   1:37.86 kswapd
25441 root       9   0   708  708  492 D  4.3  0.0   0:01.23 grep
25064 root      14   0  1008 1008  668 R  4.2  0.0   0:27.68 top
25442 root       9   0   708  708  492 D  4.0  0.0   0:01.32 grep
 9514 root      14   0  1740 1740 1508 R  3.9  0.0   0:54.47 xosview.bin
15377 oracle     9   0 1029m 1.0g 1.0g S  1.2  8.6   3:22.42 oracle
14982 oracle    14   0 1141m 1.1g 1.1g R  0.8  9.5   2:32.85 oracle


- --4---
top - 13:14:15 up  4:39,  5 users,  load average: 21.55, 8.85, 4.03
Tasks: 290 total,  12 running, 278 sleeping,   0 stopped,   0 zombie
Cpu(s):   2.2% user,  96.9% system,   0.0% nice,   1.0% idle
Mem:  12230636k total,  7286604k used,  4944032k free,   152580k buffers
Swap:  2097136k total,        0k used,  2097136k free,  6281600k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 6888 root      20   0  7872 7868 1160 D 84.8  0.1   0:18.87 oracm
14461 root      10   0  7872 7868 1160 S 52.1  0.1   0:17.65 oracm
 6891 root      14   0  7872 7868 1160 S 31.5  0.1   0:13.18 oracm
    5 root      15   0     0    0    0 R  9.9  0.0   1:37.86 kswapd
25441 root       9   0   708  708  492 D  4.3  0.0   0:01.23 grep
25064 root      14   0  1008 1008  668 R  4.2  0.0   0:27.68 top
25442 root       9   0   708  708  492 D  4.0  0.0   0:01.32 grep
 9514 root      14   0  1740 1740 1508 R  3.9  0.0   0:54.47 xosview.bin
15377 oracle     9   0 1029m 1.0g 1.0g S  1.2  8.6   3:22.42 oracle
14982 oracle    14   0 1141m 1.1g 1.1g R  0.8  9.5   2:32.85 oracle


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFA3Cfs06ncFEdJe8URArohAKCGgMQt0awZnJDOhrl0xZ16REaprwCfS+Cb
Au9EFXhuKySqCPzmVIJVYX0=
=lHV5
-----END PGP SIGNATURE-----

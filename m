Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267056AbUBEXSc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267053AbUBEXRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:17:13 -0500
Received: from arhont1.eclipse.co.uk ([81.168.98.121]:15334 "EHLO
	pingo.core.arhont.com") by vger.kernel.org with ESMTP
	id S267031AbUBEXQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:16:30 -0500
Message-ID: <4022CEC4.2010401@arhont.com>
Date: Thu, 05 Feb 2004 23:16:20 +0000
From: Andrei Mikhailovsky <andrei@arhont.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Lower performance in 2.6.2 compared to 2.4.22
X-Enigmail-Version: 0.83.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

Just finished tests using Byte benchmark (available from unix.com).

2.4.22 has better results in both benchmarks. Here are results:


- ---Byte benchmark on 2.6.2 BEGIN---
~  BYTE UNIX Benchmarks (Version 3.11)
~  System -- Linux (none) 2.6.2 #1 Wed Feb 4 14:32:05 GMT 2004 i686
GNU/Linux
~  Start Benchmark Run: Thu Feb  5 19:41:01 GMT 2004
~   0 interactive users.
Dhrystone 2 without register variables   4824680.0 lps   (10 secs, 6
samples)
Dhrystone 2 using register variables     4823649.9 lps   (10 secs, 6
samples)
Arithmetic Test (type = arithoh)         9008352.2 lps   (10 secs, 6
samples)
Arithmetic Test (type = register)        388928.1 lps   (10 secs, 6 samples)
Arithmetic Test (type = short)           373900.1 lps   (10 secs, 6 samples)
Arithmetic Test (type = int)             388868.2 lps   (10 secs, 6 samples)
Arithmetic Test (type = long)            388872.5 lps   (10 secs, 6 samples)
Arithmetic Test (type = float)           736101.7 lps   (10 secs, 6 samples)
Arithmetic Test (type = double)          736099.0 lps   (10 secs, 6 samples)
System Call Overhead Test                1173978.8 lps   (10 secs, 6
samples)
Pipe Throughput Test                     1196881.4 lps   (10 secs, 6
samples)
Pipe-based Context Switching Test        400114.1 lps   (10 secs, 6 samples)
Process Creation Test                     15473.9 lps   (10 secs, 6 samples)
Execl Throughput Test                      3933.9 lps   (9 secs, 6 samples)
File Read  (10 seconds)                  3618620.0 KBps  (10 secs, 6
samples)
File Write (10 seconds)                  324411.0 KBps  (10 secs, 6 samples)
File Copy  (10 seconds)                   62389.0 KBps  (10 secs, 6 samples)
File I/O                                   no measured results
C Compiler Test                            no measured results
Shell scripts (1 concurrent)               4453.4 lpm   (60 secs, 3 samples)
Shell scripts (2 concurrent)               2368.0 lpm   (60 secs, 3 samples)
Shell scripts (4 concurrent)               1225.7 lpm   (60 secs, 3 samples)
Shell scripts (8 concurrent)                615.3 lpm   (60 secs, 3 samples)
Dc: sqrt(2) to 99 decimal places         149692.7 lpm   (60 secs, 6 samples)
Recursion Test--Tower of Hanoi            76170.8 lps   (10 secs, 6 samples)
~                     INDEX VALUES
TEST                                    BASELINE     RESULT      INDEX

Arithmetic Test (type = double)           2541.7   736099.0      289.6
Dhrystone 2 without register variables   22366.3  4824680.0      215.7
Execl Throughput Test                       16.5     3933.9      238.4
Pipe-based Context Switching Test         1318.5   400114.1      303.5
Shell scripts (8 concurrent)                 4.0      615.3      153.8
~                                                                 =========
~     SUM of  5 items                                            1201.0
~     AVERAGE                                                     240.2

- ---Byte benchmark on 2.6.2 END---


- ---Byte benchmark on 2.4.22 BEGIN---
~  BYTE UNIX Benchmarks (Version 3.11)
~  System -- Linux (none) 2.4.22-bk36 #2 Fri Oct 17 14:30:25 BST 2003
i686 GNU/Linux
~  Start Benchmark Run: Thu Feb  5 21:05:04 GMT 2004
~   0 interactive users.
Dhrystone 2 without register variables   4744521.8 lps   (10 secs, 6
samples)
Dhrystone 2 using register variables     4746498.5 lps   (10 secs, 6
samples)
Arithmetic Test (type = arithoh)         9065795.0 lps   (10 secs, 6
samples)
Arithmetic Test (type = register)        391434.4 lps   (10 secs, 6 samples)
Arithmetic Test (type = short)           376179.1 lps   (10 secs, 6 samples)
Arithmetic Test (type = int)             391471.6 lps   (10 secs, 6 samples)
Arithmetic Test (type = long)            391469.3 lps   (10 secs, 6 samples)
Arithmetic Test (type = float)           740918.6 lps   (10 secs, 6 samples)
Arithmetic Test (type = double)          741556.2 lps   (10 secs, 6 samples)
System Call Overhead Test                1194144.8 lps   (10 secs, 6
samples)
Pipe Throughput Test                     1491956.9 lps   (10 secs, 6
samples)
Pipe-based Context Switching Test        556854.3 lps   (10 secs, 6 samples)
Process Creation Test                     19275.1 lps   (10 secs, 6 samples)
Execl Throughput Test                      4244.6 lps   (10 secs, 6 samples)
File Read  (10 seconds)                  4435520.0 KBps  (10 secs, 6
samples)
File Write (10 seconds)                  243964.0 KBps  (10 secs, 6 samples)
File Copy  (10 seconds)                   41601.0 KBps  (10 secs, 6 samples)
File I/O                                   no measured results
C Compiler Test                            1077.6 lpm   (60 secs, 3 samples)
Shell scripts (1 concurrent)               4950.8 lpm   (60 secs, 3 samples)
Shell scripts (2 concurrent)               2641.4 lpm   (60 secs, 3 samples)
Shell scripts (4 concurrent)               1357.8 lpm   (60 secs, 3 samples)
Shell scripts (8 concurrent)                692.1 lpm   (60 secs, 1 samples)
Dc: sqrt(2) to 99 decimal places         186413.3 lpm   (60 secs, 6 samples)
Recursion Test--Tower of Hanoi            76521.6 lps   (10 secs, 6 samples)
~                     INDEX VALUES
TEST                                     BASELINE     RESULT      INDEX

Arithmetic Test (type = double)            2541.7   741556.2      291.8
Dhrystone 2 without register variables    22366.3  4744521.8      212.1
Execl Throughput Test                        16.5     4244.6      257.2
Pipe-based Context Switching Test          1318.5   556854.3      422.3
Shell scripts (8 concurrent)                  4.0      692.1      173.0
~                                                                 =========
~     SUM of  5 items                                             1356.5
~     AVERAGE                                                      271.3


- ---Byte benchmark on 2.4.22 END---


Has anyone experienced similar results? or is it just me?

By the way, I have an the following specs:
AMD Barton 2500+ overclocked to 1968.145Mhz FSB 179Mhz,
512Mb DDR PC2700,
Hitachi 40Gb HD (HDS722540VLAT20),
Sis746FX chipset
ASRock K7S8X


- --
Andrei Mikhailovsky
Arhont Ltd

Web: http://www.arhont.com
Tel: +44 (0)870 4431337
Fax: +44 (0)1454 201200
PGP: Key ID - 0xFF67A4F4
PGP: Server - keyserver.pgp.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAIs7E5bSBOf9npPQRAl6+AJ442nTMde6WcNyE+MsTcn6Q60rdUACdGjCu
Ybz3UM8PxaQZN+KDRtR6r8Y=
=lHob
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130063AbQLJQBX>; Sun, 10 Dec 2000 11:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130747AbQLJQBN>; Sun, 10 Dec 2000 11:01:13 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:57613 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S130063AbQLJQBE>; Sun, 10 Dec 2000 11:01:04 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
Date: Sun, 10 Dec 2000 08:31:29 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00121008312900.00872@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I performed the following tests running both 2.4.0-test12-pre7 and
2.2.18-pre26.  All kernel builds were done in console mode (no X).

All numbers are seconds required to make bzImage.  Times were 
obtained using the date command before and after make bzImage in
a script. Each test was performed three times.

 1   2   3   ave.

449 443 440  444   make bzImage for 2.4.0t12p7 running 2.2.18p26
460 458 454  457.3 make bzImage for 2.4.0t12p7 running 2.4.0t12p7

310 310 307  309   make bzImage for 2.2.18p26 running 2.2.18p26
318 319 317  318   make bzImage for 2.2.18p26 running 2.4.0t12p7

2.2.18p26  is shorthand for 2.2.18-pre26.
2.4.0t12p7 is shorthand for 2.4.0-test12-pre7.

2.2.18-pre26 was patched with reiserfs-3.5.28.
2.2.18-pre26 was compiled with gcc 2.91.66 (kgcc).

2.4.0-test12-pre7 was patched with reiserfs-3.6.22.
2.4.0-test12-pre7 was compiled with gcc 2.95.3.

The .config files were unchanged during the tests.
A make clean was performed before each test.
The test machine was not connected to a network during the tests.
Test machine: single processor P-III (450 Mhz), 192MB, IDE disk (ST317221A).

Conclusion: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
using ReiserFS.  However, the margin of victory is small enough that a 
recount may be necessary.

It would be interesting to see results using ext2fs and results from SMP 
machines.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

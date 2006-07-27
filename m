Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWG0VVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWG0VVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWG0VVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:21:21 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:20636 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1751304AbWG0VVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:21:20 -0400
Message-ID: <44C92E4E.1000104@web.de>
Date: Thu, 27 Jul 2006 23:21:18 +0200
From: "jens m. noedler" <noedler@web.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update kernel-parameters.txt
References: <44C8CDF7.4070205@web.de> <Pine.LNX.4.58.0607270942180.7955@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0607270942180.7955@shark.he.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

Randy.Dunlap wrote at 07/27/2006 06:44 PM:

> Patch should apply with 'patch -p1' (i.e., filenames begin
> with linux/ or a/, b/ etc.)

Thanks for the feedback, here is an updated patch.

By the way: Does anybody know _why_ COMMAND_LINE_SIZE depends
on the architecture? Wouldn't it make sense to generalize it 
for all platforms to e.g. 2048 characters? 

Bye, Jens


Signed-off-by: jens m. noedler <noedler@web.de>

- ---

- --- linux/Documentation/kernel-parameters.txt.orig      2006-07-26 16:47:34.000000000 +0200
+++ linux/Documentation/kernel-parameters.txt   2006-07-27 23:16:00.000000000 +0200
@@ -110,6 +110,13 @@ be entered as an environment variable, w
 it will appear as a kernel argument readable via /proc/cmdline by programs
 running once the system is up.

+The number of kernel parameters is not limited, but the length of the
+complete command line (parameters including spaces etc.) is limited to
+a fixed number of characters. This limit depends on the architecture
+and is between 256 and 4096 characters. It is defined in the file
+./include/asm/setup.h as COMMAND_LINE_SIZE.
+
+
        53c7xx=         [HW,SCSI] Amiga SCSI controllers
                        See header of drivers/scsi/53c7xx.c.
                        See also Documentation/scsi/ncr53c7xx.txt.


- -- 
jens m. noedler
  noedler@web.de
  pgp: 0x9f0920bb
  http://noedler.de

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEyS5OBoFc9p8JILsRAnAwAKD/SlVUogI1weJaSqHmMgAkYvdCkwCfbb77
yDrZi2Zg0AWcxLW9mfh8ArU=
=cMXH
-----END PGP SIGNATURE-----

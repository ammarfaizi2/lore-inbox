Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131022AbQKRCKm>; Fri, 17 Nov 2000 21:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbQKRCKc>; Fri, 17 Nov 2000 21:10:32 -0500
Received: from web3404.mail.yahoo.com ([204.71.203.58]:18949 "HELO
	web3404.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131022AbQKRCK2>; Fri, 17 Nov 2000 21:10:28 -0500
Message-ID: <20001118014019.18006.qmail@web3404.mail.yahoo.com>
Date: Sat, 18 Nov 2000 02:40:19 +0100 (CET)
From: Markus Schoder <markus_schoder@yahoo.de>
Subject: Freeze on FPU exception with Athlon
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following small program (linked against glibc
2.1.3) reliably
freezes my system (Athlon Thunderbird CPU) with at
least kernels
2.4.0-test10 and 2.4.0-test11-pre5.  Even the SysRq
keys do not work
after the freeze.

Older kernels (e.g. 2.3.40) seem to work.  Any Ideas?

---------------------------------------

#define _GNU_SOURCE

#include <fenv.h>
#include <unistd.h>

int
main(void)
{
  double a;
  fesetenv(FE_NOMASK_ENV);
  a = 1.0 / 0.0;
  sleep(10);
  return a;
}

---------------------------------------

--
Markus



__________________________________________________________________
Do You Yahoo!?
Gesendet von Yahoo! Mail - http://mail.yahoo.de
Gratis zum Millionär! - http://10millionenspiel.yahoo.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

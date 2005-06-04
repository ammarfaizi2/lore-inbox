Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVFDD3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVFDD3q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 23:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFDD3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 23:29:46 -0400
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:31360 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261226AbVFDD3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 23:29:44 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200506040329.j543TWV7029456@wildsau.enemy.org>
Subject: 2.4.31 & latest binutils: asm-problems still there
To: linux-kernel@vger.kernel.org
Date: Sat, 4 Jun 2005 05:29:31 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good morning,

I've just tried to compile 2.4.31 and it still doesn't compile
cleanly with the latest binutils release.

gcc -D__KERNEL__ -I/data/root/linux-2.4.31/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -iwithprefix include -DKBUILD_BASENAME=process  -c -o process.o process.c
{standard input}: Assembler messages:
{standard input}:750: Error: suffix or operands invalid for `mov'
{standard input}:751: Error: suffix or operands invalid for `mov'
{standard input}:845: Error: suffix or operands invalid for `mov'
{standard input}:846: Error: suffix or operands invalid for `mov'
{standard input}:897: Error: suffix or operands invalid for `mov'
{standard input}:898: Error: suffix or operands invalid for `mov'
{standard input}:900: Error: suffix or operands invalid for `mov'
{standard input}:912: Error: suffix or operands invalid for `mov'

alessandro suardi told me that this problem is solved using the
patch from:
  http://www.kernel.org/pub/linux/devel/binutils/linux-2.4-seg-4.patch

which are dated from march (2005-03-27) and therefore, about 3 months
old.

it's about time this gets into the official kernel. who is in charge
of it? (it's obviously not sufficient to report to lkml).

best regards,
herbert rosmanith


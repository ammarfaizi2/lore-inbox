Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWDMSrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWDMSrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWDMSrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:47:51 -0400
Received: from mail.linicks.net ([217.204.244.146]:10970 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932430AbWDMSru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:47:50 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: read-write constraint warnings
Date: Thu, 13 Apr 2006 19:47:41 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604131947.41199.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I see this has been raised before, but could not find a closure thread:

e.g.
include/asm/bitops.h:79: warning: read-write constraint does not allow a 
register

Since moving 2.6.15.7 --> 2.6.16.4 I get truck loads of these warnings.

nick@linuxamd:linux$ gcc -v
Reading specs from /usr/lib/gcc/i486-slackware-linux/3.4.0/specs
Configured 
with: ../gcc-3.4.0/configure --prefix=/usr --enable-shared --enable-threads=posix --enable-__cxa_atexit --disable-checking --with-gnu-ld --verbose --target=i486-slackware-linux --host=i486-slackware-linux
Thread model: posix
gcc version 3.4.0

nick@linuxamd:linux$ ld -v
GNU ld version 2.15.90.0.3 20040415

There is no problem as kernels built with these warnings are fine, so a GCC 
issue I presume?

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

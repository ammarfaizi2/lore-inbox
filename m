Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTEZRKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTEZRKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:10:30 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:49880 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id S261807AbTEZRK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:10:29 -0400
Date: Mon, 26 May 2003 19:22:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 patches: description.
Message-ID: <20030526172241.GA3748@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
10 patches for s390, some with important fixes - at least for s390.

Short descriptions:
1) Various s390 bug fixes. The most important is the one in pgtable.h.
   The bits for the invalid pages did not include the invalid bit ...
   This patch also contains the do_fork patch I sent to linux-arch.
2) Optimze s390 inline assemblies.
3) Add module alias support for ccw devices.
4) Add "steal lock" support to the common i/o layer. This is needed for dasd
   devices that have been reserved but not released. To get them going again
   you'll have to steal the lock.
5) Remove remaining MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT pairs from s390 code. 
6) 32 bit compatabiliy fixes. We now use the new compat ioctl mechanism.
   Define compat_alloc_user_space.
7) Bug fixes for the s390 block device drivers (dasd and xpram).
8) Bug fixes for the s390 console drivers (3215 and sclp).
9) Bug fixes for the s390 tape device driver.
10) Bug fixes for the s390 network devices drivers (ctc, lcs and iucv).

Patches are against linux-bk as of 2003/05/26.

blue skies,
  Martin.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTIQWG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 18:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbTIQWGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 18:06:55 -0400
Received: from [128.123.64.160] ([128.123.64.160]:54944 "EHLO
	hongkong.cs.nmsu.edu") by vger.kernel.org with ESMTP
	id S262859AbTIQWGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 18:06:54 -0400
Date: Wed, 17 Sep 2003 16:06:47 -0600
From: Ross Combs <rocombs@cs.nmsu.edu>
Message-Id: <200309172206.h8HM6l68019449@hongkong.cs.nmsu.edu>
To: linux-kernel@vger.kernel.org
Subject: link failure on 2.4.22 sparc64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed two problems compiling 2.4.22.

1) make xconfig doesn't like the font selection options.
   You can't select yes or no.  The other config programs
   worked fine.

2) If sysctl support is not selected everything compiles
   fine but the final link fails:
arch/sparc64/kernel/kernel.o: In function `sys32_sysctl':
arch/sparc64/kernel/kernel.o(.text+0x1a228): undefined reference to `do_sysctl'

It looks like the 32-bit compatibility wrapper for sysctl
needs to be conditionalized on CONFIG_SYSCTL.

Thanks,
-Ross

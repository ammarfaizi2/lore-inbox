Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265131AbUD3QN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265131AbUD3QN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbUD3QMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:12:10 -0400
Received: from aun.it.uu.se ([130.238.12.36]:59057 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265120AbUD3QLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:11:50 -0400
Date: Fri, 30 Apr 2004 18:11:46 +0200 (MEST)
Message-Id: <200404301611.i3UGBkdK026345@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [BUG] 2.6.6-rc2-bk5 mm/slab.c change broke x86-64 SMP
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The change to mm/slab.c between 2.6.6-rc2-bk4 and -bk5
broke x86-64 SMP. The symptoms are general protection
faults in __switch_to shortly after init starts, and
then the machine is dead. (Can't be more specific, my
box can't log early boot oopses.)

I'm only seeing this with x86-64 SMP; x86-64 UP and i386
SMP on the same machine (Athlon64 UP) have no problems.

Reverting 2.6.6-rc2-bk5's change to mm/slab.c eliminates
the problem.

/Mikael

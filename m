Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUAYR3I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUAYR3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:29:08 -0500
Received: from smtp06.auna.com ([62.81.186.16]:44970 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S264855AbUAYR3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:29:06 -0500
Date: Sun, 25 Jan 2004 18:29:04 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: mpspec.h, mach_mpspec.h
Message-ID: <20040125172904.GA3195@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I am trying to build sensors 2.8.3 and it fails with:

make: *** No rule to make target `mach_mpspec.h', needed by `kernel/chips/vt1211.d'.  Stop.

There is no mach_mpspec.h in include/linux nor include/linux/asm in the kernel
tree (I use 2.6.2-rc1-mm3). It is not included directly by sensors, but for
example, mpspec.h reads:

werewolf:/usr/src/linux/include/asm# grep mach_mpspec.h *
mpspec.h:#include <mach_mpspec.h>

all mach_mpspec.h are inside subarch dirs in include/asm (for example, 
include/asm/mach-default/). 

Workaround is to add -I/usr/src/linux/include/asm/mach-default.

But should not the contents be symlinked for the proper subarch ? IE

/usr/src/linux/include/asm/mach_mpspec.h -> mach-default/mach_mpspec.h

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc1-jam3 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))

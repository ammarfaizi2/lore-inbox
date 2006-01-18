Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWARSZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWARSZe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWARSZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:25:34 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:14098 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030189AbWARSZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:25:34 -0500
Message-ID: <43CE881A.1060403@shadowen.org>
Date: Wed, 18 Jan 2006 18:25:30 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: warning: read-write constraint -- 2.6.15-git8 onwards
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the following commit causes a bunch of warnings out of
most of the files in the kernel tree (see below for examples).  Backing
this out seems to cure them?

diff-tree 92934bcbf96bc9dc931c40ca5f1a57685b7b813b (from
636aab5ce332d88a76362797a55804c7da643467)`
tree eb9690ca6b23b5603429a8b3d290d6ca2545bcaf
parent 636aab5ce332d88a76362797a55804c7da643467
author Andi Kleen <ak@suse.de> 1137015752 +0100
committer Linus Torvalds <torvalds@g5.osdl.org> 1137034871 -0800

    [PATCH] i386/x86-64: Use input/output dependencies for bitops

    Noticed by Andreas Schwab

    Signed-off-by: Andi Kleen <ak@suse.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Compiled with:

    gcc version 3.3.4 (Debian 1:3.3.4-6sarge1)

-apw

  CC      arch/x86_64/kernel/process.o
include/asm/bitops.h: In function `default_idle':
include/asm/bitops.h:65: warning: read-write constraint does not allow a
register
include/asm/bitops.h:65: warning: read-write constraint does not allow a
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a
register
include/asm/bitops.h: In function `cpu_idle_wait':
include/asm/bitops.h:30: warning: read-write constraint does not allow a
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a
register
include/asm/bitops.h:65: warning: read-write constraint does not allow a
register
include/asm/bitops.h:65: warning: read-write constraint does not allow a
register
include/asm/bitops.h: In function `cpu_idle':
include/asm/bitops.h:30: warning: read-write constraint does not allow a
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a
register
include/asm/bitops.h: In function `set_personality_64bit':
include/asm/bitops.h:65: warning: read-write constraint does not allow a
register
include/asm/bitops.h:65: warning: read-write constraint does not allow a
register
include/asm/bitops.h: In function `copy_thread':
include/asm/bitops.h:30: warning: read-write constraint does not allow a
register
include/asm/bitops.h:30: warning: read-write constraint does not allow a
register
  CC      arch/x86_64/kernel/signal.o
include/asm/bitops.h: In function `do_notify_resume':
include/asm/bitops.h:65: warning: read-write constraint does not allow a
register
include/asm/bitops.h:65: warning: read-write constraint does not allow a
register

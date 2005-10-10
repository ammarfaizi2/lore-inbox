Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVJJQdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVJJQdw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 12:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVJJQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 12:33:52 -0400
Received: from ns2.suse.de ([195.135.220.15]:9876 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750889AbVJJQdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 12:33:51 -0400
Date: Mon, 10 Oct 2005 18:33:49 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
Subject: error: implicit declaration of function 'cpu_die'
Message-ID: <20051010163349.GA1381@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How can I fix this properly?
arch/ppc/kernel/idle.c includes linux/smp.h, which includes asm-smp.h
only if CONFIG_SMP is defined.
As a result, cpu_die remains undefined for non-SMP builds.

The include order was changed recently, as this kernel .config built ok with 2.6.13.
I see cpu_die was introduced recently in include/asm-ppc/smp.h, in 2.6.14-rc1.


  CC      arch/ppc/kernel/idle.o
arch/ppc/kernel/idle.c: In function 'default_idle':
arch/ppc/kernel/idle.c:58: error: implicit declaration of function 'cpu_die'
make[1]: *** [arch/ppc/kernel/idle.o] Error 1


-- 
short story of a lazy sysadmin:
 alias appserv=wotan

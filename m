Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVCXTCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVCXTCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 14:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbVCXTCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 14:02:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:53680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262651AbVCXTCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 14:02:35 -0500
Date: Thu, 24 Mar 2005 11:02:33 -0800
From: cliff white <cliffw@osdl.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: 2.6.12-rc1-mm2 - ppc32 build fails.
Message-ID: <20050324110233.55b5053a@es175>
Organization: OSDL
X-Mailer: Sylpheed-Claws 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Error message:

  CC      arch/ppc/kernel/setup.o
In file included from arch/ppc/kernel/setup.c:43:
include/asm/ppc_sys.h:29:2: #error "need definition of ppc_sys_devices"
In file included from arch/ppc/kernel/setup.c:43:
include/asm/ppc_sys.h:61: warning: parameter has incomplete type
include/asm/ppc_sys.h:64: warning: parameter has incomplete type
make[1]: *** [arch/ppc/kernel/setup.o] Error 1
make: *** [arch/ppc/kernel] Error 2

This fails for my config, and also for a defconfig build. 
We're thinking the patch 
"[PATCH] ppc32: PowerQUICC II Pro subarch support" 
( http://seclists.org/lists/linux-kernel/2005/Mar/1661.html )
may have hosed up the config, but haven't got that patch to cleanly revert yet.

cliffw

-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman

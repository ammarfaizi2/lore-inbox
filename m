Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271211AbTHHLTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 07:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271287AbTHHLTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 07:19:36 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:2961 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271211AbTHHLTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 07:19:35 -0400
Date: Fri, 8 Aug 2003 13:19:32 +0200 (MEST)
Message-Id: <200308081119.h78BJWQ5015656@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4 1/2] backport 2.6 x86 cpu capabilities
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003 22:54:30 -0400, Jeff Garzik wrote:
>(hopefully destined for 2.4.23-pre1)
>
>#
>#	include/asm-i386/msr.h	1.8     -> 1.9    
>#	include/asm-i386/cpufeature.h	1.5     -> 1.6    
>#	arch/i386/kernel/setup.c	1.70    -> 1.71   
>#
...
>-#define NCAPINTS	4	/* Currently we have 4 32-bit words worth of info */
>+#define NCAPINTS	6	/* Currently we have 6 32-bit words worth of info */

If you change NCAPINTS you also have to change the hardcoded
struct offset X86_VENDOR_ID in arch/i386/kernel/head.S. Otherwise
nasty stuff happen at boot since boot_cpu_data gets broken.

/Mikael

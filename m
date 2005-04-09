Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVDISZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVDISZa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 14:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVDISZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 14:25:29 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:63105 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261366AbVDISZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 14:25:22 -0400
Subject: memory_barrier
From: Bart De Schuymer <bdschuym@pandora.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 09 Apr 2005 18:34:56 +0000
Message-Id: <1113071696.3383.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any reason why __memory_barrier() is still referenced in the
kernel source?

grep -r memory_barrier gave the following back, which at first seems to
suggest barrier() is defined using some phantom __memory_barrier(),
quite deceiving...


include/linux/compiler-intel.h:#define barrier() __memory_barrier()
include/linux/compiler.h:# define barrier() __memory_barrier()
include/asm-m32r/system.h: * memory_barrier() for examples and URLs to more information.
include/asm-m32r/system.h: *      memory_barrier();
include/asm-m32r/system.h: *      memory_barrier();
include/asm-i386/system.h: * memory_barrier() for examples and URLs to more information.
include/asm-i386/system.h: *    memory_barrier();
include/asm-i386/system.h: *    memory_barrier();
include/asm-mips/system.h: * memory_barrier() for examples and URLs to more information.
include/asm-mips/system.h: *    memory_barrier();
include/asm-mips/system.h: *    memory_barrier();
include/asm-ia64/intel_intrin.h:void __memory_barrier(void);
include/asm-ia64/intel_intrin.h:#define ia64_barrier()          __memory_barrier()


cheers,
Bart



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935588AbWKZWtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935588AbWKZWtg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 17:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935599AbWKZWtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 17:49:35 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:3763 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S935588AbWKZWtf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 17:49:35 -0500
Date: Sun, 26 Nov 2006 22:49:28 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Build breakage ...
Message-ID: <20061126224928.GA22285@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ee3ce191e8eaa4cc15c51a28b34143b36404c4f5 breaks MIPS completely:

In file included from include/linux/bitops.h:9,
                 from include/linux/thread_info.h:20,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:46,
                 from arch/mips/kernel/asm-offsets.c:13:
include/asm/bitops.h: In function ‘set_bit’:
include/asm/bitops.h:100: warning: implicit declaration of function ‘BUILD_BUG_ON’
include/asm/bitops.h:100: warning: implicit declaration of function ‘typecheck’
include/asm/bitops.h:100: error: expected expression before ‘unsigned’
include/asm/bitops.h:102: error: expected expression before ‘unsigned’
include/asm/bitops.h: In function ‘clear_bit’:
include/asm/bitops.h:148: error: expected expression before ‘unsigned’
include/asm/bitops.h:150: error: expected expression before ‘unsigned’
include/asm/bitops.h: In function ‘change_bit’:
include/asm/bitops.h:198: error: expected expression before ‘unsigned’
include/asm/bitops.h:200: error: expected expression before ‘unsigned’

That sort of patches really should go to /dev/null so short before a release.

  Ralf

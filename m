Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUBRWwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267120AbUBRWwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:52:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:8918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266493AbUBRWw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:52:29 -0500
Date: Wed, 18 Feb 2004 14:52:18 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: ak@suse.de, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: kernel/microcode.c error from new 64bit code
Message-Id: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the mad rush to put in Intel 64 bit support, did anyone make sure and not
break the 32 bit build?

arch/i386/kernel/microcode.c: In function `do_update_one':
arch/i386/kernel/microcode.c:374: warning: cast from pointer to integer of different size
arch/i386/kernel/microcode.c:374: warning: cast from pointer to integer of different size
arch/i386/kernel/microcode.c:374: error: impossible register constraint in `asm'
arch/i386/kernel/microcode.c:389: confused by earlier errors, bailing out
make[1]: *** [arch/i386/kernel/microcode.o] Error 1
make[1]: Target `__build' not remade because of errors.
make: *** [arch/i386/kernel] Error 2

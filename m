Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263976AbUDNIdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbUDNIdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:33:06 -0400
Received: from math.ut.ee ([193.40.5.125]:20930 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S263976AbUDNIdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:33:02 -0400
Date: Wed, 14 Apr 2004 11:33:00 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.5+BK compile error: binfmt_elf on sparc64
Message-ID: <Pine.GSO.4.44.0404141104370.28974-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because of -Werror, it bails out:

In file included from arch/sparc64/kernel/binfmt_elf32.c:154:
fs/binfmt_elf.c: In function `load_elf_interp':
fs/binfmt_elf.c:369: warning: comparison is always false due to limited range of data type
fs/binfmt_elf.c: In function `load_elf_binary':
fs/binfmt_elf.c:780: warning: comparison is always false due to limited range of data type

It's the comparision "elf_ppnt->p_memsz > TASK_SIZE".

p_memsz is Elf32_Word, TASK_SIZE is defined as
#define TASK_SIZE       ((unsigned long)-VPTE_SIZE)

At the first glance I can't see what's wrong here.

-- 
Meelis Roos (mroos@linux.ee)



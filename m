Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275608AbRI2Lcz>; Sat, 29 Sep 2001 07:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275618AbRI2Lcp>; Sat, 29 Sep 2001 07:32:45 -0400
Received: from [62.98.227.123] ([62.98.227.123]:5892 "EHLO
	lisa.rhpk.springfield.inwind.it") by vger.kernel.org with ESMTP
	id <S275608AbRI2Lc3>; Sat, 29 Sep 2001 07:32:29 -0400
Date: Sat, 29 Sep 2001 13:27:11 +0200 (CEST)
From: Cristiano Paris <c.paris@libero.it>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.9-ac16 unresolved symbol
Message-ID: <Pine.LNX.4.33.0109291326050.1246-100000@lisa.rhpk.springfield.inwind.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens during modules_install phase :

mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.9-ac16; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.9-ac16/kernel/arch/i386/kerne
l/apm.o
depmod:         __sysrq_put_key_op_R5b6d6e73
depmod:         __sysrq_lock_table_R6eced4f5
depmod:         __sysrq_get_key_op_R9b40767f
depmod:         __sysrq_unlock_table_Rbd25cd87

Cristiano


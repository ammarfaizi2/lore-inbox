Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWF1Mxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWF1Mxx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 08:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932786AbWF1Mxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 08:53:49 -0400
Received: from aa001msr.fastwebnet.it ([85.18.95.64]:2765 "EHLO
	aa001msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932607AbWF1Mxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 08:53:48 -0400
Date: Wed, 28 Jun 2006 14:53:49 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unkillable process in last git -- 100% reproducible
Message-ID: <20060628145349.53873ccc@localhost>
In-Reply-To: <20060628142918.1b2c25c3@localhost>
References: <20060628142918.1b2c25c3@localhost>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 14:29:18 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> [  430.083347] localedef     R  running task       0  8577   8558  8578               (NOTLB)
> [  430.083352] gzip          X ffff81001e612ee0     0  8578   8577                     (L-TLB)
> [  430.083358] ffff81001395bef8 ffff81001fd1a310 0000000000000246 ffff81001e612ee0 
> [  430.083362]        ffff81001e4c0080 ffff81001e612ee0 ffff81001e4c0258 0000000000000001 
> [  430.083366]        0000000000000046 0000000000000046 ffff81001395bf18 0000000000000010 
> [  430.083370] Call Trace: <ffffffff80227f6f>{do_exit+2378} <ffffffff802628e9>{vfs_write+288}
> [  430.083379]        <ffffffff80228065>{sys_exit_group+0} <ffffffff80209806>{system_call+126}

do_exit() -- kernel/exit.c

0xffffffff80227f66 <do_exit+2369>:      mov    %rax,0x18(%rbp)
0xffffffff80227f6a <do_exit+2373>:      callq  0xffffffff8048b850 <schedule>
0xffffffff80227f6f <do_exit+2378>:      ud2a
0xffffffff80227f71 <do_exit+2380>:      pushq  $0xffffffff804b7821
0xffffffff80227f76 <do_exit+2385>:      retq   $0x3ba
0xffffffff80227f79 <do_exit+2388>:      jmp    0xffffffff80227f79 <do_exit+2388>

-- 
	Paolo Ornati
	Linux 2.6.17-ga39727f2-dirty on x86_64

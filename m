Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUJBJcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUJBJcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 05:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUJBJcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 05:32:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:22987 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267374AbUJBJcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 05:32:13 -0400
Date: Sat, 2 Oct 2004 02:29:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm1 build failure
Message-Id: <20041002022921.0e1aceb3.akpm@osdl.org>
In-Reply-To: <20041002091644.GA8431@gamma.logic.tuwien.ac.at>
References: <20041002091644.GA8431@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> ..
>    LD      .tmp_vmlinux1
>  arch/i386/kernel/built-in.o(.text+0x111f5): In function `end_level_ioapic_irq':
>  : undefined reference to `irq_mis_count'
>  kernel/built-in.o(.text+0x1eba7): In function `ack_none':
>  : undefined reference to `ack_APIC_irq'
>  make[1]: *** [.tmp_vmlinux1] Fehler 1
>  make[1]: Leaving directory `/usr/src/linux-2.6.9-rc3-mm1'

hm, that's clever.

See if arch/i386/kernel/io_apic.c needs

#include <asm/io_apic.h>

and if not, please send the .config.

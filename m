Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWJ3IbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWJ3IbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 03:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbWJ3IbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 03:31:11 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:39144 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751377AbWJ3IbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 03:31:09 -0500
Subject: Re: [PATCH] lockdep: annotate DECLARE_WAIT_QUEUE_HEAD
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       Greg KH <gregkh@suse.de>, Markus Lidel <markus.lidel@shadowconnect.com>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1162045659.24143.149.camel@taijtu>
References: <1162045659.24143.149.camel@taijtu>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 09:30:35 +0100
Message-Id: <1162197035.24333.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> kernel: INFO: trying to register non-static key.
> kernel: the code is fine but needs lockdep annotation.
> kernel: turning off the locking correctness validator.
> kernel:  [<c04051ed>] show_trace_log_lvl+0x58/0x16a
> kernel:  [<c04057fa>] show_trace+0xd/0x10
> kernel:  [<c0405913>] dump_stack+0x19/0x1b
> kernel:  [<c043b1e2>] __lock_acquire+0xf0/0x90d
> kernel:  [<c043bf70>] lock_acquire+0x4b/0x6b
> kernel:  [<c061472f>] _spin_lock_irqsave+0x22/0x32
> kernel:  [<c04363d3>] prepare_to_wait+0x17/0x4b
> kernel:  [<f89a24b6>] lpfc_do_work+0xdd/0xcc2 [lpfc]
> kernel:  [<c04361b9>] kthread+0xc3/0xf2
> kernel:  [<c0402005>] kernel_thread_helper+0x5/0xb
> 
> Another case of non-static lockdep keys; duplicate the paradigm set by
> DECLARE_COMPLETION_ONSTACK and introduce DECLARE_WAIT_QUEUE_HEAD_ONSTACK.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

for the Bluetooth subsystem part of this patch:

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel



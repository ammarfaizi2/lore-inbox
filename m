Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVA2JZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVA2JZW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 04:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbVA2JZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 04:25:22 -0500
Received: from smtp1gate.fmi.fi ([193.166.223.31]:62168 "EHLO smtp1gate.fmi.fi")
	by vger.kernel.org with ESMTP id S262884AbVA2JZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 04:25:16 -0500
Message-Id: <200501290925.j0T9P8fL021137@leija.fmi.fi>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0412302141320.2280@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Date: Sat, 29 Jan 2005 11:25:08 +0200 (EET)
From: Kari Hurtta <hurtta+linux-kernel@leija.mh.fmi.fi>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       wine-devel <wine-devel@winehq.com>
X-Mailer: ELM [version 2.4ME+ PL121c (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
X-Filter: smtp1gate: 3 received headers rewritten with id 20050129/22342/01
X-Filter: smtp1gate: ID 22342/01, 1 parts scanned for known viruses
X-Filter: torkku: ID 5400/01, 1 parts scanned for known viruses
X-Filter: leija.fmi.fi: ID 1893/01, 1 parts scanned for known viruses
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Reading just long long thread (actually from
gmane.comp.emulators.wine.devel) ]

<Pine.LNX.4.58.0412302141320.2280@ppc970.osdl.org>
Linus Torvalds <torvalds@osdl.org>:

> +
> +		/*
> +		 * Was the TF flag set by a debugger? If so, clear it now,
> +		 * so that register information is correct.
> +		 */
> +		if (tsk->ptrace & PT_DTRACE) {
> +			regs->eflags &= ~TF_MASK;
> +			tsk->ptrace &= ~PT_DTRACE;
                        =========================
> +			if (!tsk->ptrace & PT_DTRACE)
                             =======================
> +				goto clear_TF;
> +		}
>  	}

Perhaps, I'm stupid.

But is there something strange on that test of tsk->ptrace variable?

Before that PT_DTRACE was cleared from that same tsk->ptrace variable.

/ Kari Hurtta

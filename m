Return-Path: <linux-kernel-owner+w=401wt.eu-S932796AbXASRmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbXASRmN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932827AbXASRmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:42:13 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:64171 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932796AbXASRmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:42:12 -0500
Subject: Re: Regarding kernel opps after patchng lngo's RT_PREEMPT
From: Steven Rostedt <rostedt@goodmis.org>
To: Alim Akhtar <alim.akhtar@ttec.soc-soft.com>
Cc: tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <C5065F118AFB3D478B052FC1E9810D9C23AF9C@tec-mail.ttec.soc-soft.com>
References: <C5065F118AFB3D478B052FC1E9810D9C23AF9C@tec-mail.ttec.soc-soft.com>
Content-Type: text/plain
Date: Fri, 19 Jan 2007 12:41:14 -0500
Message-Id: <1169228474.31347.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ I believe you wanted LKML and not majordomo, also CC'd Ingo since he's
the maintainer of the -rt patch ]

On Fri, 2007-01-19 at 16:20 +0530, Alim Akhtar wrote:
> 
> Dear Steven/Thomas Gleixner
> 
> i am using linux.2.6.14 + patch-2.6.14-rt22 for a iMX21 based coustom
> board.

Could you try 2.6.20-rc5-rt7.  It's hard to debug a kernel that old.
Is there any reason you are not using the latest?

-- Steve

[ keeping rest of email for those that haven't read it yet. ]

> when i have ported the image to board i got the following error just
> after kernel completed its uncompression.
> 
> Uncompressing
> Linux........................................................... done
> vu Guillaume, booting the kernel.
> NOT Creating MX21 tags...Done.
> BUG: bad raw irq-flag value 600000d3, swapper/0!
> Function entered at [<c00232bc>] from [<c0053af0>]
>  r4 = C019E000
> Function entered at [<c0053aa0>] from [<c01777b8>]
> Function entered at [<c0177304>] from [<c0058534>]
> Function entered at [<c00584ec>] from [<c0178ba4>]
>  r8 = C001A0D0  r7 = 00000000  r6 = C01A8DD8  r5 = C0008708
>  r4 = C019E000
> Function entered at [<c0178b74>] from [<c0008708>]
>  r7 = C01AA2E4  r6 = C001B0C4  r5 = C01C37AC  r4 = 00053175
> Function entered at [<c00086f4>] from [<c00080a0>]
>  r5 = C01C37AC  r4 = 00053175
> ---------------------------
> | preempt count: 00000001 ]
> | 1-level deep critical section nesting:
> ----------------------------------------
> .. [<00000000>] .... .....[<00000000>] ..   ( <=
> ------------------------------
> | showing all locks held by: |  (swapper/0 [c01a8dd8, 120]):
> ------------------------------
> 
> #001:             [c01b42ac] {kernel_sem.lock}
> ... acquired at:
> 
> After the it is booting nornaly but after some time its comtinuosly
> throughing some BUG messeges...no clue how to solve this.
> i am attaching the whole capture file of boot process as well
> as .config file.
> one more thing, when i tried the same after disabling CONFIG_HARDIRQS,
> its worked fine.
> 
> please help me out in this.
> if any body have faced such problem, please give your vaulable
> suggestions.
> will be appricated.
> 
> Regards
> Alim Akhtar
> 
> 
> The information contained in this e-mail message and in any annexure is confidential to the  recipient and may contain privileged information. If you are not the intended recipient, please notify the sender and delete the message along with any annexure. You should not disclose, copy or otherwise use the information contained
> in the message or any annexure. Any views expressed in this e-mail are those of the individual sender except where the sender specifically states them to be the views of SoCrates Software India Pvt Ltd., Bangalore.

Sorry, but I'm forwarding it to LKML ;)



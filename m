Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVGMOqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVGMOqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 10:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVGMOqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 10:46:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51163 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262657AbVGMOqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 10:46:44 -0400
Date: Wed, 13 Jul 2005 16:45:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050713144551.GA26067@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507111538.22551.s0348365@sms.ed.ac.uk> <20050711144328.GA18244@elte.hu> <200507111650.33187.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507111650.33187.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Ours links to a company server with a consumer grade 1Mbit ADSL 
> connection, and transferring just about anything at 110K/s causes the 
> kernel to crash within about 10 seconds.
> 
> I wish you the best of luck with getting this going, and I apologise 
> in advance for the poor instructions.

it worked upon the first try, and indeed my testbox crashed within 10 
seconds:

 BUG: Unable to handle kernel NULL pointer dereference
 BUG: Unable to handle kernel NULL pointer dereference at virtual address 00000006
  printing eip:
 00000006
 *pde = 00000000
 Oops: 0000 [#1]
 PREEMPT
 Modules linked in:
 CPU:    0
 EIP:    0060:[<00000006>]    Not tainted VLI
 EFLAGS: 00010286   (2.6.12-RT-V0.7.51-30-debug)
 EIP is at 0x6
 eax: c057fef8   ebx: c0614340   ecx: c04490b8   edx: 00000001
 esi: c057ff34   edi: c0135d52   ebp: c057ff54   esp: c057ff3c
 ds: 007b   es: 007b   ss: 0068   preempt: 20000002

it was enough to "ssh 10.0.0.1" from the client, and typing "yes" would 
trigger the crash very soon.

thanks for the instructions - now i can start debugging this :-)

	Ingo

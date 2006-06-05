Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751217AbWFETo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWFETo7 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 15:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWFETo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 15:44:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:22691 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751217AbWFETo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 15:44:59 -0400
Date: Mon, 5 Jun 2006 21:44:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Martin Bligh <mbligh@google.com>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605194422.GB14709@elte.hu>
References: <44845C27.3000006@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44845C27.3000006@google.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin Bligh <mbligh@google.com> wrote:

> panic on NUMA-Q during LTP. Was fine in -mm2.
> 
> BUG: unable to handle kernel paging request at virtual address 22222232

> EIP is at check_deadlock+0x19/0xe1
> eax: 00000001   ebx: e4453030   ecx: 00000000   edx: e4008000
> esi: 22222222   edi: 00000001   ebp: 22222222   esp: e47ebec0

again these 0x22222222 entries on the stack. What on earth does this? 
Andy got a similar crash on x86_64, with a 0x2222222222222222 entry ...

nothing of our magic values are 0x22 or 0x222222222.

	Ingo

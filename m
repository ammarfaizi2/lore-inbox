Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbULOG17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbULOG17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 01:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbULOG17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 01:27:59 -0500
Received: from [194.90.79.130] ([194.90.79.130]:37137 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S261905AbULOG16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 01:27:58 -0500
Message-ID: <41BFD966.4010303@argo.co.il>
Date: Wed, 15 Dec 2004 08:27:50 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
References: <41BA698E.8000603@mvista.com> <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com> <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random> <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu>
In-Reply-To: <20041214222307.GB22043@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2004 06:27:56.0821 (UTC) FILETIME=[372DC450:01C4E26F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>+	if (__kernel_text_address(regs->eip) && *(char *)regs->eip == 0xf4)
>  
>
shouldn't that cast be (unsigned char *), otherwise the test will always 
fail?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.


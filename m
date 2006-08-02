Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWHBH0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWHBH0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWHBH0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:26:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:31394 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751321AbWHBH0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:26:17 -0400
Message-ID: <44D0538A.3090600@sgi.com>
Date: Wed, 02 Aug 2006 09:26:02 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Jay Lan <jlan@sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Balbir Singh <balbir@in.ibm.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: Re: [patch 3/3] convert CONFIG tag for a few accounting data used
 by CSA
References: <44CE58AF.7030200@sgi.com> <44CE6AE7.8020304@watson.ibm.com>
In-Reply-To: <44CE6AE7.8020304@watson.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Jay Lan wrote:
>> There were a few accounting data/macros that are used in CSA
>> but are #ifdef'ed inside CONFIG_BSD_PROCESS_ACCT. This patch is
>> to change those ifdef's from CONFIG_BSD_PROCESS_ACCT to
>> CONFIG_CSA_ACCT. A few defines are moved from kernel/acct.c and
>> include/linux/acct.h to kernel/csa.c and include/linux/csa_kern.h.
>>
>>
>> Signed-off-by:  Jay Lan <jlan@sgi.com>

[snip]

>> +#ifdef CONFIG_CSA_ACCT
>> +extern void acct_update_integrals(struct task_struct *tsk);
>> +extern void acct_clear_integrals(struct task_struct *tsk);
>> +#else
>> +#define acct_update_integrals(x)	do { } while (0)
>> +#define acct_clear_integrals(task)	do { } while (0)
>> +#endif
>> +
> 
> static inlines preferred

Huh? Is that a preference to the taskstat project? For the kernel
itself it makes no difference.

Cheers,
Jes

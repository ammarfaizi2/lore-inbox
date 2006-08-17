Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWHQMSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWHQMSY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWHQMSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:18:24 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:63886 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932231AbWHQMSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:18:23 -0400
Date: Thu, 17 Aug 2006 16:39:52 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 3/7] UBC: ub context and inheritance
Message-ID: <20060817110952.GD19127@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <44E33893.6020700@sw.ru> <44E33C04.50803@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E33C04.50803@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:38:44PM +0400, Kirill Korotaev wrote:
> Contains code responsible for setting UB on task,
> it's inheriting and setting host context in interrupts.
> 
> Task references three beancounters:
>   1. exec_ub  current context. all resources are
>               charged to this beancounter.
>   2. task_ub  beancounter to which task_struct is
>               charged itself.
>   3. fork_sub beancounter which is inherited by
>               task's children on fork

Is there a case where exec_ub and fork_sub can differ? I dont see that
in the patch.

-- 
Regards,
vatsa

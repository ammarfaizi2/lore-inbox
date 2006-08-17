Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWHQNUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWHQNUH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWHQNUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:20:06 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:65038 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932476AbWHQNUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:20:05 -0400
Message-ID: <44E46D5B.8080209@sw.ru>
Date: Thu, 17 Aug 2006 17:21:31 +0400
From: "Pavel V. Emelianov" <xemul@sw.ru>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: vatsa@in.ibm.com, devel@openvz.org
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Devel] Re: [ckrm-tech] [RFC][PATCH 3/7] UBC: ub context and
 inheritance
References: <44E33893.6020700@sw.ru> <44E33C04.50803@sw.ru> <20060817110952.GD19127@in.ibm.com>
In-Reply-To: <20060817110952.GD19127@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Wed, Aug 16, 2006 at 07:38:44PM +0400, Kirill Korotaev wrote:
>   
>> Contains code responsible for setting UB on task,
>> it's inheriting and setting host context in interrupts.
>>
>> Task references three beancounters:
>>   1. exec_ub  current context. all resources are
>>               charged to this beancounter.
>>   2. task_ub  beancounter to which task_struct is
>>               charged itself.
>>   3. fork_sub beancounter which is inherited by
>>               task's children on fork
>>     
>
> Is there a case where exec_ub and fork_sub can differ? I dont see that
> in the patch.
>   
Look in context changing in interrupts - "set_exec_ub(&ub0);" is done there.


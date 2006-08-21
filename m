Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWHUK33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWHUK33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWHUK33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:29:29 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:11090 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751843AbWHUK32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:29:28 -0400
Message-ID: <44E98BA5.8010605@sw.ru>
Date: Mon, 21 Aug 2006 14:32:05 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 3/7] UBC: ub context and inheritance
References: <44E33893.6020700@sw.ru>  <44E33C04.50803@sw.ru> <1155931423.26155.74.camel@linuxchandra>
In-Reply-To: <1155931423.26155.74.camel@linuxchandra>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Wed, 2006-08-16 at 19:38 +0400, Kirill Korotaev wrote:
> 
>>Contains code responsible for setting UB on task,
>>it's inheriting and setting host context in interrupts.
>>
>>Task references three beancounters:
>>  1. exec_ub  current context. all resources are
>>              charged to this beancounter.
>>  2. task_ub  beancounter to which task_struct is
>>              charged itself.
> 
> 
> I do not see why task_ub is needed ? i do not see it being used
> anywhere.
it is used to charge task itself. will be heavily used in next patch set
adding "numproc" UBC parameter.

>>  3. fork_sub beancounter which is inherited by
>>              task's children on fork
> 
> 
>>From other emails it looks like renaming fork/exec to be real/effective
> will be easier to understand.
there is no "real". exec_ub is effective indeed,
but fork_sub is the one to inherit on fork().

Kirill


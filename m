Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWHQNxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWHQNxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWHQNxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:53:23 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:23437 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964998AbWHQNw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:52:58 -0400
Message-ID: <44E47547.8030702@sw.ru>
Date: Thu, 17 Aug 2006 17:55:19 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
References: <44E33893.6020700@sw.ru> <20060817110237.GA19127@in.ibm.com>
In-Reply-To: <20060817110237.GA19127@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 16, 2006 at 07:24:03PM +0400, Kirill Korotaev wrote:
> 
>>As the first step we want to propose for discussion
>>the most complicated parts of resource management:
>>kernel memory and virtual memory.
> 
> Do you have any plans to post a CPU controller? Is that tied to UBC
> interface as well?

Not everything at once :) To tell the truth I think CPU controller
is even more complicated than user memory accounting/limiting.

No, fair CPU scheduler is not tied to UBC in any regard.
As we discussed before, it is valuable to have an ability to limit
different resources separately (CPU, disk I/O, memory, etc.).
For example, it can be possible to place some mission critical
kernel threads (like kjournald) in a separate contanier.

This patches are related to kernel memory and nothing more :)

Thanks,
Kirill


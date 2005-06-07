Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVFGVcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVFGVcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 17:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVFGVbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 17:31:08 -0400
Received: from quark.didntduck.org ([69.55.226.66]:8096 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261991AbVFGVas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 17:30:48 -0400
Message-ID: <42A61227.9090402@didntduck.org>
Date: Tue, 07 Jun 2005 17:31:19 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: christoph <christoph@scalex86.org>, Christoph Hellwig <hch@infradead.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move some more structures into "mostly_readonly"
References: <Pine.LNX.4.62.0506071128220.22950@ScMPusgw>	 <20050607194123.GA16637@infradead.org>	 <Pine.LNX.4.62.0506071258450.2850@ScMPusgw> <1118177949.5497.44.camel@laptopd505.fenrus.org>
In-Reply-To: <1118177949.5497.44.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2005-06-07 at 12:59 -0700, christoph wrote:
> 
>>On Tue, 7 Jun 2005, Christoph Hellwig wrote:
>>
>>
>>>On Tue, Jun 07, 2005 at 11:30:03AM -0700, christoph wrote:
>>>
>>>>Move syscall table, timer_hpet and the boot_cpu_data into the "mostly_readonly" section.
>>>
>>>the syscall table should be completely readonly.
>>
>>Why was it in .data in the first place? There must be some reason why it 
>>was writable?
> 
> 
> probably a historic oversight.
> 

It doesn't really matter.  .rodata isn't actually mapped read-only. 
Doing so would break up the large pages used to map the kernel.

--
				Brian Gerst

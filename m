Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263348AbUJ2OZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbUJ2OZq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263352AbUJ2OZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:25:46 -0400
Received: from mailserv.intranet.GR ([146.124.14.106]:27798 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id S263348AbUJ2OY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:24:59 -0400
Message-ID: <4182519D.3020205@intracom.gr>
Date: Fri, 29 Oct 2004 17:20:13 +0300
From: Pantelis Antoniou <panto@intracom.gr>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.7.3) Gecko/20040920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Tom Rini <trini@kernel.crashing.org>,
       Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix early request_irq
References: <41824E15.4090906@intracom.gr> <20041029141648.GB25204@elte.hu>
In-Reply-To: <20041029141648.GB25204@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Pantelis Antoniou <panto@intracom.gr> wrote:
>
>  
>
>>Hi there
>>
>>The recent consolidation of the IRQ code has caused
>>a number of PPC embedded cpus to stop working.
>>
>>The problem is that on init_IRQ these platforms call
>>request_irq very early, which in turn calls kmalloc
>>without the memory subsystem being initialized.
>>
>>The following patch fixes it by keeping a small static
>>array of irqactions just for this purpose.
>>    
>>
>
>this is quite broken. Those places should use setup_irq(),
>not request_irq().
>
>	Ingo
>
>
>  
>
Sorry, didn't know about setup_irq.

Will fix.

Regards



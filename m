Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVA0UqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVA0UqW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVA0Un1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:43:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53719 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261178AbVA0UlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:41:05 -0500
Date: Thu, 27 Jan 2005 15:40:48 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christoph Hellwig <hch@infradead.org>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <20050127203206.GA2180@infradead.org>
Message-ID: <Pine.LNX.4.61.0501271539550.13927@chimarrao.boston.redhat.com>
References: <20050127101117.GA9760@infradead.org> <20050127101322.GE9760@infradead.org>
 <20050127202335.GA2033@infradead.org> <20050127202720.GA12390@infradead.org>
 <20050127203206.GA2180@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, Christoph Hellwig wrote:

>> +unsigned long arch_align_stack(unsigned long sp)
>> +{
>> +	if (randomize_va_space)
>> +		sp -= ((get_random_int() % 4096) << 4);
>> +	return sp & ~0xf;
>> +}
>
> this looks like it'd work nicely on all architectures.

I guess it should work for all architectures using ELF,
not sure if it might break some of the more obscure
architectures ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

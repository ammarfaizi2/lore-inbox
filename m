Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315280AbSEABXn>; Tue, 30 Apr 2002 21:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSEABXm>; Tue, 30 Apr 2002 21:23:42 -0400
Received: from holomorphy.com ([66.224.33.161]:20432 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315280AbSEABXl>;
	Tue, 30 Apr 2002 21:23:41 -0400
Date: Tue, 30 Apr 2002 18:22:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>, Patricia Gaughen <gone@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] discontigmem support for ia32 NUMA box against 2.4.19pre7
Message-ID: <20020501012213.GA32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>,
	Patricia Gaughen <gone@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200204300115.g3U1FQc16634@w-gaughen.des.beaverton.ibm.com> <20020430072654.B2262@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2002 at 06:15:26PM -0700, Patricia Gaughen wrote:
>> +#ifdef CONFIG_SMP
>> +	/*
>> +	 * But first pinch a few for the stack/trampoline stuff
>> +	 * FIXME: Don't need the extra page at 4K, but need to fix
>> +	 * trampoline before removing it. (see the GDT stuff)
>> +	 */
>> +	reserve_bootmem_node(NODE_DATA(0), PAGE_SIZE, PAGE_SIZE);
>> +#endif

On Tue, Apr 30, 2002 at 07:26:54AM +0100, Christoph Hellwig wrote:
> Umm, NUMA without SMP looks rather strange to me..

It's still fully possible, though I'm not clear on whether NUMA-Q
supports it. A number of the usual techniques would degenerate to
a sort of priority ordering on memory regions. I could imagine it
being put to some use to accommodate caches that only cache some
regions of physical memory and not others, though it is perhaps a
bit far-fetched because few systems like that are still used.


Cheers,
Bill

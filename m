Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUCUH7X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 02:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbUCUH7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 02:59:23 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:19598 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263620AbUCUH7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 02:59:20 -0500
Message-ID: <405D4B54.4040208@cyberone.com.au>
Date: Sun, 21 Mar 2004 18:59:16 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
References: <1079651064.8149.158.camel@arrakis> <20040318165957.592e49d3.pj@sgi.com> <1079659184.8149.355.camel@arrakis> <20040318175654.435b1639.pj@sgi.com> <1079737351.17841.51.camel@arrakis> <20040319165928.45107621.pj@sgi.com> <20040320031843.GY2045@holomorphy.com> <20040320000235.5e72040a.pj@sgi.com> <20040320111340.GA2045@holomorphy.com> <20040320201954.65e35bb1.pj@sgi.com> <20040321043622.GU2045@holomorphy.com>
In-Reply-To: <20040321043622.GU2045@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Sat, Mar 20, 2004 at 08:19:54PM -0800, Paul Jackson wrote:
>
>>Find by me if folks have their dirty laundry.  There are limits to my
>>powers to set things right.
>>Sorry to have provoked your length explanation of physical_balance, but
>>in the version of the kernel that I happened to do my research on,
>>2.6.3-rc1-mm1, this is _dead_ code.  The variable physical_balance is
>>never read, just written, and only appears on 3 lines total.
>>Obviously if it is in use in current versions of the kernel, then it's
>>not dead code anymore (at least not without a more profound
>>understanding of what's going on, which I make no claims to).
>>
>
>There's probably something in -mm reducing its use that I haven't
>looked at; the digression there was based on mainline.
>
>

I think it is my patch that makes cpu_sibling_map a cpumask.

You don't need a special case for num_siblings == 2 anymore.
I forgot to clean up the last trace of physical_balance.


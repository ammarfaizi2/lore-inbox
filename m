Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWEICCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWEICCZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 22:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWEICCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 22:02:25 -0400
Received: from dvhart.com ([64.146.134.43]:25058 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751345AbWEICCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 22:02:25 -0400
Message-ID: <445FF82A.2080106@mbligh.org>
Date: Mon, 08 May 2006 19:02:18 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Erik Mouw <erik@harddisk-recovery.com>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
References: <200605051010.19725.jasons@pioneer-pra.com>	 <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org>	 <1147100149.2888.37.camel@laptopd505.fenrus.org>	 <20060508152255.GF1875@harddisk-recovery.com> <1147102290.2888.41.camel@laptopd505.fenrus.org> <445FF714.4050803@yahoo.com.au>
In-Reply-To: <445FF714.4050803@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Arjan van de Ven wrote:
> 
>>> ... except that any kernel < 2.6 didn't account tasks waiting for disk
>>> IO.
>>>
>>
>> they did. It was "D" state, which counted into load average.
>>
> 
> Perhaps kernel threads in D state should not contribute toward load avg.
> 
> Userspace does not care whether there are 2 or 20 pdflush threads waiting
> for IO. However, when the network/disks can no longer keep up, userspace
> processes will end up going to sleep in writeback or reclaim -- *that* is
> when we start feeling the load.

Personally I'd be far happier having separated counters for both. Then
we can see what the real bottleneck is. Whilst we're at it, on a per-cpu
and per-elevator-queue basis ;-)

M.

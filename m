Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUAYDP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 22:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUAYDP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 22:15:28 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:6859 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263595AbUAYDP1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 22:15:27 -0500
Message-ID: <401333BF.3070500@cyberone.com.au>
Date: Sun, 25 Jan 2004 14:10:55 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Fix CONFIG_SMT oops on UP
References: <Pine.LNX.4.58.0401241303070.26103@montezuma.fsmlabs.com> <20040124153910.2421e35a.akpm@osdl.org> <Pine.LNX.4.58.0401241907120.643@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0401241907120.643@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Zwane Mwaikambo wrote:

>On Sat, 24 Jan 2004, Andrew Morton wrote:
>
>
>>Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>>
>>>+	cpu_sibling_map[0] = CPU_MASK_NONE;
>>>
>>alas, this will not compile with NR_CPUS > 4*BITS_PER_LONG because this:
>>
>>	#define CPU_MASK_NONE   { {[0 ... CPU_ARRAY_SIZE-1] =  0UL} }
>>
>>is not a suitable rhs - it can only be used for initalisers.  Fixing this
>>would be appreciated.
>>
>>Meanwhile, I'll use cpus_clear() in there.
>>
>
>There was actually other breakage too, so how about;
>

Thanks very much Zwane.



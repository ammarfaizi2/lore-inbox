Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbUAUJXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 04:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbUAUJXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 04:23:08 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:17672 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265874AbUAUJWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 04:22:54 -0500
Message-ID: <400E47CB.5030000@aitel.hist.no>
Date: Wed, 21 Jan 2004 10:35:07 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: GCS <gcs@lsc.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5 dies booting, possibly ipv6 related
References: <20040120000535.7fb8e683.akpm@osdl.org>	<400D083F.6080907@aitel.hist.no>	<20040120175408.GA12805@lsc.hu> <20040120102302.47fa26cd.akpm@osdl.org>
In-Reply-To: <20040120102302.47fa26cd.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> GCS <gcs@lsc.hu> wrote:
> 
>>Offtopic ps:Sorry that I can not help further now, I kicked a door too
>> badly that I think I broke my little finger on my leg. :-( But it would
>> worth to try without CONFIG_REGPARM as Helge noted he has it turned on,
>> and at least I also have it as Y.
[...]
> So yes, whatever compiler you are using, turn off CONFIG_REGPARM - it is
> still very experimental.

I turned it off, and turned on debugging for stack and memory allocations.
It still crashes at boot time, in a slightly different way.
I got an "endless" amount of
[<c011f202>] register_proc_table+0xc0/0xd6
scrolling by at high speed.  After a minute or so it ended with
addr_conf_init
inet6_init
oo_initcalls
init
init
kernel_thread_helper


I have ipv6 compiled into the kernel, others with the same problem
seems to have this common factor.  

Helge Hafting


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUITQBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUITQBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 12:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUITQBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 12:01:37 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:15530 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S266538AbUITQBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:01:36 -0400
Message-ID: <414EF6FA.10102@drdos.com>
Date: Mon, 20 Sep 2004 09:27:54 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Max Michaels <mmichaels@rightmedia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-r1 mem issues
References: <0FC82FC6709BE34CB9118EE0E252FD2307994E70@ehost007.exch005intermedia.net>
In-Reply-To: <0FC82FC6709BE34CB9118EE0E252FD2307994E70@ehost007.exch005intermedia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max,

I reported the same problem. There is a patch that gets around this, 
however, it does
Ooops in some situations in free_pages if you are using split address space
AND low memory conditions. Nick Piggin has the patch.

Jeff


Max Michaels wrote:

>This is my first post, so please be forgiving of any faux-pas. I am
>having issues with 2.6.8-r1 with memory being eaten by the kernel. Top
>reveals that only about 35% of the memory (3GB) is being used but the
>actual count of free memory is only about 10MB. /proc/slabinfo shows no
>odd numbers and /proc/meminfo shows the same 10MB as the top total. No
>processes account for this memory, so I'm assuming it must be the
>kernel. Eventually, I run out of memory and OOM-killer starts killing
>processes until it has some memory. Is there some troubleshooting method
>I am missing or is this a known issue?
>
>  
>


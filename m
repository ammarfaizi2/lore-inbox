Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbTFBSeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbTFBSeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:34:16 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:14728 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264833AbTFBSeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:34:12 -0400
Message-ID: <3EDB9BC9.8010703@namesys.com>
Date: Mon, 02 Jun 2003 22:47:37 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARKS] 2.5.70 for 4 filesystems
References: <20030531163339.GA9426@rushmore.suse.lists.linux.kernel> <p73add36p8n.fsf@oldwotan.suse.de>
In-Reply-To: <p73add36p8n.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should expect V3 to be slow at quad CPU smp benchmarks because 
balancing is giant locked.   V4 fixes this with fine grained locking, we 
hope to release at Linux Tag in July.  Fortunately quad CPU boxes will 
not be economical compared to dual CPU boxes until V4 has been out for a 
while....;-)  V4 CPU  usage and general performance has gotten a lot 
better, we need to put a new snapshot on our website.....

Andi Kleen wrote:

>rwhron@earthlink.net writes: 
>  
>
>>                  --------------- Sequential ----------
>>                  ----- Create -----   ---- Delete ----
>>                   /sec  %CPU    Eff   /sec  %CPU   Eff
>>2.5.70-reiserfs    7584  86.7   8751   2628  37.3  7038
>>2.5.70-xfs         1710  39.3   4347   2053  28.3  7247
>>2.5.70-ext2         150  99.0    151  60883 100.0  6088
>>2.5.70-ext3         119  95.0    126  26319  87.7  3002
>>    
>>
>
>It's quite surprising that reiserfs is so slow at deletion. In my
>normal experience reiserfs rm -rf is much faster than anything else
>(e.g. with a big rm -rf on an ext2 you have a chance to ctrl-c still,
>on reiserfs no such chance; XFS is really slow at this). Perhaps this
>is some 2.5 regression? Do you have 2.4 comparison numbers?
>
>-Andi 
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


-- 
Hans



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTIPPFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbTIPPFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:05:16 -0400
Received: from dyn-ctb-210-9-243-132.webone.com.au ([210.9.243.132]:33286 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261887AbTIPPFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:05:10 -0400
Message-ID: <3F672689.40404@cyberone.com.au>
Date: Wed, 17 Sep 2003 01:04:41 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       David Yu Chen <dychen@stanford.edu>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu, David Woodhouse <dwmw2@infradead.org>,
       linux-mtd@lists.infradead.org
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030916065553.GA12329@wohnheim.fh-wedel.de> <3F672396.10906@techsource.com>
In-Reply-To: <3F672396.10906@techsource.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Timothy Miller wrote:

>
>>> 276:    /* OK, it's not open. Create cache info for it */
>>> START -->
>>> 277:    mtdblk = kmalloc(sizeof(struct mtdblk_dev), GFP_KERNEL);
>>> 278:    if (!mtdblks)
>>> END -->
>>> 279:        return -ENOMEM;
>>
>
>>
>> Invalid.  This is quite an obvious false positive, at least if your
>> algorithm checks for possible value ranges.
>
>
> Wait... one is "mtdblk", and the other is "mtdblks".  One has an extra 
> 's' on it.  Unless there is some kind of aliasing going on, they would 
> appear to be different variables.  Naturally, I didn't check the 
> original code, so I could be full of it.  :)


Yes its a bug from glancing at the source code.



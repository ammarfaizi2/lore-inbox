Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUFLDap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUFLDap (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 23:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264622AbUFLDap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 23:30:45 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:10437 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S264610AbUFLDan
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 23:30:43 -0400
Message-ID: <40CA75CA.2030209@linuxmail.org>
Date: Sat, 12 Jun 2004 13:17:30 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Pavel Machek <pavel@suse.cz>, mochel@digitalimplant.org,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: Fix memory leak in swsusp
References: <20040609130451.GA23107@elf.ucw.cz> <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au> <20040610105629.GA367@gondor.apana.org.au> <20040610212448.GD6634@elf.ucw.cz> <20040610233707.GA4741@gondor.apana.org.au> <20040611094844.GC13834@elf.ucw.cz> <20040611101655.GA8208@gondor.apana.org.au> <20040611102327.GF13834@elf.ucw.cz> <20040611110314.GA8592@gondor.apana.org.au>
In-Reply-To: <20040611110314.GA8592@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Herbert Xu wrote:

[...]

> +			pm_pagedir_nosave =
> +				memcpy(m, old_pagedir,
> +				       PAGE_SIZE << pagedir_order);

[...]

> +		pagedir_nosave =
> +			memcpy(m, old_pagedir, PAGE_SIZE << pagedir_order);
>  	}
>  
>  	c = eaten_memory;

We were avoiding the use of memcpy because it messes up the preempt count with 3DNow, and 
potentially as other unseen side effects. The preempt could possibly simply be reset at resume time, 
but the point remains.

Regards,

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (417) 100 574 (mobile)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVAGA6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVAGA6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVAGAsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:48:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:31718 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261176AbVAGApl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:45:41 -0500
Message-ID: <41DDD6FA.2050403@osdl.org>
Date: Thu, 06 Jan 2005 16:25:30 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Andrew Morton <akpm@osdl.org>, Linas Vepstas <linas@austin.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] kernel/printk.c  lockless access
References: <20050106195812.GL22274@austin.ibm.com> <20050106161241.11a8d07c.akpm@osdl.org> <20050107002648.GD14239@krispykreme.ozlabs.ibm.com>
In-Reply-To: <20050107002648.GD14239@krispykreme.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
>  
> 
>>We faced the same problem in the Digeo kernel.  When the kernel oopses we
>>want to grab the last kilobyte or so of the printk buffer and stash it into
>>nvram.  We did this via a function which copies the data rather than
>>exporting all those variables, which I think is a nicer and more
>>maintainable approach:
> 
> 
> Actually Id love to do this on ppc64 too. Its always difficult to get a
> customer to remember to save away an oops report.

We need /proc/kallsyms, /proc/modules, etc. also....
can you capture all of that for a complete oops/panic analysis?
(short of kdump, that is)

-- 
~Randy

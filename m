Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVJJSUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVJJSUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVJJSUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:20:47 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:34461 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S1751150AbVJJSUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:20:46 -0400
Message-ID: <434AB0BE.3080206@mysql.com>
Date: Mon, 10 Oct 2005 20:19:42 +0200
From: Jonas Oreland <jonas@mysql.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050911
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
CC: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       discuss@x86-64.org
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced
 TSCs
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <20051007122624.GA23606@tentacle.sectorb.msk.ru> <200510071431.47245.ak@suse.de> <20051008101153.GA1541@tentacle.sectorb.msk.ru> <1128967404.8195.419.camel@cog.beaverton.ibm.com> <20051010181216.GA21548@tentacle.sectorb.msk.ru>
In-Reply-To: <20051010181216.GA21548@tentacle.sectorb.msk.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

check http://bugzilla.kernel.org/show_bug.cgi?id=5283

/Jonas

Vladimir B. Savkin wrote:
> On Mon, Oct 10, 2005 at 11:03:24AM -0700, john stultz wrote:
> 
>>>From your dmesg, it appears that there are no other timesources other
>>then the TSC available on your hardware. So I'm guessing idle=poll is
>>keeping the CPUs from halting the TSC and keeping them synched. 
>>
>>
>>I would think that the ACPI PM timer would be supported, but I don't see
>>anything about it in your dmesg. Could you make sure it is properly
>>configured in?
> 
> 
> Yes, I tried different combinations of PM_TIMER and HPET options.
> In this try, PM_TIMER was definetly enabled in kernel config.
> 
> What kind of kernel message did you expect from workibf PM timer?
> 
> ~
> :wq
>                                         With best regards, 
>                                            Vladimir Savkin. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


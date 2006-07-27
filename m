Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWG0BSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWG0BSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 21:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWG0BSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 21:18:04 -0400
Received: from [210.76.114.181] ([210.76.114.181]:13288 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1751840AbWG0BSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 21:18:02 -0400
Message-ID: <44C81444.9090706@ccoss.com.cn>
Date: Thu, 27 Jul 2006 09:17:56 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH 2/2] usbhid: HID device simple driver interface
References: <44C746F1.6090601@ccoss.com.cn> <20060726161055.GB28284@filer.fsl.cs.sunysb.edu> <200607270154.14021.arnd.bergmann@de.ibm.com>
In-Reply-To: <200607270154.14021.arnd.bergmann@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Well, That change from macro to inline function is more bettter idea.

    Regarding the Documentation/newwhere, I also have such plan to
complete it, but need some time.
We will have it.

    Regarding list_* marco, I really apologize, they wrote when I
implemented matched_lock/simple_lock
as spin lock. As I found this design have some restrictions, I replace
spin lock with semaphore, but leave these macro in header. I will clear
them.

    For Patch splitting, I can not find more words in Documentation/,
however, It seem Arnd are right.
The next version of this patch will join core patch and header patch.

    Last, I had tried again and again, but mail client still replace TAB
with spaces, I think I should replace it with another.
   
    Thanks a lot.

Arnd Bergmann wrote:
> On Wednesday 26 July 2006 18:10, Josef Sipek wrote:
>   
>> You should use (hid) instead of hid. Because of how the pre-processor works.
>>
>>     
>
> Or, even better, use an inline function instead of a macro whereever
> possible.
>
> One more thing, the description for patch 1 can probably be refined
> a bit more and put into Documentation/somewhere as a new file.
>
> Regarding the split of the patch, it's usually a bad idea to 
> put the header file into a separate patch from its users.
> E.g. if someone during debugging tries to revert patch 2 but not
> patch 1, he ends up with a broken build.
>
> 	Arnd <><
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
>   


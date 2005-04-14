Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVDNHSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVDNHSG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 03:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVDNHSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 03:18:06 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:65221 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261449AbVDNHSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 03:18:01 -0400
Message-ID: <425E190E.6000809@labs.fujitsu.com>
Date: Thu, 14 Apr 2005 16:17:34 +0900
From: tsuchiya yoshihiro <yt@labs.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: arjanv@redhat.com, yt@labs.fujitsu.com
Subject: Re: SLEEP_ON_BKLCHECK
References: <425DBC76.60804@labs.fujitsu.com> <1113461190.6293.1.camel@laptopd505.fenrus.org>
In-Reply-To: <1113461190.6293.1.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Thu, 2005-04-14 at 09:42 +0900, tsuchiya yoshihiro wrote:
>  
>
>>Hi,
>>In Fedora Core3, interruptible_sleep_on() checks if the system is
>>lock_kernel()'ed
>>by SLEEP_ON_BKLCHECK. Same thing is done in RedHatEL4.
>>Also I found a patch including SLEEP_ON_BKLCHECK was posted before,
>>but is not included in 2.6.11.
>>Why SLEEP_ON_BKLCHECK checks lock_kernel ?
>>    
>>
>
>Because you really need to hold the BKL when you call sleep_on() family
>of APIs, otherwise you have a very big race.
>
>Also note that you in your code really should not call any of the
>sleep_on() family of functions at all! It is a very very deprecated and
>defective API!!!!
>
>  
>
Oh, I did not know that.
What do you use instead? I found wait_event. Is that what you use?

Actually, I am porting my friend's code that runs on 2.4.X to 2.6.
How is sleep_on in 2.4? You should not use sleep_on in 2.4 also?

Thank you,
Yoshi Tsuchiya


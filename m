Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWG2X6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWG2X6g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 19:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWG2X6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 19:58:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:9038 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750808AbWG2X6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 19:58:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=iY5nQGEWEro3lquAll+i6GFUBWF3dbzFGyt8AWo8P7pcmzdwNFnnqDd1e4FpvrMcvPKnQlxIOD1W1ETU7tPeqzDrhaYIAZ9TGRF/9aiHVqdswD1LydX5Wze7501Ou/OV5njHXJ265Ps7m2pCMnb7r7q1DQcadvB+9xyIqtcOdi8=
Message-ID: <44CBF631.5070005@gmail.com>
Date: Sun, 30 Jul 2006 01:58:18 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org,
       linux-mm@kvack.org
Subject: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
References: <20060727015639.9c89db57.akpm@osdl.org> <200607292059.59106.rjw@sisk.pl> <44CBE9D5.9030707@gmail.com> <200607300110.01943.rjw@sisk.pl>
In-Reply-To: <200607300110.01943.rjw@sisk.pl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki napsal(a):
> On Sunday 30 July 2006 01:06, Jiri Slaby wrote:
>> Rafael J. Wysocki napsal(a):
>>> Hi,
>>>
>>> On Saturday 29 July 2006 19:58, Jiri Slaby wrote:
>>>> Andrew Morton napsal(a):
>>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
>>>> Hello,
>>>>
>>>> I have problems with swsusp again. While suspending, the very last thing kernel
>>>> writes is 'restoring higmem' and then hangs, hardly. No sysrq response at all.
>>>> Here is a snapshot of the screen:
>>>> http://www.fi.muni.cz/~xslaby/sklad/swsusp_higmem.gif
>>>>
>>>> It's SMP system (HT), higmem enabled (1 gig of ram).
>>> Most probably it hangs in device_power_up(), so the problem seems to be
>>> with one of the devices that are resumed with IRQs off.
>>>
>>> Does vanila .18-rc2 work?
>> Yup, it does.
> 
> Hm, in fact this may be a problem with any device driver.
> 
> Could you please boot the system with init=/bin/bash and try to suspend?

No change.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

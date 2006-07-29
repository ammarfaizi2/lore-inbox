Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWG2X6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWG2X6D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 19:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWG2X6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 19:58:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:3405 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750806AbWG2X6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 19:58:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=U+J3gJjBHCCE3UJlTP++kba9SK6foLkK0Hd7xY/2oVYd1ry3+M4+2XN2t5rx38gmiXssbA+a9SJjutCggJBOl/MOM15PqPSzomiR/5LOQDCmRxQ28/TjvHLv/Yn+zoFRIeJyBF2iFLJ9/1zcqLBo9cH5Xpv+9q7fTEEqpHO/08A=
Message-ID: <44CBF60C.3090508@gmail.com>
Date: Sun, 30 Jul 2006 01:57:41 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jiri Slaby <jirislaby@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org, linux-mm@kvack.org
Subject: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
References: <20060727015639.9c89db57.akpm@osdl.org> <44CBA1AD.4060602@gmail.com> <200607292059.59106.rjw@sisk.pl> <44CBE9D5.9030707@gmail.com> <20060729232216.GB1983@elf.ucw.cz>
In-Reply-To: <20060729232216.GB1983@elf.ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek napsal(a):
> Hi!
> 
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
> Can you try up kernel, no highmem? (mem=512M)?

It writes then:
p16v: status 0xffffffff, mask 0x00001000, pvoice f7c04a20, use 0
in endless loop when resuming -- after reading from swap.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

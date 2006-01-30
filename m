Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWA3A5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWA3A5x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 19:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWA3A5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 19:57:53 -0500
Received: from macferrin.com ([65.98.32.91]:51464 "EHLO macferrin.com")
	by vger.kernel.org with ESMTP id S1751213AbWA3A5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 19:57:52 -0500
Message-ID: <43DD644B.8070501@macferrin.com>
Date: Sun, 29 Jan 2006 17:56:43 -0700
From: Ken MacFerrin <lists@macferrin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Thunderbird/1.0.7 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>, s0348365@sms.ed.ac.uk,
       hugh@veritas.com
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
References: <43DAE307.5010306@macferrin.com> <9a8748490601281031x514f0b9ckffcdce64148ebd8d@mail.gmail.com> <43DD3DDF.6020901@macferrin.com>
In-Reply-To: <43DD3DDF.6020901@macferrin.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken MacFerrin wrote:
> Jesper Juhl wrote:
> 
>> On 1/28/06, Ken MacFerrin <lists@macferrin.com> wrote:
>>
>>> I started getting hard lockups on my desktop PC with the error "kernel
>>> BUG at mm/rmap.c:487" starting with kernel 2.6.13 and continuing through
>>> 2.6.14.  After switching to 2.6.15 the lockups have continued with the
>>> message "kernel BUG at mm/rmap.c:486".
>>>
>>> The frequency and circumstance are completely random which originally
>>> had me suspecting bad memory but after running Memtest86+ for over 12
>>> hours without error I'm at a loss.
>>>
>>> I'm running the binary Nvidia driver so I'll understand if I can't get
>>> help here but in searching through the list archives it would seem I'm
>>> not alone and I am willing to try any patches that may help diagnose the
>>> issue.  The crash happens at least daily and I've seen no difference in
>>> running kernels with or without PREEMPT enabled.
>>>
>>
>> If you don't actually *need* accelerated 3D (or if you could do
>> without it for a while), switching to the "nv" driver for a few
>> days/weeks would be interresting. If the crashes go away that would
>> point towards the nvidia driver, if they don't go away we'll get a
>> nice untainted crash report.
>>
> 
> Thanks to all for the response.  In hopes of helping to isolate this I 
> will move back over to the "nv" driver to see if I can recreate the 
> problem and get a clean bug report before applying Hugh's patch.
> 
> This crash currently happens daily for me so I should be able to test 
> this relatively quickly.
> -Ken

Unfortunately it seems that the "nv" driver in Xorg does not currently 
support multiple displays on a single video card with dual heads.  Not 
being able to at least run xinerama is a deal breaker for me so I'm back 
to the binary nvidia driver using twinview.  At this point I will apply 
Hugh's patch and post any further "Bad page state" and "Bad rmap"
messages as instructed.

Thanks,
Ken


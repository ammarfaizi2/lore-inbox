Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269614AbUJLLIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269614AbUJLLIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269628AbUJLLIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:08:41 -0400
Received: from relay.pair.com ([209.68.1.20]:14610 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269614AbUJLLIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:08:38 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <416BBB34.3030107@cybsft.com>
Date: Tue, 12 Oct 2004 06:08:36 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mark_H_Johnson@Raytheon.com, Andrew Morton <akpm@osdl.org>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T5
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <416B54BA.9050606@cybsft.com> <20041012060213.GD1479@elte.hu>
In-Reply-To: <20041012060213.GD1479@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>>i've uploaded -T5 which should fix most of the build issues:
>>>
>>
>>This fixed the build problems for me (SMP). I did get one unresolved
>>symbol when building this with REALTIME enabled.
> 
> 
> (which symbol was this?)

WARNING: 
/lib/modules/2.6.9-rc4-mm1-VP-T5-RT/kernel/drivers/net/ppp_synctty.ko 
needs unknown symbol _mutex_trylock_bh

I shouldn't have even had ppp enabled and then wouldn't have noticed it, 
but...
> 
> 
>>[...] Also got error messages scrolling up the screen when I tried to
>>boot it (looked very much like Mark's problem with T4) and it never
>>made it. :( If I had to guess, it might be related to APICs? I always
>>have to use "noapic" boot parameter.  Ingo what are you running this
>>on? I don't have the exact error messages, but I'm rebuilding it now
>>to try to get those. Without RT Preemption it seems to be running very
>>nicely.
> 
> 
> dont worry about it not booting on your setup with PREEMPT_REALTIME, as
> long as it boots with !PREEMPT_REALTIME - i only really converted my
> testsystems which are basically IDE + e100/e1000/rtl8139, ext3 and the
> bare minimum that is needed to run Fedora. It might be useful to send me
> a bootlog if you have any easy way to capture it - if not it's not a big
> problem either.
> 
> 	Ingo
> 


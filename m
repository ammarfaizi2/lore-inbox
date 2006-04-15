Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWDOX21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWDOX21 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 19:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWDOX21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 19:28:27 -0400
Received: from dvhart.com ([64.146.134.43]:10702 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932119AbWDOX20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 19:28:26 -0400
Message-ID: <44418197.7030900@mbligh.org>
Date: Sat, 15 Apr 2006 16:28:23 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Clear performance regression on reaim7 in 2.6.15-git6
References: <4441452F.3060009@google.com>	<20060415141744.042231a8.akpm@osdl.org>	<44416616.10908@google.com>	<20060415145227.5d1249bd.akpm@osdl.org>	<444173EE.4060602@google.com> <20060415154518.6a5a0c52.akpm@osdl.org> <44417ADB.4070104@google.com>
In-Reply-To: <44417ADB.4070104@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>> It's still broken in 17-rc1 ... will send you a patch in a sec.
>>
>>
>>
>> I already have kconfigdebug-set-debug_mutex-to-off-by-default.patch 
>> queued up.
> 
> 
> OK. That explains why -mm2 bounced back at the end of this graph:
> http://test.kernel.org/perf/reaim.moe.png
> 
> But ... it's still way below what 2.6.15 was. There's another thunk
> down between 2.6.16 and 2.6.16-git18, AFAICS.

OK, I futzed with the graphs a bit. -git2 to -git3 definitely drops
off. I think -git6 to git7 does as well, though that's much more
difficult to discern amongst the noise. I'll take a look more.

Andy, if there's any way you could rerun all the -git ones on moe
with the CONFIG_DEBUG_MUTEXES stuff disabled, might be easier to see ...

M.

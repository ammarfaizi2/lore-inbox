Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWEaVnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWEaVnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWEaVnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:43:12 -0400
Received: from dvhart.com ([64.146.134.43]:10898 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965178AbWEaVnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:43:10 -0400
Message-ID: <447E0DEC.60203@mbligh.org>
Date: Wed, 31 May 2006 14:43:08 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@google.com>,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org> <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu>
In-Reply-To: <20060531213340.GA3535@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Martin J. Bligh <mbligh@mbligh.org> wrote:
> 
> 
>>>AFAICS this isnt the lock validator but the normal mutex debugging code 
>>>(CONFIG_DEBUG_MUTEXES). The log does not indicate that lockdep was 
>>>enabled.
>>
>>Buggered if I know how that got turned on. I thought we turned it off 
>>by default now? That's what screwed up all the perf results before.
>>
>>http://test.kernel.org/abat/33803/build/dotconfig
>>That's the build config it ran with.
>>
>>CONFIG_DEBUG_MUTEXES=y
> 
> 
> still ... it shouldnt have crashed on us. I did change it in -mm1 so 
> i'll take a look tomorrow.
> 
> 
>>Grrr. Humpf. I can't see the option being turned on for lockdep ...
>>what was the config option, and is it enabled by default?

In the -mm1 patch:

  config DEBUG_MUTEXES
-       bool "Mutex debugging, deadlock detection"
-       default n
+       bool "Mutex debugging, basic checks"
+       default y

Please don't do thatas a default.
It fucks up all the performance checking ;-(


M.

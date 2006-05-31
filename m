Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbWEaWhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbWEaWhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWEaWhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:37:18 -0400
Received: from smtp-out.google.com ([216.239.45.12]:33159 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965215AbWEaWhR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:37:17 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=bKPEnFkkhcrvVk5GYxiSIX3SOGCDyvQFdPyO77bFZ1a+cRRyHBqMIQKhDLE/YAvQK
	7CqWROVO2iAsCEwJTPWKQ==
Message-ID: <447E1A7B.2000200@google.com>
Date: Wed, 31 May 2006 15:36:43 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF47.6010908@google.com> <20060531140823.580dbece.akpm@osdl.org> <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org> <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org> <20060531221242.GA5269@elte.hu> <447E16E6.7020804@google.com> <20060531223243.GC5269@elte.hu>
In-Reply-To: <20060531223243.GC5269@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Martin Bligh <mbligh@google.com> wrote:
> 
> 
>>>>OK. So what's the perf impact of the new version on a 32 cpu machine? 
>>>>;-) Maybe it's fine, maybe it's not.
>>>
>>>
>>>no idea, but it shouldnt be nearly as bad as say SLAB_DEBUG.
>>
>>The "no idea" is hardly reassuring ;-)
>>The latter point is definitely valid though, it's not an isolated issue.
> 
> 
>>Adding new runs is easy. Changing the harness is hard ;-)
> 
> 
> ok. How about a CONFIG_DEBUG_NO_OVERHEAD option, that would default to 
> disabled but which you could set to y. Then we could make all the more 
> expensive debug options:
> 
> 	default y if !CONFIG_DEBUG_NO_OVERHEAD
> 
> this would still mean you'd have to turn off CONFIG_DEBUG_NO_OVERHEAD, 
> but it would be automatically maintainable for you after that initial 
> effort, and we'd be careful to always flag new debugging options with 
> this flag, if they are expensive. And initially i'd define "expensive" 
> as "anything that adds runtime overhead".
> 
> would this be acceptable to you?

Sure, makes sense. I don't care which way up it is, ie
CONFIG_DEBUG_OVERHEAD vs CONFIG_DEBUG_NO_OVERHEAD, as long as it's
easily separable.

There's probably other debug stuff we can turn on too, if we do that.

M.

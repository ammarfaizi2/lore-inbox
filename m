Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWEaVxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWEaVxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWEaVxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:53:21 -0400
Received: from dvhart.com ([64.146.134.43]:12946 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965186AbWEaVxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:53:20 -0400
Message-ID: <447E104B.6040007@mbligh.org>
Date: Wed, 31 May 2006 14:53:15 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@google.com, linux-kernel@vger.kernel.org, apw@shadowen.org,
       ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF49.9070401@google.com>	<20060531140652.054e2e45.akpm@osdl.org>	<447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
In-Reply-To: <20060531144310.7aa0e0ff.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> 
>>Andrew Morton wrote:
>>
>>>Martin Bligh <mbligh@google.com> wrote:
>>>
>>>
>>>>The x86_65 panic in LTP has changed a bit. Looks more useful now.
>>>>Possibly just unrelated new stuff. Possibly we got lucky.
>>>
>>>What are you doing to make this happen?
>>
>>runalltests on LTP
>>
> 
> 
> We have to get to the bottom of this - there's a shadow over about 500
> patches and we don't know which.

We did do one chop, and concluded it wasn't the x86_64 patches.

> iirc I tried to reproduce this a couple of weeks back and failed.

It looks like a different panic to me. It was a double-fault before.

> Are you able to narrow it down to a particular LTP test?  It was mtest01 or
> something like that?  Perhaps we can identify a particular command line
> which triggers the fault in a standalone fashion?

I can't do much from here - it's running on an IBM machine. Have to beg
Andy, or one of the other IBMers, for help.

> And why can't I make it happen?  Perhaps it's a memory initialisation
> problem, and it only happens to hit in that stage of LTP because that's
> when you started doing page reclaim, or something? 

It consistently happens on -mm, and not mainline, flicking back and 
forth over time. So if you mean h/w mem init, I don't think so. if you
mena some patch in -mm, then yes.

>  Perhaps just try putting a heap of memory pressure on the machine, 
 > see what that does?

Yes, the other stuff might not be swapping.

> Being unable to reproduce it and not having a theory to go on leaves us
> kinda stuck.  Help, please?

Yeah, we have a sniff-testing mechanism that works well. However,
drill-down still requires significant amounts of human intervention.
The next gen of stuff should help do more intelligent stuff, but we're
kind of stuck with human-ness for now.

M.


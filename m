Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWB1APB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWB1APB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWB1APA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:15:00 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:3299 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751790AbWB1APA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:15:00 -0500
Message-ID: <4403935A.3080503@tmr.com>
Date: Mon, 27 Feb 2006 19:03:38 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Marr <marr@flex.com>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
References: <200602241522.48725.marr@flex.com> <20060224211650.569248d0.akpm@osdl.org> <440374DF.8080901@namesys.com>
In-Reply-To: <440374DF.8080901@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Andrew Morton wrote:
> 
>> runs like a dog on 2.6's reiserfs.  libc is doing a (probably) 128k read
>> on every fseek.
>>
>> - There may be a libc stdio function which allows you to tune this
>>  behaviour.
>>
>> - libc should probably be a bit more defensive about this anyway -
>>  plainly the filesystem is being silly.
>>  
>>
> I really thank you for isolating the problem, but I don't see how you
> can do other than blame glibc for this.  The recommended IO size is only
> relevant to uncached data, and glibc is using it regardless of whether
> or not it is cached or uncached.   Do I misunderstand something myself here?

I think the issue is not "blame" but what effect this behavior would 
have on things like database loads, where seek-write would be common. 
Good to get this info to users and admins.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me


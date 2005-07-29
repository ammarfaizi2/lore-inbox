Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVG2Bqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVG2Bqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 21:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVG2Bqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 21:46:32 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:35426 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261707AbVG2Bqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 21:46:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=QZf1KkXgy/0JqoyGP7QQlOtDrihFmxXFPlJmorZqN6LGdYQeK330YWD/WyoPw/sOhKLhCnfxsWDr4e4dRpP1i0aFzklQ/EfhLiWp08IiGiDtTBX+B/LrwDGVovF4wcetX6XaJN+g5NahS0qH1AmyhmZTe127GPHUDtF+O71AJXg=  ;
Message-ID: <42E98A6B.2090305@yahoo.com.au>
Date: Fri, 29 Jul 2005 11:46:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
References: <200507290139.j6T1dNg03701@unix-os.sc.intel.com>
In-Reply-To: <200507290139.j6T1dNg03701@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:

>Nick Piggin wrote on Thursday, July 28, 2005 6:25 PM
>
>>Well pipes are just an example. It could be any type of communication.
>>What's more, even the synchronous wakeup uses the wake balancing path
>>(although that could be modified to only do wake balancing for synch
>>wakeups, I'd have to be convinced we should special case pipes and not
>>eg. semaphores or AF_UNIX sockets).
>>
>
>
>Why is the normal load balance path not enough (or not be able to do the
>right thing)?  The reblance_tick and idle_balance ought be enough to take
>care of the imbalance.  What makes load balancing in wake up path so special?
>
>

Well the normal load balancing path treats all tasks the same, while
the wake path knows if a CPU is waking a remote task and can attempt
to maximise the number of local wakeups.

>Oh, I'd like to hear your opinion on what to do with these two flags, make
>them runtime configurable? (I'm of the opinion to delete them altogether)
>
>

I'd like to try making them less aggressive first if possible.


Send instant messages to your online friends http://au.messenger.yahoo.com 

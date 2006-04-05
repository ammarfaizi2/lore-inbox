Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWDEVkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWDEVkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWDEVkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:40:37 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:45521 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751183AbWDEVkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:40:36 -0400
Message-ID: <44342CE2.208@tmr.com>
Date: Wed, 05 Apr 2006 16:47:30 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060330 SeaMonkey/1.5a
MIME-Version: 1.0
To: Charles Shannon Hendrix <shannon@widomaker.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OOM kills if swappiness set to 0, swap storms otherwise
References: <1143510828.1792.353.camel@mindpipe> <20060327195905.7f666cb5.akpm@osdl.org> <20060405144716.GA10353@widomaker.com>
In-Reply-To: <20060405144716.GA10353@widomaker.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Shannon Hendrix wrote:
> Mon, 27 Mar 2006 @ 19:59 -0800, Andrew Morton said:
> 
>> Much porkiness.
>>
>> /proc/meminfo is very useful for obtaining a top-level view of where all
>> the memory's gone to.  I'd tentatively say that your options are to put up
>> with the swapping or find a new mail client.
> 
> I use mutt for my email, and I have the same issue on a 1GB system.
> 
> I really wish we could put an upper limit on what file cache can use.
> 
> I understand the original poster was running a lot of pork, but you
> don't have to and still see a problem with swapping.  Even running KDE
> my total application memory most of the time is 300MB or less on a
> machine with 1GB of memory.
> 
> I shouldn't be suffering from swap storms.

Agreed, does meminfo show that you are? The reason I ask is that I have 
noted that large memory machines and CD/DVD image writing suffer from 
some interesting disk write patterns. The image being built gets cached 
but not written, then the file is closed. At some point the kernel 
notices several GB of old unwritten data and decides to write it. This 
makes everything pretty slow for a while, even if you have 100MB/s disk 
system.
> 
> For example, my normal working set of programs eats about 250MB of memory. If
> I also start a job running to something like tag some mp3s, copy a CD, or just
> process a lot of files, it only takes a few minutes before performance becomes
> unacceptable.  

In theory you should be able to tune this, but in practice I see what 
you do. On small memory machines it's less noticable, oddly.
> 
> If you are doing some work where you switch among several applications
> frequently, the pigginess of file cache becomes a serious problem.
> 
> Isn't that bad behavior by any measure?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWBYCmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWBYCmd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWBYCmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:42:33 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:7263 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932436AbWBYCmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:42:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=e5HX5itcm3stMbz31J+liCipE7+YXVCdN1dtQc/RbuDsCkocl6OrkENQKICUmui22iZaRT6JGeCnuJUuLjlst8Xe/IvyPYfvwxOcvtUegqAFSkYajOwP10YkyFvZZPDF5kAv/hHv9buR+xFVcp23jKHo/lxucWMjIzt6ByzGHjs=  ;
Message-ID: <43FFC411.8010106@yahoo.com.au>
Date: Sat, 25 Feb 2006 13:42:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Andrew Morton <akpm@osdl.org>, MIke Galbraith <efault@gmx.de>,
       linux-kernel@vger.kernel.org, mingo@elte.hu, kernel@kolivas.org,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [patch 2.6.16-rc4-mm1]  Task Throttling V14
References: <1140183903.14128.77.camel@homer>	<1140812981.8713.35.camel@homer> <20060224141505.41b1a627.akpm@osdl.org> <43FFAFE9.8000206@bigpond.net.au>
In-Reply-To: <43FFAFE9.8000206@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Andrew Morton wrote:
> 
>> MIke Galbraith <efault@gmx.de> wrote:
>>
>>> Not many comments came back, zero actually.
>>>
>>
>>
>> That's because everyone's terribly busy chasing down those final bugs 
>> so we
>> get a really great 2.6.16 release (heh, I kill me).
>>
>> I'm a bit reluctant to add changes like this until we get the smpnice 
>> stuff
>> settled down and validated.  I guess that means once Ken's run all his
>> performance tests across it.
>>
>> Of course, if Ken does his testing with just mainline+smpnice then any
>> coupling becomes less of a problem.  But I would like to see some 
>> feedback
>> from the other sched developers first.
> 
> 
> Personally, I'd rather see PlugSched merged in and this patch be used to 
> create a new scheduler inside PlugSched.  But I'm biased :-)
> 
> As I see it, the problem that this patch is addressing is caused by the 
> fact that the current scheduler is overly complicated.  This patch just 
> makes it more complicated.  Some of the schedulers in PlugSched already 
> handle this problem adequately and some of them are simpler than the 
> current scheduler -- the intersection of these two sets is not empty.
> 
> So now that it's been acknowledged that the current scheduler has 
> problems, I think that we should be looking at other solutions in 
> addition to just making the current one more complicated.
> 

I tried this angle years ago and it didn't work :)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

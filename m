Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWBVKK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWBVKK2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 05:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWBVKK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 05:10:28 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:13447 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750760AbWBVKK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 05:10:27 -0500
Message-ID: <43FC3853.9030508@openvz.org>
Date: Wed, 22 Feb 2006 13:09:23 +0300
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: devel@openvz.org
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, Andrey Savochkin <saw@sawoct.com>,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mrmacman_g4@mac.com, Linus Torvalds <torvalds@osdl.org>,
       frankeh@watson.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       serue@us.ibm.com, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Devel] Re: Which of the virtualization approaches is more suitable
 for kernel?
References: <43F9E411.1060305@sw.ru>	<20060220161247.GE18841@MAIL.13thfloor.at> <43FB3937.408@sw.ru> <20060221235024.GD20204@MAIL.13thfloor.at>
In-Reply-To: <20060221235024.GD20204@MAIL.13thfloor.at>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:

>On Tue, Feb 21, 2006 at 07:00:55PM +0300, Kirill Korotaev wrote:
>  
>
>>>>- such an approach requires adding of additional argument to many
>>>>functions (e.g. Eric's patch for networking is 1.5 bigger than openvz).
>>>>        
>>>>
>>>hmm? last time I checked OpenVZ was quite bloated
>>>compared to Linux-VServer, and Eric's network part
>>>isn't even there yet ...
>>>      
>>>
>>This is rather subjective feeling.
>>    
>>
>
>of course, of course ...
>
>OpenVZ stable patches:
>	1857829 patch-022stab032-core
>	1886915 patch-022stab034-core
>	7390511 patch-022stab045-combined
>	7570326 patch-022stab050-combined
>	8042889 patch-022stab056-combined
>	8059201 patch-022stab064-combined
>
>Linux-VServer stable releases:
>	 100130 patch-2.4.20-vs1.00.diff
>	 135068 patch-2.4.21-vs1.20.diff
>	 587170 patch-2.6.12.4-vs2.0.diff
>	 593052 patch-2.6.14.3-vs2.01.diff
>	 619268 patch-2.6.15.4-vs2.0.2-rc6.diff
>  
>
Herbert,

Please stop seeding, hmm, falseness. OpenVZ patches you mention are 
against 2.6.8 kernel, thus they contain tons of backported mainstream 
bugfixes and driver updates; so, most of this size is not 
virtualization, but general security/stability/drivers stuff. And yes, 
that size also indirectly tells how much work we do to keep our users happy.

Back to the topic. If you (or somebody else) wants to see the real size 
of things, take a look at broken-out patch set, available from
http://download.openvz.org/kernel/broken-out/. Here (2.6.15-025stab014.1 
kernel) we see that it all boils down to:

Virtualization stuff:                    diff-vemix-20060120-core   817K
Resource management (User Beancounters): diff-ubc-20060120          377K
Two-level disk quota:                    diff-vzdq-20051219-2       154K


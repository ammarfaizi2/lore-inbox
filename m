Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbWFVDtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWFVDtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWFVDtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:49:20 -0400
Received: from ns2.suse.de ([195.135.220.15]:56261 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751559AbWFVDtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:49:19 -0400
Message-ID: <449A137E.3050908@suse.com>
Date: Wed, 21 Jun 2006 23:50:22 -0400
From: Jeffrey Mahoney <jeffm@suse.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Orlov <bugfixer@list.ru>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: bitmap loading related reiserfs changes in 2.6.17-mm1 are broken
References: <20060622032733.GA5158@nickolas.homeunix.com> <20060621204303.47facd01.akpm@osdl.org>
In-Reply-To: <20060621204303.47facd01.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 21 Jun 2006 23:27:33 -0400
> Nick Orlov <bugfixer@list.ru> wrote:
> 
>> subj.
>>
>> I've got a lot of BUG's during the boot and eventually box locked up.
>> SYS-RQ worked. Unfortunately none of these errors did make it to log files,
>> so I cannot provide the backtraces.
>>
>> But reverting last 4 patches of reiserfs-changes series, namely
>>
>> reiserfs-reorganize-bitmap-loading-functions.patch
>> reiserfs-on-demand-bitmap-loading.patch
>> reiserfs-on-demand-bitmap-loading-fix.patch
>> reiserfs-use-generic_file_open-for-open-checks.patch
>>
>> fixed the problem for me.
>>
> 
> Yeah, sorry.  I've uploaded the below to the hot-fixes directory - it
> should repair things.
> 
> 
> Jeff, given its track record, I have to say that my confidence in this work
> is nanoscopic.  Given that, and given the importance of reiserfs and given
> the low rate of reiser3 development and given my ignorance of how reiserfs
> works, I'm inclined to move very slowly on these patches.
> 
> It would really help if Chris or one of the namesys developers could take
> the time to review and test these patches closely, please.

Understood. I'm more than a little embarrassed that these keep getting 
obvious errors that didn't appear in my own testing. I guess my only 
excuse is that these patches consistently get put on the back burner and 
get revisited when someone asks me about them. Unfortunately, sometimes 
it means I end up finding patches on my development nodes that have been 
obsoleted by versions that I've fixed already.

Ugh.

-Jeff

--
Jeff Mahoney
SUSE Labs

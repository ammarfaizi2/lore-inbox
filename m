Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264208AbUENAvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbUENAvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 20:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264269AbUENAvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 20:51:08 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:60588 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264208AbUENAvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 20:51:05 -0400
Message-ID: <40A417EC.7010604@myrealbox.com>
Date: Thu, 13 May 2004 17:50:52 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2
References: <fa.h4eq5gb.nj6q31@ifi.uio.no> <fa.gi5j8pu.92umbq@ifi.uio.no>
In-Reply-To: <fa.gi5j8pu.92umbq@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wright wrote:

> * Andrew Morton (akpm@osdl.org) wrote:
> 
>>Christoph Hellwig <hch@infradead.org> wrote:
>>
>>>>+hugetlb_shm_group-sysctl-gid-0-fix.patch
>>>>
>>>> Don't make gid 0 special for hugetlb shm.
>>>
>>>As Oracle has agreed on fixing their DB to use hugetlbfs could we
>>>please stop doctoring around on this broken patch and revert it.
>>
>>Once I'm convinced that kernel.org kernels will be able to run applications
>>which vendor kernels will run, sure.
> 
> 
> What about something that's just simple and generic?  This is similar to
> Andrea's disable_cap_mlock patch and the disabling capabilities patch
> that wli produced back in that thread.  It would remove the hack, and
> buy us some time to find better solutions.  Downside of course (as all
> of these have) is reduced security value.

I actually like the magic group better.  This one means that _anyone_
can DoS the system.  Why not just give Oracle its own LSM if this is
what you want to do (that way the nastiness is completely isolated)?

<shameless_plug> My patch (posted a couple hours ago) solves this one
cleanly </shameless_plug>

--And

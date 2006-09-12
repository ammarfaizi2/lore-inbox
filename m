Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbWILMap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbWILMap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 08:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWILMap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 08:30:45 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:59864 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965202AbWILMao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 08:30:44 -0400
Message-ID: <4506A86E.7000105@garzik.org>
Date: Tue, 12 Sep 2006 08:30:38 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Ian Kent <raven@themaw.net>, akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] linux/magic.h for magic numbers
References: <20060909110245.GA9617@havoc.gtf.org> <Pine.LNX.4.64.0609121620550.4911@raven.themaw.net>
In-Reply-To: <Pine.LNX.4.64.0609121620550.4911@raven.themaw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent wrote:
> On Sat, 9 Sep 2006, Jeff Garzik wrote:
> 
>> An IRC discussion sparked a memory:  most filesystems really don't
>> need to put anything at all in include/linux.  Excluding API-ish
>> filesystems like procfs, just about the only filesystem symbols that
>> get exported outside of __KERNEL__ are the *_SUPER_MAGIC symbols,
>> and similar symbols.
>>
>> After seeing the useful attributes of linux/poison.h, I propose a
>> similar linux/magic.h.
>>
>> We can see from the patch below that this permitted the deletion of a
>> couple headers, where the *_SUPER_MAGIC symbol was the only thing in the
>> entire header.
>>
>> Other non-filesystem-related magic numbers could get moved here
>> eventually, if maintainers so desire, but I wanted to start off with the
>> obvious low-hanging fruit.
>>
> 
> Would be good to include autofs in this lot.
> 
> Defined in linux/autofs/autofs_i.h
> Defined in linux/autofs4/autofs_i.h
> 
> as 
> 
> #define AUTOFS_SUPER_MAGIC 0x0187

Updated.

Andrew, please add the "magic" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

to the list of trees you pull.

Thanks,

	Jeff



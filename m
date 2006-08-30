Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWH3QdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWH3QdB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWH3QdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:33:01 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:14493 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751131AbWH3QdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:33:00 -0400
Message-ID: <44F5BE55.2010904@sw.ru>
Date: Wed, 30 Aug 2006 20:35:33 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: devel@openvz.org
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Containers@lists.osdl.org,
       video4linux-list@redhat.com, kraxel@bytesex.org,
       linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [Devel] Re: [PATCH] kthread: saa7134-tvaudio.c
References: <20060829211555.GB1945@us.ibm.com>	<20060829143902.a6aa2712.akpm@osdl.org>	<m1k64rf9om.fsf@ebiederm.dsl.xmission.com>	<m164gafld6.fsf@ebiederm.dsl.xmission.com>	<44F59B84.3090906@fr.ibm.com>	<m1lkp6cjq2.fsf@ebiederm.dsl.xmission.com> <44F5BA6F.2070900@fr.ibm.com>
In-Reply-To: <44F5BA6F.2070900@fr.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater wrote:
> Eric W. Biederman wrote:
> 
> [ ... ]
> 
> 
>>>>That plus the obvious bit.  For the pid namespace we have to declare
>>>>war on people storing a pid_t values.  Either converting them to
>>>>struct pid * or removing them entirely.  Doing the kernel_thread to
>>>>kthread conversion removes them entirely.
>>>
>>>we've started that war, won a few battles but some drivers need more work
>>>that a simple replace. If we could give some priorities, it would help to
>>>focus on the most important ones. check out the list bellow.
>>
>>Sure, I think I can help.
>>
>>There are a couple of test I can think of that should help.
>>1) Is the pid value stored.  If not a pid namespace won't affect
>>   it's normal operation.
> 
> 
> I've extracted this list from a table which includes a pid cache column.
> this pid cache column is not complete yet. I'd be nice if we could use a
> wiki to maintain this table, the existing openvz or vserver wiki ?
feel free to use http://wiki.openvz.org
we will create a 'Developement' category then for such pages.
I think we can help with the patches soon as well.

[...]
>>I do agree from what I have seen, that changing idioms to the kthread way of
>>doing things isn't simply a matter of substitute and replace which is
>>unfortunate.  Although the biggest hurdle seems to be to teach kernel threads
>>to communicate with something besides signals.  Which is a general help anyway.
>>
>>Unfortunately I'm distracted at the moment so I haven't gone through the entire
>>list but I hope this helps.
If we have some list on the wiki, people could assign the issues to themself and
prepare the patches. Thus work could be paralleled a bit.

Thanks,
Kirill

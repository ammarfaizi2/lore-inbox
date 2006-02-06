Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWBFI7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWBFI7I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWBFI7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:59:08 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:31615 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750767AbWBFI7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:59:07 -0500
Message-ID: <43E71018.8010104@sw.ru>
Date: Mon, 06 Feb 2006 12:00:08 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>	<Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>	<43E3915A.2080000@sw.ru>	<Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <m1lkwoubiw.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkwoubiw.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I think that a patch like this - particularly just the 1/5 part - makes 
>>total sense, because regardless of any other details of virtualization, 
>>every single scheme is going to need this.
> I strongly disagree with this approach.  I think Al Viro got it
> right when he created a separate namespace for filesystems.  
These patch set introduces separate namespaces as those in filesystems.
What exactly you don't like in this approach? Can you be more specific?

> First this presumes an all or nothing interface.  But that is not
> what people are doing.  Different people want different subsets
> of the functionality.   For the migration work I am doing having
> multiple meanings for the same uid isn't interesting.
What do you mean by that? That you don't care about virtualization of 
UIDs? So your migration doesn't care at all whether 2 systems have same 
uids? Do you keep /etc/passwd in sync when do migration?
Only full virtualization allows to migrate applications without bugs and 
different effects.

> Secondly by implementing this in one big chunk there is no
> migration path when you want to isolate an additional part of the
> kernel interface.
> 
> So I really think an approach that allows for incremental progress
> that allows for different subsets of this functionality to
> be used is a better approach.  In clone we already have
> a perfectly serviceable interface for that and I have
> seen no one refute that.  I'm not sure I have seen anyone
> get it though.
Just introduce config option for each virtualization functionality. 
That's it.

> My apologies for the late reply I didn't see this thread until
> just a couple of minutes ago.  linux-kernel can be hard to
> follow when you aren't cc'd.
> 
> 
> Patches hopefully sometime in the next 24hours.   So hopefully
> conversation can be carried forward in a productive manner.
Ok. I will remake them either :)

Kirill



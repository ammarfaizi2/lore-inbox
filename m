Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945903AbWBCTSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945903AbWBCTSJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945900AbWBCTSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:18:09 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46039 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1945902AbWBCTSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:18:07 -0500
Message-ID: <43E3AC6B.7060608@watson.ibm.com>
Date: Fri, 03 Feb 2006 14:18:03 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@sw.ru>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clg@fr.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>	 <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru>	 <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain>
In-Reply-To: <1138991641.6189.37.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
>  On Fri, 2006-02-03 at 09:49 -0800, Linus Torvalds wrote:
> 
>>One thing I don't particularly like is some of the naming. To me "vps" 
>>doesn't sound particularly generic or logical. I realize that it probably 
>>makes perfect sense to you (and I assume it just means "virtual private 
>>servers"), but especially if you see patches 1-3 to really be independent 
>>of any "actual" virtualization code that is totally generic, I'd actually 
>>prefer a less specialized name.
> 
> 
> I just did a global s/vps/container/ and it looks pretty reasonable, at
> least from my point of view.
> 
> Couple of minor naming nitpick questions, though.  Is vps/container_info
> really what we want to call it?  It seems to me to be the basis for a
> real "container", without the _info part.
> 
> "tsk->owner_container"  That makes it sound like a pointer to the "task
> owner's container".  How about "owning_container"?  The "container
> owning this task".  Or, maybe just "container"?
> 
> Any particular reason for the "u32 id" in the vps_info struct as opposed
> to one of the more generic types?  Do we want to abstract this one in
> the same way we do pid_t?
> 
> The "host" in "host_container_info" doesn't mean much to me.  Though, I
> guess it has some context in the UML space.  Would "init_container_info"
> or "root_container_info" be more descriptive?
> 
> Lastly, is this a place for krefs?  I don't see a real need for a
> destructor yet, but the idea is fresh in my mind.
> 
> How does the attached patch look?
> 

Looks good to me ...

Similar to parts of our patch set, so overlap is good that means on
large parts we agree.
Let's go with Dave's adaption, since it already addresses some of
Linus's concerns and I start moving the pid isolation (in contrast to
pid virtualization) over this.

-- Hubertus


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422631AbWBCSzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbWBCSzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWBCSzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:55:35 -0500
Received: from mail.dvmed.net ([216.237.124.58]:1220 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422631AbWBCSze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:55:34 -0500
Message-ID: <43E3A711.2080806@pobox.com>
Date: Fri, 03 Feb 2006 13:55:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@sw.ru>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>	 <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru>	 <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain>
In-Reply-To: <1138991641.6189.37.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Dave Hansen wrote: > On Fri, 2006-02-03 at 09:49 -0800,
	Linus Torvalds wrote: > >>One thing I don't particularly like is some
	of the naming. To me "vps" >>doesn't sound particularly generic or
	logical. I realize that it probably >>makes perfect sense to you (and I
	assume it just means "virtual private >>servers"), but especially if
	you see patches 1-3 to really be independent >>of any "actual"
	virtualization code that is totally generic, I'd actually >>prefer a
	less specialized name. > > > I just did a global s/vps/container/ and
	it looks pretty reasonable, at > least from my point of view. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
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

I would have chosen the much shorter "box" or "jar", but that's just me :)


> "tsk->owner_container"  That makes it sound like a pointer to the "task
> owner's container".  How about "owning_container"?  The "container
> owning this task".  Or, maybe just "container"?

slip 'parent' in there...


> Any particular reason for the "u32 id" in the vps_info struct as opposed
> to one of the more generic types?  Do we want to abstract this one in
> the same way we do pid_t?
> 
> The "host" in "host_container_info" doesn't mean much to me.  Though, I
> guess it has some context in the UML space.  Would "init_container_info"
> or "root_container_info" be more descriptive?

probably

	Jeff



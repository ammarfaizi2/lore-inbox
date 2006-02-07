Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWBGMTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWBGMTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWBGMTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:19:40 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:32091 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965051AbWBGMTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:19:39 -0500
Message-ID: <43E890CB.1060608@sw.ru>
Date: Tue, 07 Feb 2006 15:21:31 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: Linus Torvalds <torvalds@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>  <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru>  <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain> <43E61448.7010704@sw.ru> <Pine.LNX.4.64.0602060847130.3854@g5.osdl.org> <43E7E998.2020007@vilain.net>
In-Reply-To: <43E7E998.2020007@vilain.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So if some people don't like "container", how about just calling it 
>> "context"? The downside of that name is that it's very commonly used 
>> in the kenel, because a lot of things have "contexts". That's why 
>> "container" would be a lot better.
>>
>> I'd suggest
>>
>>     current->container    - the current EFFECTIVE container
>>     current->master_container - the "long term" container.
>>
>> (replace "master" with some other non-S&M term if you want)
> 
> 
> Hmm.  You actually need a linked list, otherwise you have replaced a one
> level flat structure with a two level one, and you miss out on some of
> the applications.  VServer uses a special structure for this.
Nope! :) This is pointer to current/effective container, which can be 
anywhere in the hierarchy. list should be inside container struct.

Kirill



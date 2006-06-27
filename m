Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbWF0PK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbWF0PK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWF0PK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:10:26 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:50267 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161079AbWF0PKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:10:24 -0400
Message-ID: <44A149F5.2060204@sw.ru>
Date: Tue, 27 Jun 2006 19:08:37 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrey Savochkin <saw@swsoft.com>, dlezcano@fr.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       viro@ftp.linux.org.uk
Subject: Re: [RFC][patch 1/4] Network namespaces: cleanup of dev_base list
 use
References: <20060626134945.A28942@castle.nmd.msu.ru>	<m1odwguez3.fsf@ebiederm.dsl.xmission.com> <44A0D755.5090204@sw.ru> <m11wtaonqf.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m11wtaonqf.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>Cleanup of dev_base list use, with the aim to make device list per-namespace.
>>>>In almost every occasion, use of dev_base variable and dev->next pointer
>>>>could be easily replaced by for_each_netdev loop.
>>>>A few most complicated places were converted to using
>>>>first_netdev()/next_netdev().
>>>
>>>As a proof of concept patch this is ok.
>>>As a real world patch this is much too big, which prevents review.
>>>Plus it takes a few actions that are more than replace just
>>>iterators through the device list.
>>
>>Mmm, actually it is a whole changeset and should go as a one patch. I didn't
>>find it to be big and my review took only 5-10mins..
>>I also don't think that mailing each driver maintainer is a good idea.
>>Only if we want to make some buzz :)
> 
> 
> Thanks for supporting my case.  You reviewed it and missed the obvious typo.
> I do agree that a patchset doing it all should happen at once.
This doesn't support anything. e.g. I caught quite a lot of bugs after 
Ingo Molnar, but this doesn't make his code "poor". People are people.
Anyway, I would be happy to see the typo.

> As for not mailing the maintainers of the code we are changing.  That
> would just be irresponsible.

Kirill

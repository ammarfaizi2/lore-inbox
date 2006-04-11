Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWDKKcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWDKKcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 06:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWDKKcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 06:32:39 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:4028 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750709AbWDKKcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 06:32:39 -0400
Message-ID: <443B873B.9040908@sw.ru>
Date: Tue, 11 Apr 2006 14:38:51 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Kir Kolyshkin <kir@openvz.org>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain> <200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com>
In-Reply-To: <443151B4.7010401@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill,

>> OpenVZ will have live zero downtime migration and suspend/resume some 
>> time next month.
>>
> Please clarify. Currently a migration involves:
> - stopping or suspending the instance
> - backing up the instance and all of its data
> - creating an environment for the instance on a new machine
> - transporting the data to a new machine
> - installing the instance and all data
> - starting the instance

> If you could just briefly cover how you do each of these steps with zero
> downtime...

it does exactly what you wrote with some minor steps such as networking 
stop on source and start on destination etc.

So I would detailed it like this:
- freeze VPS
- freeze networking
- copy VPS data to destination
- dump VPS
- copy dump to the destination
- restore VPS
- unfreeze VPS
- kill original VPS on source

Moreover, in OpenVZ live migration allows to migrate 32bit VPSs between 
i686 and x86-64 Linux machines.

Thanks,
Kirill


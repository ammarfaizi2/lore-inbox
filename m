Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWF1Q5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWF1Q5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWF1Q5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:57:34 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:61741 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751474AbWF1Q5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:57:07 -0400
Message-ID: <44A2B4D7.9080007@fr.ibm.com>
Date: Wed, 28 Jun 2006 18:56:55 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, ebiederm@xmission.com,
       viro@ftp.linux.org.uk, alexey@sw.ru
Subject: Re: [patch 3/4] Network namespaces: IPv4 FIB/routing in namespaces
References: <20060626134945.A28942@castle.nmd.msu.ru> <20060626135250.B28942@castle.nmd.msu.ru> <20060626135427.C28942@castle.nmd.msu.ru> <449FF5AE.2040201@fr.ibm.com> <44A28964.2090006@fr.ibm.com> <20060628183015.B31885@castle.nmd.msu.ru> <44A29379.6060609@sw.ru>
In-Reply-To: <44A29379.6060609@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>>>>> Structures related to IPv4 rounting (FIB and routing cache)
>>>>> are made per-namespace.
>>>
>>>
>>> Hi Andrey,
>>>
>>> if the ressources are private to the namespace, how do you will 
>>> handle NFS mounted before creating the network namespace ? Do you 
>>> take care of that or simply assume you can't access NFS anymore ?
>>
>>
>>
>> This is a question that brings up another level of interaction between
>> networking and the rest of kernel code.
>> Solution that I use now makes the NFS communication part always run in
>> the root namespace.  This is discussable, of course, but it's a far more
>> complicated matter than just device lists or routing :)
> 
> if we had containers (not namespaces) then it would be also possible to 
> run NFS in context of the appropriate container and thus each user could 
>  mount NFS itself with correct networking context.

I was asking the question because in some case, we want a lightweight 
container for running applications (aka application container) who need 
to share the filesystem and it will be too bad to have a network 
namespace which brings isolation and prevents to implement application 
containers. By the way, I agree from a point of view of a system 
container, a complete network isolation is perfect.

Regards.

Daniel.


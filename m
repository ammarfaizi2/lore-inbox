Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWHWOUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWHWOUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 10:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWHWOUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 10:20:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24251 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964899AbWHWOUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 10:20:05 -0400
Message-ID: <44EC6410.3030507@redhat.com>
Date: Wed, 23 Aug 2006 10:20:00 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060801)
MIME-Version: 1.0
To: Robert Szentmihalyi <robert.szentmihalyi@gmx.de>
CC: ray-gmail@madrabbit.org, linux-kernel@vger.kernel.org
Subject: Re: Group limit for NFS exported file systems
References: <20060823091652.235230@gmx.net> <2c0942db0608230355s74af2717g78675ea56b689fc0@mail.gmail.com> <20060823111119.203710@gmx.net>
In-Reply-To: <20060823111119.203710@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Szentmihalyi wrote:
>> On 8/23/06, Robert Szentmihalyi <robert.szentmihalyi@gmx.de> wrote:
>>     
>>> is there a group limit for NFS exported file systems in recent kernels?
>>> One if my users cannot access directories that belong to a group he
>>>       
>> actually _is_ a
>>     
>>> member of. That, however, is true only when accessing them over NFS. On
>>>       
>> the local file
>>     
>>> system, everything is fine. UIDs and GIDs are the same on client and
>>>       
>> server, so that
>>     
>>> cannot be the problem. Client and server run Gentoo Linux with kernel
>>>       
>> 2.6.16 on the
>>     
>>> server and 2.6.17 on the client.
>>>       
>> Is he a member of more than 16 groups?
>>     
>
> Yes. He is actually a member of 27 groups.
> Is the limit of 16 groups still current? I was under the impression that it is a limitation of 2.4 kernels....
> Is there any proper work-around for this?

The 16 group limit is defined by the specification for AUTH_SYS for the RPC.
It can not be easily changed without affecting interoperability.

The use of RPCSEC_GSS and Kerberos can remove this limit.

    Thanx...

       ps

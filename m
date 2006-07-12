Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWGLU2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWGLU2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWGLU2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:28:21 -0400
Received: from smtp-out.google.com ([216.239.33.17]:5124 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750809AbWGLU2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:28:20 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=f8FV8ZLYL9fx/SXOd4sfkATrM3oBdu9HjasoiEqrh/Zl6kMrpK66rEKBBHbb386nS
	CFMZZ0zoakOe+L9zV8yTg==
Message-ID: <44B55AEA.1010608@google.com>
Date: Wed, 12 Jul 2006 13:26:18 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Eric Dumazet <dada1@cosmosbay.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: xfs fails dbench in 2.6.18-rc1-mm1
References: <44B52A19.3020607@google.com> <200607121912.52785.dada1@cosmosbay.com> <44B557DA.2050208@google.com> <44B55A9E.2010403@us.ibm.com>
In-Reply-To: <44B55A9E.2010403@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> Martin Bligh wrote:
> 
>> Eric Dumazet wrote:
>>
>>> On Wednesday 12 July 2006 18:58, Martin Bligh wrote:
>>>
>>>> http://test.kernel.org/abat/40891/debug/test.log.1
>>>>
>>>> Filesystem type for /mnt/tmp is xfs
>>>> write failed on handle 13786
>>>> 4 clients started
>>>> Child failed with status 1
>>>> write failed on handle 13786
>>>> write failed on handle 13786
>>>> write failed on handle 13786
>>>>
>>>> Works fine in -git4
>>>> All other fs's seemed to run OK.
>>>>
>>>> Machine is a 4x Opteron.
>>>
>>>
>>>
>>> You need to revert 92eb7a2f28d551acedeb5752263267a64b1f5ddf
>>
>>
>> Still fails (thanks Andy).
>>
> Wondering if its my changes :(
> Can you back out these and try ?
> 
> Please, Please tell me that, its not me :)
> 
> Thanks,
> Badari
> 
> #
> vectorize-aio_read-aio_write-fileop-methods.patch
> remove-readv-writev-methods-and-use-aio_read-aio_write.patch
> streamline-generic_file_-interfaces-and-filemap.patch
> streamline-generic_file_-interfaces-and-filemap-ecryptfs.patch

You could submit a job to elm3b6 to run dbench on xfs ;-)

M.

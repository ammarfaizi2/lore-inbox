Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbSLGXgH>; Sat, 7 Dec 2002 18:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbSLGXgH>; Sat, 7 Dec 2002 18:36:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33800 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264925AbSLGXgF>;
	Sat, 7 Dec 2002 18:36:05 -0500
Message-ID: <3DF28781.3070405@pobox.com>
Date: Sat, 07 Dec 2002 18:42:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Andrew Morton <akpm@digeo.com>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] net drivers and cache alignment
References: <3DF2781D.3030209@pobox.com> <20021207.144004.45605764.davem@redhat.com> <3DF27EE7.4010508@pobox.com> <3DF2844C.F9216283@digeo.com> <20021207233745.GE3183@werewolf.able.es>
In-Reply-To: <20021207233745.GE3183@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 2002.12.08 Andrew Morton wrote:
> 
>>Jeff Garzik wrote:
>>
>>>David S. Miller wrote:
>>>
>>>>Can't the cacheline_aligned attribute be applied to individual
>>>>struct members?  I remember doing this for thread_struct on
>>>>sparc ages ago.
>>>
>>>Looks like it from the 2.4 processor.h code.
>>>
>>>Attached is cut #2.  Thanks for all the near-instant feedback so far :)
>>>  Andrew, does the attached still need padding on SMP?
>>
> 
> What do you all think about this:
> 
> #include <stdio.h>
> 
> #define CACHE_LINE_SIZE 128
> #define ____cacheline_aligned __attribute__((__aligned__(CACHE_LINE_SIZE)))
> 
> #define __cacheline_start   struct { } ____cacheline_aligned;


if you can mark struct members with attributes, as it appears you can, 
there's no need to define a struct.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSILSkS>; Thu, 12 Sep 2002 14:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSILSkS>; Thu, 12 Sep 2002 14:40:18 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:31419 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317022AbSILSkR>;
	Thu, 12 Sep 2002 14:40:17 -0400
Message-ID: <3D80DEF4.1080906@watson.ibm.com>
Date: Thu, 12 Sep 2002 14:37:40 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linux Aio <linux-aio@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 port of aio-20020619 for raw devices
References: <3D80DB14.2040809@watson.ibm.com> <20020912143540.J18217@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Thu, Sep 12, 2002 at 02:21:08PM -0400, Shailabh Nagar wrote:
> 
>>I just did a rough port of the raw device part of the aio-20020619.diff
>>over to 2.5.32 using the 2.5 aio API published so far. The changeset
>>comments are below. The patch hasn't been tested. Its only guaranteed
>>to compile.
>>
>>I'd like to reiterate that this is not a fork of aio kernel code
>>development or any attempt to question Ben's role as maintainer ! This
>>was only an exercise in porting to enable a comparison of the older
>>(2.4) approach with whatever's coming soon.
>>
>>Comments are invited on all aspects of the design and implementation.
> 
> 
> The generic aio <-> kvec functions were found to not work well, and 
> the chunking code needs to actually pipeline data for decent io thruput.  
> Short story: the raw device code must be rewritten using the dio code 
> that akpm introduced.
> 
> 		-ben
> --

So does the kvec structure go away (and some variant of dio get used) ?







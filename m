Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbWGMOnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWGMOnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWGMOnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:43:03 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:8204 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751553AbWGMOnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:43:02 -0400
Message-ID: <44B65BB9.9040303@shadowen.org>
Date: Thu, 13 Jul 2006 15:42:01 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Martin Bligh <mbligh@google.com>, Eric Dumazet <dada1@cosmosbay.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: xfs fails dbench in 2.6.18-rc1-mm1
References: <44B52A19.3020607@google.com>	 <200607121912.52785.dada1@cosmosbay.com> <44B557DA.2050208@google.com>	 <44B55A9E.2010403@us.ibm.com>  <44B55AEA.1010608@google.com> <1152751411.22840.3.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1152751411.22840.3.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Wed, 2006-07-12 at 13:26 -0700, Martin Bligh wrote:
>> Badari Pulavarty wrote:
>>> Martin Bligh wrote:
>>>
>>>> Eric Dumazet wrote:
>>>>
>>>>> On Wednesday 12 July 2006 18:58, Martin Bligh wrote:
>>>>>
>>>>>> http://test.kernel.org/abat/40891/debug/test.log.1
>>>>>>
>>>>>> Filesystem type for /mnt/tmp is xfs
>>>>>> write failed on handle 13786
>>>>>> 4 clients started
>>>>>> Child failed with status 1
>>>>>> write failed on handle 13786
>>>>>> write failed on handle 13786
>>>>>> write failed on handle 13786
>>>>>>
>>>>>> Works fine in -git4
>>>>>> All other fs's seemed to run OK.
>>>>>>
>>>>>> Machine is a 4x Opteron.
> 
> Sorry !! its my screw up again :(
> Here is the patch to fix it.
> 
> Thanks,
> Badari
> 
> Fix a bug in __xfs_file_write() which is causing writes to fail
> with -EINVAL.
> 
> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

Ok, I've thrown this one + apkm's latest fix into the tester.  Only one 
result in so far, but that is our first good on that machine.

-apw

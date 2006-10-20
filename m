Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWJTQaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWJTQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWJTQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:30:16 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61094 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750788AbWJTQaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:30:14 -0400
Message-ID: <4538F993.8020605@us.ibm.com>
Date: Fri, 20 Oct 2006 09:30:11 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.19-rc2-mm2
References: <20061020015641.b4ed72e5.akpm@osdl.org> <4538F12B.10609@mbligh.org>
In-Reply-To: <4538F12B.10609@mbligh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/ 
>>
>>
>> - Added the IOAT tree as git-ioat.patch (Chris Leech)
>>
>> - I worked out the git magic to make the wireless tree work
>>   (git-wireless.patch).  Hopefully it will be in -mm more often now.
>
> I think the IO & fsx problems have got better, but this one is still
> broken, at least.
>
> See end of fsx runlog here:
>
> http://test.kernel.org/abat/57486/debug/test.log.1
>
> which looks like this:
>
> Total Test PASSED: 79
> Total Test FAILED: 3
>   139 ./fsx-linux -N 10000 -o 8192 -A -l 500000 -r 1024 -t 2048 -w 
> 2048 -Z -R -W test/junkfile
>   139 ./fsx-linux -N 10000 -o 128000 -r 2048 -w 4096 -Z -R -W 
> test/junkfile
>   139 ./fsx-linux -N 10000 -o 8192 -A -l 500000 -r 1024 -t 2048 -w 
> 1024 -Z -R -W test/junkfile
> Failed rc=1
> 10/20/06-02:41:55 command complete: (1) rc=1 (TEST FAIL)
>
I see following message in the log which makes me think the reiserfs 
tail handling with DIO problem...
Is this reiserfs ? Chris Mason told me that we need to use -onotail 
mount option for this to pass.
Not sure why we haven't see this before...

doread: read: Invalid argument

Thanks,
Badari


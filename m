Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTLPDhG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 22:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTLPDhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 22:37:06 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:53971 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S264311AbTLPDhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 22:37:02 -0500
Message-ID: <3FDE7DDD.2060208@verizon.net>
Date: Mon, 15 Dec 2003 22:37:01 -0500
From: RunNHide <res0g1ta@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5.1) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 intio.o build errors
References: <3FD918D8.7020100@verizon.net> <20031215113923.GJ23184@fs.tum.de>
In-Reply-To: <20031215113923.GJ23184@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [4.4.161.12] at Mon, 15 Dec 2003 21:37:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 08:24:40PM -0500, RunNHide wrote:

>> okay - I'm not a n00b but I'm no C programmer or driver developer, 
>> either - figured I'd post this - understand there's not a lot of this 
>> hardware out there so maybe this will be helpful:
>> 
>>  CC [M]  drivers/scsi/ini9100u.o
>> drivers/scsi/ini9100u.c:111:2: #error Please convert me to 
>> Documentation/DMA-mapping.txt
>> drivers/scsi/ini9100u.c:146: warning: initialization from incompatible 
>> pointer type
>> drivers/scsi/ini9100u.c:151: warning: initialization from incompatible 
>> pointer type
>> drivers/scsi/ini9100u.c:152: warning: initialization from incompatible 
>> pointer type
>> drivers/scsi/ini9100u.c: In function `i91uAppendSRBToQueue':
>> drivers/scsi/ini9100u.c:241: error: structure has no member named `next'
>> drivers/scsi/ini9100u.c:246: error: structure has no member named `next'
>> drivers/scsi/ini9100u.c: In function `i91uPopSRBFromQueue':
>> drivers/scsi/ini9100u.c:268: error: structure has no member named `next'
>> drivers/scsi/ini9100u.c:269: error: structure has no member named `next'
>> drivers/scsi/ini9100u.c: In function `i91uBuildSCB':
>> drivers/scsi/ini9100u.c:507: error: structure has no member named `address'
>> drivers/scsi/ini9100u.c:516: error: structure has no member named `address'
>> make[2]: *** [drivers/scsi/ini9100u.o] Error 1
>> make[1]: *** [drivers/scsi] Error 2
>> make: *** [drivers] Error 2
>  
>

This is a known problem.

The driver is marked BROKEN in the Kconfig file, and you were only able 
to choose it since you said "no" to
  Select only drivers expected to compile cleanly
.

Unless someone fixes this driver it will not be available in kernel 2.6.


>> Thanks,
>> RunNHide
>  
>

cu
Adrian

--------------------------------------------------------------------------------------

Thanks for the reply - yes, I understand that the code is broken - however, unfortunately, I have one of those initio cards that needs that driver and I would like to be able to use the 2.6 series kernels. Until that driver is fixed, I'll be stuck on 2.4.x kernels.

RunNHide





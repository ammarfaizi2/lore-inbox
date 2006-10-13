Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751717AbWJMNOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbWJMNOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 09:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbWJMNOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 09:14:39 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:28544 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751717AbWJMNOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 09:14:38 -0400
Message-ID: <452F906F.8020302@aitel.hist.no>
Date: Fri, 13 Oct 2006 15:11:11 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1 - locks when using "dd bs=1M" from card reader
References: <20061010000928.9d2d519a.akpm@osdl.org>	<452E327C.9020707@aitel.hist.no> <20061012112938.97ef924c.akpm@osdl.org>
In-Reply-To: <20061012112938.97ef924c.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 12 Oct 2006 14:18:04 +0200
> Helge Hafting <helge.hafting@aitel.hist.no> wrote:
>
>   
>> I found an easy way to hang the kernel when copying a SD-card:
>>
>> dd if=/dev/sdc of=file bs=1048576
>>
>> I.e. copy the entire 256MB card in 1MB chunks.  I got about
>> 160MB before the kernel hung.  Not even sysrq+B worked, I needed
>> the reset button.  The pc has a total of 512MB memory if that matters.
>>
>> Using bs=4096 instead let me copy the entire card with no problems,
>> but that seems to progress slower.
>>
>> The above 'dd' command hangs my office pc every time. So I can repeat
>> it for debugging purposes. 
>>
>>     
>
> What device driver is providing /dev/sdc?
>   
It is an usb card reader, so it is "usb mass storage"
and "scsi disk".
> Did any previous kernels work correctly?  If so, which?
>   

I just got that card reader, so I haven't tested any earlier kernels.
I have another machine with a card reader, which I have used for
a long time. But I only ever copy files with "cp" on that one.

This time I used "dd" to get an image of the entire card, and got trouble
when using 1M chunks. 

I can try with verbose scsi debug messages if that might help?

Helge Hafting



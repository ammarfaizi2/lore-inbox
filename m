Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbTEFOmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTEFOmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:42:05 -0400
Received: from www1.mail.lycos.com ([209.202.220.140]:20589 "HELO lycos.com")
	by vger.kernel.org with SMTP id S263750AbTEFOmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:42:03 -0400
To: fdavis@si.rr.com
Date: Tue, 06 May 2003 10:52:27 -0400
From: "Sumit Narayan" <sumit_uconn@lycos.com>
Message-ID: <JLODCPDJJDNBCDAA@mailcity.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org
X-Sent-Mail: off
Reply-To: sumit_uconn@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: Write file in EXT2
X-Sender-Ip: 137.99.1.12
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the details.

I wish to know which application access which file, when.. etc etc. I would like to create a log of that. I am unable to write this log to the file from within the kernel. I would not like to go to the user level programs. I am doing this from within the kernel, as I would like to know exactly when things are being done.

Regards,
Sumit
--

On Tue, 06 May 2003 01:06:45  
 Frank Davis wrote:
>Sumit,
>
>In fact, if you're looking at journalizing ext2, ext3 has already done it.
>
>Regards,
>Frank
>
>Frank Davis wrote:
>> Sumit,
>> 
>> Why do you have to do this in the kernel? I can envision doing printks 
>> after each read and write call, and having a userland program receive 
>> the kernel output, storing it into a buffer, and then writing that 
>> buffer, either using fprintf, or fflush, etc.
>> 
>> Regards,
>> Frank
>> 
>> Sumit Narayan wrote:
>> 
>>> Hi,
>>>
>>> I would like to create a log file containing the reads and writes made 
>>> on a disk, by adding a function in the kernel. And once this log table 
>>> reaches a limit, say 10,000 records, I would like it to be written on 
>>> hard disk automatically. I am unable to do this, since I dont know how 
>>> to write to a file, while in the kernel. I tried System Calls, but 
>>> they dont seem to work. Could someone tell me what is the list of 
>>> functions that I need to use to do this job. I think I have to play 
>>> with super-blocks and inodes. But I dont know how to do that. :) 
>>> Please help me.
>>> Thanks.
>>> Sumit
>>>
>>> p.s. I am using Kernel 2.4.20 and want this in EXT2 FS
>>>
>>>
>>> ____________________________________________________________
>>> Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
>>> http://login.mail.lycos.com/r/referral?aid=27005
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>> 
>> 
>
>
>


____________________________________________________________
Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
http://login.mail.lycos.com/r/referral?aid=27005

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVARXjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVARXjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 18:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVARXjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 18:39:07 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:3457 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261485AbVARXi5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 18:38:57 -0500
Message-ID: <41ED9EB7.3060001@tmr.com>
Date: Tue, 18 Jan 2005 18:41:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
CC: Nick Sanders <sandersn@btinternet.com>, linux-kernel@vger.kernel.org
Subject: Re: Unable to burn DVDs
References: <41E557BC.9010405@tmr.com><41E557BC.9010405@tmr.com> <41ECEB45.5040505@stud.feec.vutbr.cz>
In-Reply-To: <41ECEB45.5040505@stud.feec.vutbr.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Schmidt wrote:
> Bill Davidsen wrote:
> 
>> Nick Sanders wrote:
>>
>>> For me when running growisofs  with user permissions on 2.6.10 
>>> (ide-cd) it works perfectly 1st time but 2nd time fails with the 
>>> error below. It works fine when run as root.
>>>
>>> :-( unable to PREVENT MEDIA REMOVAL: Operation not permitted
>>>
>>> As an aside audio cd burning with cdrecord works as long as the 
>>> '-text' option isn't used, if it is the process hangs.
>>
>>
>>
>> I reported a similar thing with cdrecord, writing a first session 
>> successfully using the -multi flag, but not being able to append to it 
>> or read the size with the "-msinfo" flag. I was totally blown off and 
>> told I didn't have permissions on the device, even though I was able 
>> to write to it.
>>
>> I believe the true answer is that the SCSI command filter is blocking 
>> a command needed to perform the operation, probably a command to lock 
>> the door of the drive. In my case I have permissions to write the CD, 
>> just not to read the info needed to write additional sessions.
>>
> 
> Hello,
> Bill and Nick, could you try the attached patch that I sent to Jens 
> Axboe yesterday? (You can see the mail with an explanation on
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110599420505734&w=2 )

Thank you, I will try to get it in tomorrow if I can replicate the issue 
with a USB CD burner, otherwise I will have to wait until Fri or Sat to 
try it on an IDE atached unit. Or I can try to get it going in my 
laptop, that has an FC2 install right now, so it should (eventually) 
build a kernel ;-)

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

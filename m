Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSFMBbS>; Wed, 12 Jun 2002 21:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSFMBbR>; Wed, 12 Jun 2002 21:31:17 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:1451 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S317392AbSFMBbO> convert rfc822-to-8bit; Wed, 12 Jun 2002 21:31:14 -0400
Message-ID: <3D07F470.6060203@linuxhq.com>
Date: Wed, 12 Jun 2002 21:25:04 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 87
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D05AACD.2080504@evision-ventures.com> <3D06495A.6030406@linuxhq.com> <3D06F195.1030901@evision-ventures.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> U¿ytkownik John Weber napisa³:
> 
>> Martin Dalecki wrote:
>>
>>> Sun Jun  9 15:31:56 CEST 2002 ide-clean-87
>>>
>>> - Sync with 2.5.21
>>>
>>> - Don't call put_device inside idedisk_cleanup(). This is apparently 
>>> triggering
>>>   some bug inside the handling of device trees. Or we don't register 
>>> the device
>>>   properly within the tree. Check this later.
>>>
>>> - Further work on the channel register file access locking.  Push the 
>>> locking
>>>   out from __ide_end_request to ide_end_request.  Rename those 
>>> functions to
>>>   respective __ata_end_request() and ata_end_request().
>>>
>>> - Move ide_wait_status to device.c rename it to ata_status_poll().
>>>
>>> - Further work on locking scope issues.
>>>
>>> - devfs showed us once again that it changed the policy from agnostic 
>>> numbers
>>>   to unpleasant string names. What a piece of crap!
>>
>>
>>
>> FYI, this latest cleanup fixes the oops I reported earlier...
>> not that anyone cared :).
> 
> 
> Please just don't expect an e-mail reply on every single
> error report. Me beeing silent means sometimes that I'm just busy
> fixing it...
> 

I was mostly joking about the fact that no one else on the list seemed 
to run into the error.  I think you did more than your part when you 
released IDE 87... I posted to the list as a way of "cancelling" the bug 
report.

I apologize for the ill-planned joke... <TOTAL JOKE>I realize that 
touchy bitch syndrome seems to be running rampant on LKML this 
season</TOTAL JOKE>.

  -o)  J o h n   W e b e r
  /\\ john.weber@linuxhq.com
_\/v http://www.linuxhq.com/people/weber/


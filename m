Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317652AbSFLHAo>; Wed, 12 Jun 2002 03:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317653AbSFLHAn>; Wed, 12 Jun 2002 03:00:43 -0400
Received: from [195.63.194.11] ([195.63.194.11]:18697 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317652AbSFLHAm> convert rfc822-to-8bit; Wed, 12 Jun 2002 03:00:42 -0400
Message-ID: <3D06F195.1030901@evision-ventures.com>
Date: Wed, 12 Jun 2002 09:00:37 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: John Weber <john.weber@linuxhq.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 87
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D05AACD.2080504@evision-ventures.com> <3D06495A.6030406@linuxhq.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik John Weber napisa³:
> Martin Dalecki wrote:
> 
>> Sun Jun  9 15:31:56 CEST 2002 ide-clean-87
>>
>> - Sync with 2.5.21
>>
>> - Don't call put_device inside idedisk_cleanup(). This is apparently 
>> triggering
>>   some bug inside the handling of device trees. Or we don't register 
>> the device
>>   properly within the tree. Check this later.
>>
>> - Further work on the channel register file access locking.  Push the 
>> locking
>>   out from __ide_end_request to ide_end_request.  Rename those 
>> functions to
>>   respective __ata_end_request() and ata_end_request().
>>
>> - Move ide_wait_status to device.c rename it to ata_status_poll().
>>
>> - Further work on locking scope issues.
>>
>> - devfs showed us once again that it changed the policy from agnostic 
>> numbers
>>   to unpleasant string names. What a piece of crap!
> 
> 
> FYI, this latest cleanup fixes the oops I reported earlier...
> not that anyone cared :).

Please just don't expect an e-mail reply on every single
error report. Me beeing silent means sometimes that I'm just busy
fixing it...


Return-Path: <linux-kernel-owner+w=401wt.eu-S1030307AbXAEDQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbXAEDQc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 22:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbXAEDQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 22:16:32 -0500
Received: from mail.icabo.tv.br ([200.220.202.3]:36238 "EHLO mail.icabo.tv.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030307AbXAEDQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 22:16:31 -0500
Message-ID: <459DC2EE.1090307@fliagreco.com.ar>
Date: Fri, 05 Jan 2007 00:15:58 -0300
From: Pablo Sebastian Greco <lkml@fliagreco.com.ar>
User-Agent: Thunderbird 3.0a1 (Windows/20070104)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA problems
References: <459A674B.3060304@fliagreco.com.ar> <459B9F91.9070908@gmail.com> <459BC703.9000207@fliagreco.com.ar> <459C8A5E.5010206@gmail.com> <459CFE7B.6090306@fliagreco.com.ar>
In-Reply-To: <459CFE7B.6090306@fliagreco.com.ar>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ICABO-MailScanner-Information: Please contact the ISP for more information
X-ICABO-MailScanner: Sem Virus encontrado
X-MailScanner-From: lkml@fliagreco.com.ar
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Sebastian Greco wrote:
> Tejun Heo wrote:
>> Pablo Sebastian Greco wrote:
>>  
>>> By crash I mean the whole system going down, having to reset the entire
>>> machine.
>>> I'm sending you 4 files:
>>> dmesg: current boot dmesg, just a boot, because no errors appeared 
>>> after
>>> last crash, since the server is out of production right now (errors
>>> usually appear under heavy load, and this primarily a transparent proxy
>>> for about 1000 simultaneous users)
>>> lspci: the way you asked for it
>>> messages and messages.1: files where you can see old boots and crashes
>>> (even a soft lockup).
>>> If there is anything else I can do, let me know. If you need direct
>>> access to the server, I can arrange that too.
>>>     
>>
>> Can you try 2.6.20-rc3 and see if 'CLO not available' message goes away
>> (please post boot dmesg)?
>>
>> The crash/lock is because filesystem code does not cope with IO errors
>> very well.  I can't tell why timeouts are occurring in the first place.
>>  It seems that only samsung drives are affected (sda2, 3, 4).  Hmmm...
>> Please apply the attached patch to 2.6.20-rc3 and test it.
>>
>> Thanks.
>>
>>   
> Here's boot dmesg with 2.6.20-rc3 + blacklist. And you are right about 
> only affecting samsung drives, but since only those drives get all the 
> heavy load, couldn't tell exactly.
> I'm putting the server in production right now, so I think in a few 
> hours I'll have more info.
>
> Thanks.
> Pablo.
After an uptime of  13:34 under heavy load and no errors, I'm pretty 
sure your patch is correct. Is there a way to backport this to 2.6.18.x?
Just an off topic question, does anyone know why I get so uneven IRQ 
handling on 2.6.19-20 and almost perfect on 2.6.20-rc2-mm1?

Thanks for everything.
Pablo.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUFGO2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUFGO2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUFGO2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:28:43 -0400
Received: from mail.scienion.de ([141.16.81.54]:49892 "EHLO
	server03.hq.scienion.de") by vger.kernel.org with ESMTP
	id S264655AbUFGO2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:28:39 -0400
Message-ID: <40C47B94.6040408@scienion.de>
Date: Mon, 07 Jun 2004 16:28:36 +0200
From: Sebastian Kloska <kloska@scienion.de>
Reply-To: kloska@scienion.de
Organization: Scienion AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: APM realy sucks on 2.6.x
References: <40C0E91D.9070900@scienion.de> <20040607123839.GC11860@elf.ucw.cz> <40C46F7F.7060703@scienion.de> <20040607140511.GA1467@elf.ucw.cz>
In-Reply-To: <20040607140511.GA1467@elf.ucw.cz>
X-MIMETrack: Itemize by SMTP Server on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 16:37:39,
	Serialize by Router on SrvW2k01/Scienion(Release 6.5.1|January 28, 2004) at
 07.06.2004 16:37:41,
	Serialize complete at 07.06.2004 16:37:41
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi again

  Thanks for the hint on device_suspend (realy !! gives me a starting point
  for debugging.


Pavel Machek wrote:
> Hi!
> 
> 
>>>>I'm really willing  to help the APM developers to track down this bug
>>>>but don't have a clue how to debug this kind stuff.
>>>
>>>
>>>What APM developers? There are none as far as I know.
>>
>>
>>  Hmmm ... So once again the Tooth Fairy and Santa Claus :-) ?
>>
>>  At least a
>>
>>  grep '<.*@' /usr/src/linux-2.6.6/arch/i386/kernel/apm.c | sed 's/.*<//' | 
>>  sed 's/>.*//'
>>
>>  gives me:
>>
>><snip>
>>Ulrich.Windl@rz.uni-regensburg.de
> 
> ...
> 
>>chen@ctpa04.mit.edu
>></snip>
>>
>>This is pretty much for no one. And I guess you knew since you're on
>>the list yourself. But I think you're right when meaning
>>that there is not much of active maintenance anymore. Which at
>>least I find a little bit discouraging when looking of the state
>>of the ACPI support.
> 
> 
> Yes, that's pretty much what I meant. ACPI has ~5 people actively
> working on it, some of them probably full-time. That's a lot of
> manpower, compared to APM.


   This becomes a little bit scary. Someone else on this list already
  mentioned that there is a strong movement towards everything which
  is at least a desktop/server machine. And on the other hand there are
  these embedded systems which seem to be attractive for linux to.

  ACPI seems to be nifty for such things like hardware monitoring and
  stuff. That makes it interesting for servers etc...

  Everything in the middle (aka laptops) seems to slowly drop out of the
  loop. PCMCIA seems to be another ugly example. Anyway ...  I'm not frightened
  by this manpower. Just want to have my laptop running 2.6.x and suspending
  to RAM. I'll do my very best and report back if there are any significant
  findings.....

> 
> And ACPI is in pretty good state, btw, unless you want
> suspend-to-RAM. Unfortunately you want suspend-to-RAM.
> 
> 
>>>Try removing calls to device_* in apm.c. Better yet become APM
>>>developer.
>>
>>  It seems like I'm on my way to do so (still reluctantly). As I stated
>> in my previous mails I'm not born as a hardware/BIOS hacker (more the
>> application C++/Java stuff) but I'm willing to learn. When I'm
>> grown up I definitely want to be linux kernel hacker :-) ...
>>
>>  Currently I ripped down the 2.6.6 kernel to almost nothing
>> and add one module after the other checking for proper
>> suspend/resume behavior....
>>
>>  The most suspicious candidates on my list are currently  the
>> USB-UHCI driver and the ALSA sound system, which is my #1 candidate
>> since it has not been an integral part of the 2.4.x (x<=20) kernels.
>>
>>
>> So if anybody out there could give me guidance on how the apm code
>> might interact with the ALSA sound system it would be highly
>> appreciated....
> 
> 
> device_suspend() will propagate all the way to alsa.
> 								Pavel


-- 
**********************************
Dr. Sebastian Kloska
Head of Bioinformatics
Scienion AG
Volmerstr. 7a
12489 Berlin
phone: +49-(30)-6392-1708
fax:   +49-(30)-6392-1701
http://www.scienion.de
**********************************

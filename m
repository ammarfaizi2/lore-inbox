Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311261AbSCLQTD>; Tue, 12 Mar 2002 11:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311265AbSCLQSy>; Tue, 12 Mar 2002 11:18:54 -0500
Received: from [195.63.194.11] ([195.63.194.11]:33802 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311261AbSCLQSl>; Tue, 12 Mar 2002 11:18:41 -0500
Message-ID: <3C8E2A1F.4050607@evision-ventures.com>
Date: Tue, 12 Mar 2002 17:17:35 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312165937.A4987@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Mar 12, 2002 at 12:00:24PM +0100, Martin Dalecki wrote:
> 
> 
>>Hello Vojtech.
>>
>>I have noticed that the ide-timings.h and ide_modules.h are running
>>much in aprallel in the purpose they serve. Are the any
>>chances you could dare to care about propagating the
>>fairly nice ide-timings.h stuff in favour of
>>ide_modules.h more.
>>
>>BTW.> I think some stuff from ide-timings.h just belongs
>>as generic functions intro ide.c, and right now there is
>>nobody who you need to work from behind ;-).
>>
>>So please feel free to do the changes you apparently desired
>>to do a long time ago...
>>
> 
> Hmm, ok. Try this. It shouldn't change any functionality, yet makes a
> small step towards cleaning the chipset specific drivers.


OK the patch looks fine. Taken. Still I have some notes:

1. Let's start calling stuff ATA and not IDE. (AT-Attachment is it
and not just Integrated Device Electornics.) OK?

2. I quite don't like the nested #include directives in ide-timing.h.
    It's cleaner to include the needed headers in front of usage
    of ide-timing.h. (Just s small note.... not really important...)

3. I wellcome that the MIN MAX macros there are gone. In fact
I have yerstoday just done basically the same ;-). (Will just have to
revert it now.

Patch swallowed.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293410AbSCFJUZ>; Wed, 6 Mar 2002 04:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293412AbSCFJUQ>; Wed, 6 Mar 2002 04:20:16 -0500
Received: from [195.63.194.11] ([195.63.194.11]:36101 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293410AbSCFJUJ>; Wed, 6 Mar 2002 04:20:09 -0500
Message-ID: <3C85DF0B.5080605@evision-ventures.com>
Date: Wed, 06 Mar 2002 10:19:07 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16i9mc-00043p-00@wagner.rustcorp.com.au> <3C84A34E.6060708@evision-ventures.com> <3C84AE16.A7F1ECCA@redhat.com> <20020305221933.A405@ucw.cz> <3C853BC9.EC553363@mandrakesoft.com> <20020305224650.A1123@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Mar 05, 2002 at 04:42:33PM -0500, Jeff Garzik wrote:
> 
> 
>>>Note that taskfiles are not being removed from IDE. Just direct (and
>>>parsed and filtered) interface to userspace. Does the scsi midlayer
>>>export the SCBs directly to userspace?
>>>
>>It should.
>>
>>I think it's a mistake to remove the taskfile interface.
>>
>>It provides a way for people to directly validate the lowest level IDE
>>interface, without interference from upper layers.  It also provides
>>access to userspace for important features that -should not- be in the
>>kernel, like SMART monitoring and security features.
>>
> 
> Well, Martin promised to reimplement it better later if there is demand
> for it, and it seems there is. So I suppose it's going away only to be
> replaced by something better.
> 
> There was a flamewar about this some time ago - whether the kernel
> should or should not parse the taskfile access to prevent possibly
> dangerous commands sent to the drive - if this is to be used for
> validation, then all commands need to be allowed, which also will enable
> to thin the code considerably.

Please note that the code in question present currently there is
quite frankly not functional. And that's the main problem
with it - It's hard to guarantee proper functionality of
the mail functionality if there is something "catching it's eggs
from behind". Please note further that the excessive copying between
a variable called frequently args and the "task file"
register set just shows that the API the ide-taskfile is trying
to implement is not right. Further on the excessive command format
validation found in ide-taskfile.c is just too much of a burden.



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R


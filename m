Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVALBXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVALBXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 20:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbVALBXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 20:23:17 -0500
Received: from [209.195.52.120] ([209.195.52.120]:49126 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261655AbVALBXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 20:23:09 -0500
Date: Tue, 11 Jan 2005 17:18:16 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Andries Brouwer <aebr@win.tue.nl>, "Barry K. Nathan" <barryn@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make uselib configurable (was Re: uselib()  & 2.6.X?)
In-Reply-To: <Pine.LNX.4.61.0501120203510.2912@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.60.0501111714450.18921@dlang.diginsite.com>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl><20050107170712.GK29176@logos.cnet>
 <1105136446.7628.11.camel@localhost.localdomain><Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org>
 <20050107221255.GA8749@logos.cnet><Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org><20050111225127.GD4378@ip68-4-98-123.oc.oc.cox.net>
 <20050111235907.GG2760@pclin040.win.tue.nl>
 <Pine.LNX.4.61.0501120203510.2912@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Jesper Juhl wrote:

> On Wed, 12 Jan 2005, Andries Brouwer wrote:
>
>> On Tue, Jan 11, 2005 at 02:51:27PM -0800, Barry K. Nathan wrote:
>>> On Sat, Jan 08, 2005 at 10:46:19AM -0800, Linus Torvalds wrote:
>>>> Another issue is likely that we should make the whole "uselib()"
>>>> interfaces configurable. I don't think modern binaries use it (where
>>>> "modern" probably means "compiled within the last 8 years" ;).
>>
>> libc 5.4.46 is from 1998-06-21 or so, glibc 2.0.5 from 1997-08-25 or so.
>>
>>> +config SYS_USELIB
>>> +	bool "sys_uselib syscall support (needed for old binaries)"
>>> +	---help---
>>> +	  Many old binaries (e.g. dynamically linked a.out binaries, and
>>> +	  ELF binaries that are dynamically linked against libc5), require
>>> +	  the sys_uselib syscall. However, on the typical Linux system, this
>>> +	  code is just old cruft that no longer serves a purpose.
>>> +
>>> +	  If you are unsure, say "N" if you care more about security and
>>> +	  trimming bloat, or say "Y" if you care more about compatibility
>>> +	  with old software. (If you will answer "Y" or "M" to BINFMT_AOUT,
>>> +	  below, you probably should answer "Y" here.)
>>
>> s/sys_uselib/uselib/
>> The system call is uselib().
>>
>> Hmm - old cruft.. Why insult your users?
>> I do not have source for Maple. And my xmaple binary works just fine.
>> But it is a libc4 binary.
>>
>> You mean "on the typical recently installed Linux system, with nothing
>> but the usual Linux utilities".
>>
>> People always claim that Linux is good in preserving binary compatibility.
>> Don't know how true that was, but introducing such config options doesnt
>> help.
>>
>> Let me also mutter about something else.
>> In principle configuration options are evil. Nobody wants fifty thousand
>> configuration options. But I see them multiply like ioctls.
>> There should be a significant gain in having a config option.
>>
> I don't have much to say exceppt express my agreement. That is so very
> true.
> The less config options the user is presented with the better, and for
> each config option there should be a very good reason. Very much agreed.
>
>
>> Maybe some argue that there is a gain in security here. Perhaps.
>> Or a gain in memory. It is negligible.
>> I see mostly a loss.
>>
>> There are more ancient system calls, like old_stat and oldolduname.
>> Do we want separate options for each system call that is obsoleted?
>>
> IMO, no, we do not.

how about something like the embedded, experimental, and broken options. 
that way normal users can disable all of them at a stroke, people who need 
them can add them in.

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

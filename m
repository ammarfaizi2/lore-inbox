Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbSIWTIR>; Mon, 23 Sep 2002 15:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbSIWSlo>; Mon, 23 Sep 2002 14:41:44 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261312AbSIWSl2>;
	Mon, 23 Sep 2002 14:41:28 -0400
Date: Mon, 23 Sep 2002 17:17:55 +0200
Subject: Re: 2.5.38 on ppc/prep
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linux-kernel@vger.kernel.org
To: Tom Rini <trini@kernel.crashing.org>
From: Remco Post <r.post@sara.nl>
In-Reply-To: <20020923145519.GP726@opus.bloom.county>
Message-Id: <A303D698-CF07-11D6-A08A-000393911DE2@sara.nl>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On maandag, september 23, 2002, at 04:55 , Tom Rini wrote:

> On Mon, Sep 23, 2002 at 04:39:49PM +0200, Remco Post wrote:
>>
>> On maandag, september 23, 2002, at 04:29 , Tom Rini wrote:
>>
>>> On Mon, Sep 23, 2002 at 02:03:02PM +0200, Remco Post wrote:
>>>
>>>> after some tiny fixes to reiserfs and the makefile for prep bootfile
>>>> (using ../lib/lib.a vs. ../lib/libz.a) I managed to succesfully 
>>>> compile
>>>> a kernel. It even boots to the point where it frees unused kernel
>>>> memory
>>>> and then stops... this includes succesfully mounting the root
>>>> filesystem...
>>>
>>> What typo exactly?  The only 'lib' in the Makefile
>>> (arch/ppc/boot/prep/Makefile) is:
>>> LIBS = ../lib/zlib.a
>>
>> That one exactly... I don't recall calling it a typo, though ;-) I 
>> guess
>> that is more a relic from when the only lib routines were libz ones and
>> we called the lib to be linked libz.a....
>
> It's not a relic, it's design.  We don't want the kernel's zlib routines
> right now, we want our own.  Did it not link the way it was?  It's been
> a few releases since I last compiled for my PReP box, but it was well
> after the zlib changes had gone in.
>
>> There is a simular entry in arch/ppc/boot/openfirmware/Makefile...
>> removing the z helped over there as well (don't recall exactly, I'm at
>> work now... ) (not that I dare booting Linus's 2.5 tree on my build
>> machine, it's falling apart even with stable software....  ;-(
>
> Again, we don't want the 'normal' zlib there either.  Was it not
> linking?  If so, what was the error?
>

no rule to make target ../lib/libz.a needed for target 
../images/zImage.prep (and simulair for openfirmware...), or something 
like that (I have to this from what I remember) I found a file 
../lib/lib.a, so I assumed it was renamed, not updating the makefile for 
the prep and openfirmware image

This is a linking error in the final stage of the build.... I think 
2.5.33 als build ok, after a few patches. Booted as far a to tell me 
there was an attempt to kill pid 0 and the do its 180 sec. countdown...

> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
>
--
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams



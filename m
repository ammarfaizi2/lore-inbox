Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310401AbSCGQ6v>; Thu, 7 Mar 2002 11:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310411AbSCGQ6k>; Thu, 7 Mar 2002 11:58:40 -0500
Received: from [195.63.194.11] ([195.63.194.11]:49669 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310403AbSCGQ63>; Thu, 7 Mar 2002 11:58:29 -0500
Message-ID: <3C879BF8.7040606@evision-ventures.com>
Date: Thu, 07 Mar 2002 17:57:28 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Voluspa <voluspa@bigfoot.com>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.6-pre3 Kernel panic: VFS: Unable to mount root fs on 03:02
In-Reply-To: <20020307114845.530abcfa.voluspa@bigfoot.com>	<Pine.GSO.4.21.0203070601100.26116-100000@weyl.math.psu.edu> <20020307172946.55044bb9.voluspa@bigfoot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa wrote:
> PS. I've got a rather good grip of my Linux From Scratch system - with a BSD style init for even better control - and only load modules for one NIC and ALSA stuff here. Never have had file systems modulari(z)(s)ed DS.

OK I didn't actually get around to test pre3 in life. But at least
it's nice to hear that this is apparently not my fault ;-).

> 
> On Thu, 7 Mar 2002 06:09:04 -0500 (EST)
> Alexander Viro <viro@math.psu.edu> wrote:
> 
> 
>>It boots fine from ext2 on IDE here.  Do you have any oddities in
>>.config? (e.g. something silly enabled - CONFIG_PREEMPT, etc.)
>>
> 
> Silly :-) A P166 needs every boost possible. Yes, I have preempt enabled. And yes, you are right on the mark. Compiling without preempt the booting of 2.5.6-pre3 runs flawlessly. And after a few tests no file corruption visible. But 2.5.6-pre2 + preempt-UP-bug-patch worked like a charm. So there's something else involved, it seems.
> 
> During the compilation I happened to get a brief glimpse of a warning in ide.c Don't know C so can't evaluate its severity. Went something like this: 'In function choose_drive Warning: distinkt pointer lacks a cast'.
That's spurious and will vanish soon. I just peplaced IDE_MAX and 
IDE_MIN with the generic min() max(), which are showing nicely where
int entities of different size are compared.

> 
> 
>>.config might be really useful.  Or not - it may boil down to checking
>>
> 
> I judge it a moot point to dump all those lines now. If I'm in err, nudge me.
> 
> Thanks for the discussion.
> MJ
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWEBPBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWEBPBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWEBPBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:01:01 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:63818 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964860AbWEBPBA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:01:00 -0400
Message-ID: <44514BC6.6020603@tmr.com>
Date: Thu, 27 Apr 2006 18:55:02 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com><mj+md-20060424.201044.18351.atrey@ucw.cz><444D44F2.8090300@wolfmountaingroup.com><1145915533.1635.60.camel@localhost.localdomain> <20060425001617.0a536488@werewolf.auna.net> <Pine.LNX.4.61.0604242107310.25554@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0604242107310.25554@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Mon, 24 Apr 2006, J.A. Magallon wrote:
> 
>> On Mon, 24 Apr 2006 22:52:12 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>
>>> On Llu, 2006-04-24 at 15:36 -0600, Jeff V. Merkey wrote:
>>>> C++ in the kernel is a BAD IDEA. C++ code can be written in such a
>>>> convoluted manner as to be unmaintainable and unreadable.
>>> So can C.
>>>
>>>> All of the hidden memory allocations from constructor/destructor
>>>> operatings can and do KILL OS PERFORMANCE.
>>> This is one area of concern. Just as big a problem for the OS case is
>>> that the hidden constructors/destructors may fail.
>> Tell me what is the difference between:

...clear readable code...
>>
>> and
>>
>>    SuperBlock() : s_mount_opt(0), s_resuid(EXT3_DEF_RESUID), s_resgid(EXT3_DEF_RESGID)
>>    {}
...double bagger...

> I'd like to write modules in FORTRAN, myself. Unless you have been
> writing software since computers were programmed with diode-pins, one
> tends to think that the first programming language learned is the
> best. It's generally because they are all bad, and once you learn how
> to make the defective language do what you want, you tend to identify
> with it. Identifying with one's captors, the Stockholm syndrome,
> that's what these languages cause.

No, I wouldn't touch any of the early languages I learned, the first one 
I liked was ALGOL-60. The software for GE's first CT scanner was 
developed in ALGOL-60. I liked PL/1 when GE was part of the MULTICS 
project, and the whole BCPL->B->C family was fun, although I do like C 
best. GE had an implementation language called I-language which was a 
great system language, but they buried it instead of releasing it. I 
hated FORTRAN, LISP and APL, although I wrote a lot of each, predicted 
that Ada would not be popular, but I like PERL. I wrote text tools in 
TRAC (look that one up ;-) but that's kind of all it did well.

If you hadn't made this next point I would have...
> 
> But, a master carpenter has many tools. He chooses the best for each
> task. When you need to make computer hardware do what you want, in
> a defined manner, in the particular order in which you require,
> you use assembly language to generate the exact machine-code required.
> It is possible to compromise a bit and use a slightly higher-level
> procedural language called C. One loses control of everything with
> any other language. Note that before C was invented, all operating
> system code was written in assembly.

Hate to tell you, C came about a decade after MULTICS was written in 
PL/1, and I think DEC had VMS out in BLISS before C. C came from B (as 
did IMP68), which came from BCPL.
> 
> C++ wasn't written for this kind of work. It was written so that a
> programmer didn't have to care how something was done only that somehow
> it would get done. Also, as you peel away the onion skins from many
> C++ graphics libraries, you find inside the core that does the work.
> It's usually written in C.

C++ allows more abstraction than C, unfortunately too many people go 
right past past abstraction to obfuscation. With operator overloading 
it's possible to generate write-only code, and programs where "A=B+C" 
does file operations :-( That doesn't belong in an operating system, C 
is the right choice.

Sorry for the history lesson, you got me thinking about my first languages.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me


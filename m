Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUCHSlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 13:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbUCHSlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 13:41:55 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:52159 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262538AbUCHSlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 13:41:46 -0500
Message-ID: <404CBE4C.2040502@matchmail.com>
Date: Mon, 08 Mar 2004 10:41:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grigor Gatchev <grigor@serdica.org>
CC: Christer Weinigel <christer@weinigel.se>, linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
References: <Pine.LNX.4.44.0403081311020.21912-100000@lugburz.zadnik.org>
In-Reply-To: <Pine.LNX.4.44.0403081311020.21912-100000@lugburz.zadnik.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grigor.

Theodore Ts'o pretty much summed it up, but let me add a couple things...

Grigor Gatchev wrote:
> 
> On Sun, 7 Mar 2004, Mike Fedyk wrote:
> 
> 
>>Grigor Gatchev wrote:
>>
>>>Here it is. Get your axe ready! :-)
>>>
>>>---
>>>
>>>Driver Model Types: A Short Description.
>>>
>>>(Note:  This is NOT a complete description of a layer,
>>>according to the kernel layered model I dared to offer.  It
>>>concerns only the hardware drivers in a kernel.)
>>>
>>
>>Looks like you're going to need to get a little deeper to keep it from
>>being OT on this list.
>>
>>What is the driver designs of say, solaris, OS/2, Win32 (NT & 9x trees)
>>and how are they good and how are they bad?
>>
>>What specific (think API changes, nothing generalized here *at all*)
>>changes could benefit linux, and why and how?  Nobody will listen to
>>hand waving, so you need a tight case for each change.
>>
>>HTH,
>>
>>Mike
> 
> 
> Dear Mike,
> 
> An year ago, I was teaching a course on UNIX security. After the
> first hour, a student - military man with experience of commanding PC-DOS
> users - interrupted me: "What is all that mumbo-jumbo about? Users,
> groups, permissions - all this is empty words, noise! Don't you at least
> classify your terminal, and issue orders on who uses it? Man, either talk
> some real stuff, or I am not wasting anymore my time on you!"
> 
> Of course, I was happy to let him "stop wasting his time on me".
> 

Yes, I can understand.  Dealing with users as a sysadmin isn't much 
different.

> Reading some of the posts here, I get this deja vu. I know the driver
> designs of some OS, and don't know others. I may waste a month or two of
> work, and post a huge description of all big OS driver models that I
> know, or waste an year of work, and give you a description of all big OS
> driver models. Will this give you anything more than what was already
> posted? Wouldn't you read my hundreds of pages, then try to summarise all,
> and eventually come to the same?

The descriptions were for my benefit, as whenever you were asked for 
specific, you were a little more specific in *design* terms, not code terms.

> Or you will try to pick this from one model, that from another, and end up
> assembling a creature with eagle wings, dinosaur teeth, anthelope legs and
> shark fins, and wondering why it can neither fly nor run nor swim really
> well, why it has bad performance? This can't be, I must have misunderstood
> you.
> 
> Also, does "think API changes, nothing generalised *at all*" mean anything
> different from "think code, no design *at all*"? If this is some practical
> joke, it is not funny. (I can't believe that a kernel programmer will not
> know why design is needed, where is its place in the production of a
> software, and how it should and how it should not be done.)
> 

No.  The designs you are talking about are *far* too generalized. 
Meaning, every proposal on this list that gets anywhere is for code 
modifications.  You need to have your *design* proposal in *code* speak. 
  Anything else will just be called hand waving.

> OK. Let's try explain it once more:
> 
> While coding, think coding. While designing, think designing. Design comes
> before coding; otherwise you design while coding, and produce a mess.
> Enough of such an experience, and you start believing that design without
> coding is empty words, noise. Hand waving.
> 
> What I gave is more than enough to start designing a good driver model.
> After the design is OKed, details of implementation, eg. API changes, may
> be developed. Developing them now, however, is the wrong time, for the
> reasons explained just above. Let's not put the cart ahead of the horse.
> 

I'm not a kernel programmer.

> Or I am wrong?

Maybe.  If you can have you design describe the current linux model as 
"in order to write to this SCSI disk I need to call foo(),..." and 
describe your new change as "if foo() called bar() I could do...".

Basically, you need to describe everything in programming terms.  A 
great example is the BIO design document from Jens Axboe.  That's an 
example of a design before code project (but I only happened to hear 
about it when 2.5.1 came out, and the code was ready to be merged...) .

Mike

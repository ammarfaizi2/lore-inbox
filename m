Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287633AbSA0N45>; Sun, 27 Jan 2002 08:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287840AbSA0N4q>; Sun, 27 Jan 2002 08:56:46 -0500
Received: from [195.63.194.11] ([195.63.194.11]:46349 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287633AbSA0N4d>; Sun, 27 Jan 2002 08:56:33 -0500
Message-ID: <3C54070D.4030704@evision-ventures.com>
Date: Sun, 27 Jan 2002 14:56:29 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de> <200201250802.32508.bodnar42@phalynx.dhs.org> <jeelkes8y5.fsf@sykes.suse.de> <a2sv2s$ge3$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>In article <jeelkes8y5.fsf@sykes.suse.de>,
>Andreas Schwab  <schwab@suse.de> wrote:
>
>>|> 
>>|> Storing 30% less executable pages in memory?  Reading 30% less executable 
>>|> pages off the disk?
>>
>>These are all startup costs that are lost in the noise the longer the
>>program runs.
>>
>
>That's a load of bull.
>
>Startup costs tend to _dominate_ most applications, except for
>benchmarks, scientific loads and games/multimedia. 
>
Well the situation is in fact even more embarassing if you do true 
benchmarking on really long running
(well that's relative of course) applications. I personaly did once in a 
time a benchmarking on the good
old tex running trhough a few hundert pages long document. Well the -O2 
version was actually about 15%
*SLOWER* then the -Os version. That's becouse in real world 
applications, which don't do numerical
calculations but most of the time they do "decision taking" the whole 
mulitpipline sceduling get's
outwighted by the simple cache pressure thing by *far*.

The whole GCC developement is badly misguided on this for *sure*. They 
develop for numerics where
most programs are kind of doing a controlling/decision taking job.
 Well I know I should try this with the kernel one time...


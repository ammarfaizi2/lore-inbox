Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751845AbWEPQML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbWEPQML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWEPQMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:12:10 -0400
Received: from relay00.pair.com ([209.68.5.9]:59398 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1751845AbWEPQMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:12:08 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 16 May 2006 11:12:03 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>
cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Wiretapping Linux?
In-Reply-To: <Pine.LNX.4.61.0605161100590.27707@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0605161052120.32181@turbotaz.ourhouse>
References: <4469D296.8060908@perkel.com> <Pine.LNX.4.61.0605161100590.27707@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, linux-os \(Dick Johnson\) wrote:

>
> On Tue, 16 May 2006, Marc Perkel wrote:
>
>> As most of you know the United States is tapping you telephone calls and
>> tracking every call you make. The next logical step is to start tapping
>> your computer implanting spyware into operating systems. Since Windows
>> and OS-X are proprietary this can be done more easilly with the
>> cooperation of Microsoft and Apple.
>>
>> So what about Linux? With thousands of people working on the Kernel if
>> someone from the NSA wanted to slip a back door into the Kernel, could
>> the do that? I know it's open source and it could be found if anyone
>> looks but is anyone looking? Is this something that would get noticed if
>> someone tried to do it? I'd like to think it would, but I'm going to ask
>> anyway just to make sure.
>>
>> Conversely, if Microsoft or Apple cooperated with the US government
>> could they implant sptware without packets or hidden files being noticed?
>>
>> I'm in the process of writing some articles about it and want to raise
>> the issue of US government implanted spyware everywhere. I know some
>> people might think this a little off topic but I'd rather be safe than
>> sorry. Who better to ask this question of than those who develop the kernel?
>>
>> Thanks in advance.
>
>
> The United States Government already implants
> spy-ware into the Windows Operating System.
> It's called "Magic Lantern" and it was part
> of the settlement that the government made
> with Microsoft when it had been charged with
> restraint of trade and other federal law
> violations. The settlement was made when
> most persons' attention was diverted after
> 9/11.
>
> Since most firewalls are open for the mail
> port and the http port, rumor has it that
> Microsoft networking looks at spare bits in
> the header (where the ECN bits are), and
> if it sees a certain combination, the packet
> is not a real mail or http packet, but an
> instruction for Magic Lantern. Presumably,
> the OS answers any request using the same
> method.
>
> 	http://www.wired.com/0,2100,48648,00.html
>
> Putting such a method into Linux would not
> be difficult now that networking is done
> as a separate issue. An evil network-code
> maintainer could duplicate the protocol.
> However, there are certain implementation
> details that would certainly attract the
> attention of other kernel developers.
>
> The most likely scenario would be for an
> application to answer queries from the
> outside world and send along private
> information. Any distributor could do
> this, even Red Hat!
>
> FI, do you truly __know__ what all this stuff does?
>
>   PID TTY      STAT   TIME COMMAND
>     1 ?        S      0:00 init [5]
>     2 ?        SW     0:00 [migration/0]
>     3 ?        SWN    0:01 [ksoftirqd/0]
>     4 ?        SW<    0:02 [events/0]
> [SNIPPED 85 lines...]
> 24006 tty1     S      0:00 /sbin/mingetty tty1
> 26778 ?        SW     0:00 [pdflush]
> 27253 tty2     S      0:00 -bash
> 27656 tty2     R      0:00 ps ax
>
> That's the stuff that's running on my "typical" system.
> How many Trojans are running? Maybe none, but don't
> bet your job on it. Just don't ever use any computer
> for anything you wouldn't want to be caught doing.
> It's just that simple!
>
> Many Windows "drivers" periodically "call home." Hewlett
> Packard printer drivers report how much ink is being used,
> etc. They use a something called "backweb".
>
> 	http://www.cexx.org/dlgli.htm
>
> Backweb is spyware, deliberately introduced into products
> so that manufacturers can keep track of product usage.
> They don't tell you that they are spying on you. They
> just do it.
>
> It's hard to find Windows products that don't contain
> such spyware. As Linux becomes more prevalent on the
> desktop, you can expect to find such spyware there
> too.
>

I really don't think there's much of a place for spyware in Linux. I'm 
sure that some company (should that be plural?) will manufacture such 
crap -- the issue is getting users to install it. (The +x bit 
goes a long, long way here to preventing users from doing this 
unknowingly.)

I feel about a billion times safer bringing everything in from Portage and 
kernel.org than I do running *anything* I got for money. (specifically, 
anything I can't tear open...) I think the possibility of deliberate 
malware being sent out through official channels isn't too terribly 
likely.

Free software isn't totally safe from malicious tinkering... this bit from 
Ken Thompson says a lot:

http://cm.bell-labs.com/who/ken/trust.html

The thing is that there is enough peer review in the open source world 
that not only would it be *difficult* to slip in some intentionally 
malicious code (and I don't think any malicious code of much potential 
would be likely to make it past LKML, especially if it doesn't closely 
adhere to CodingStyle :P) but it would not be long before someone noticed it.

Think about it - let's suppose we all fell asleep at the wheel, and 
someone did manage to get something nasty into Linus's tree. Not having a 
stable kernel API wins *yet again* because sooner or later the malicious code is 
going to break, and someone is going to end up asking questions. :)

What's the saying - "Given enough eyeballs, all bugs are shallow?" How 
about "Given enough eyeballs, all malware is in plain sight."

>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
> New book: http://www.lymanschool.com

Thanks,
Chase

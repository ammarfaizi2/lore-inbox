Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268840AbTB0AOs>; Wed, 26 Feb 2003 19:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268842AbTB0AOs>; Wed, 26 Feb 2003 19:14:48 -0500
Received: from mail-out2.cytanet.com.cy ([195.14.133.169]:13043 "EHLO
	mail-out2.cytanet.com.cy") by vger.kernel.org with ESMTP
	id <S268840AbTB0AOp>; Wed, 26 Feb 2003 19:14:45 -0500
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
References: <200302262224.h1QMOem0000411@81-2-122-30.bradfords.org.uk>
Message-ID: <oprk78rfg8ecyxzx@mail-out.cytanet.com.cy>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
From: wyleus <coyote1@cytanet.com.cy>
Date: Wed, 26 Feb 2003 19:24:41 -0500
In-Reply-To: <200302262224.h1QMOem0000411@81-2-122-30.bradfords.org.uk>
User-Agent: Opera7.01/Win32 M2 build 2651
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John - this reply is just to thank you for your help, and also using 
your advice to cc lkml the quoted text below in case it helps anyone else 
in the future.

On Wed, 26 Feb 2003 22:24:40 +0000 (GMT), John Bradford <john@grabjohn.com> 
wrote:

>> > Since you have eliminated a lot of the hardware, I would check whether
>> > the PSU is working correctly, if necessary by swapping in a spare one
>> > for a day or two.
>> > > The easiest way to exercise the machine is probably to do kernel
>> > compiles in a loop.  Memtest will exercise the memory, but not
>> > particularly exercise the CPU.
>>
>> Thanks for replying, John.
>
> No problem.
>
>> I'm a linux newbie and get heart attacks when someone suggests
>> compiling anything, *especially* messing around with the kernel.
>
> I didn't actually mean compile a new kernel to use, just goint through
> the compile stresses the CPU, cache, and RAM quite extensively.
>
> Programs to do burn-in testing tend to do things in a synthetic
> pattern, where as a kernel compile stresses the machine with a
> real-life workload.
>
>> Thus far, I've only installed RPMs though  the mandrake gui - though
>> I'm starting to feel like I could get brave and tackle my first
>> tarball configure/make/install soon.
>> Hope I'm not making you sick here... :-(
>
> No problems.  Bear in mind, though, that LKML is primarily a kernel
> developers mailing list - in general nobody will mind these sorts of
> questions, and infact they can be very useful in tracking down obscure
> bugs that only occur on certain hardware, but if other developers are
> busy, you might find your post is ignored.  Don't take it personally,
> this list typically gets 200 posts a day, and in general, people skim
> through it for subjects that are most relevant to where their skills
> lie.
>
>> Hope you won't mind bearing with some newbie questions;
>>
>> For the PSU, I don't have a spare one available, nor any other
>> computer parts.
>
> OK, that's a pity, because swapping it out is the easiest way to
> elimiate that as a problem, but never mind.
>
>> I received another reply to my post from Denis Vlasenko who
>> suggested, among other things, trying a program called cpuburn.  To
>> my delight, I found it was available in RPM format in mandrake
>> contribs.  It's running right now as I write this, and has been
>> about for about 50 minutes so far - with no crashes yet.  According
>> to the README included with the package, "If sub-spec, your system
>> may lock up after 2-10 minutes", but I'll keep running it some more
>> and try with different options for a more solid result.
>
> Hmmm, to be honest, like I mentioned above, some of these burn-in
> programs can be a bit synthetic, and not trigger something that a real
> workload will trigger within minutes.
>
>> The readme also mentions that it stresses more than just the cpu,
>> but also the mobo, cooling system, and PSU.
>
> Err, well all programs do that to a degree ;-).
>
>> Excerpt: "The goal has been to maximize heat production from the
>> CPU, putting stress on the CPU itself, cooling system, motherboard
>> (especially voltage regulators) and power supply (likely cause of
>> burnBX/MMX errors)."
>
> I would be skeptical of claims like that unless they reference a
> specific CPU - different chipsets handle things differently - what
> stresses a 386 might not particularly stress a 486.  Here again, we're
> talking synthetic loads.  Having said that, Denis Vlasenko is well
> respected on this mailing list, so it might be a particularly good
> utility for burn-in testing, I just don't have personal experience of
> it.
>
>> dumb newbie question #1:  I'm replying to your email personally.
>> Since I'm not suscribed to lkml, would it be possible (or advisable)
>> to reply to your message but have it posted on lkml?
>
> The normal protocol is to always CC LKML in on your replies, unless
> you're going off topic.
>
>> Example; if I just sent a new message to lkml with the subject line
>> "Re: syslog full of kernel BUGS, frequent intermittent instability"
>> would that have the same effect as replying to your message from
>> lkml? (I'm using the sylpheed-claws mail client if that make any
>> difference).
>
> No, most people use threaded mailreaders, and you don't want to break
> the thread.  The subject line is not really important, but if you
> change it, most people put something like:
>
> Underrated PSUs (was: syslog full of kernel BUGS)
>
> and it's an unofficial standard to put a one word 'sub-subject' in
> square brackets, E.G. [PATCH], or [BUG].
>
> I use ELM, and just use reply, then manually add anybody and the list
> in to the CC list as necessary.
>
> Do not worry about CCing people in who you know are subscribed - if
> you want a developer's attention, CC them.  Most of us delete list
> mail unread if we're too busy to read it.
>
>> dumb question #2:  If I eventually have no choice but to try a
>> different kernel, would it be possible to install one as easily as
>> installing any old RPM - and if so would it be just as easy to
>> restore my system after "trying out" the new kernel.  Wouldn't
>> changing the kernel break some of the specific settings mandrake set
>> for my system (e.g. my USB/DSL modem)?  I don't want to mess up what
>> I already have - don't want to reinstall from scratch if I break
>> everything - and I don't feel comfortable enough to replace
>> something as critical to my system as the kernel with all of the
>> arcane options and nuances that I don't have a clue about.
>
> I am not the best person to ask distro-specific questions like this,
> as I don't follow any particular distribution, but just install
> everything from source, but with some distributions, it *is* very easy
> to mess up that particular distribution's own way of doing things, by
> trying to install something from source.  In that respect, you would
> be best off asking another Mandrake user for guidance, rather than a
> general Linux person.
>
>> Sorry for the dumb questions, John,
>
> No problem.
>
>> it's frustrating to be a clueless newbie - seems like you have to
>> read hours/days/weeks of endless how-to's and man pages just to get
>> the simplest little things done.  I'm slowly learning, but it's
>> verrrry slooow progress. :-(
>
> If you've got time, skim through this mailing list's archives - there
> is a lot of info burried amoungst flamewars, arguments, and
> occasionally development work...
>
> John.
>
>
>



-- 
Using M2, Opera's revolutionary e-mail client: http://www.opera.com/m2/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282597AbRL0Vel>; Thu, 27 Dec 2001 16:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282525AbRL0Vec>; Thu, 27 Dec 2001 16:34:32 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:46682 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S282597AbRL0VeV>; Thu, 27 Dec 2001 16:34:21 -0500
Posted-Date: Thu, 27 Dec 2001 21:34:15 GMT
Date: Thu, 27 Dec 2001 21:34:15 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
In-Reply-To: <20011227005236.GB17344@msp-150.man.olsztyn.pl>
Message-ID: <Pine.LNX.4.21.0112272112450.3044-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik.

>>> I second this. Being a translator of the file in question, I have to
>>> deal with ten slightly different versions of "You may also compile
>>> this as a module...". So I have ten slighlty different translations
>>> of this text, too, in the name of accuracy.

>> I have to admit that I hadn't considered translators, but perhaps it
>> could be made even simpler for you. How about having the help file
>> start with a set of standard definitions, such as the following...
>> 
>> ===8<=== CUT ===>8===

>[cut indeed :-)]

8-)

>> ===8<=== CUT ===>8===
>> 
>> The rules would then reduce to "If the relevant condition applies,
>> append the text associated with the relevant DEFINE_ symbol to the help
>> text to be issued" and this could be done with an additional call to the
>> routine to extract the appropriate help text from the file. In addition,
>> your translation efforts would be restricted to just the COnfigure.help
>> file, and you wouldn't have to tweak the various configuration scripts
>> at the same time - and this would also ensure that the various config
>> scripts all used exactly the same help text.

> Nice, but - as Eric pointed out - there are many options where the
> "available as module" text actually contains a module name, which
> causes problems and makes your proposition insufficient for our needs.
> A complete solution would require serious changes which Eric doesn't
> want to introduce into a stable version.

Curiously enough, the changes I proposed are ones that I have already
implemented for `make config` and have nearly implemented for `make
menuconfig` at the moment, and I expect to have `make xconfig` ready
early in the new year. The module name part of it is trivially easy to
implement once the code to add the basic DEFINE_MODULAR text is there,
and the only change will be that the module name is always appended to
the end of the boilerplate rather than sometimes being in the middle and
sometimes at the end as it is now.

Because of this, I have no respect for this objection at all, and I have
to say that I would have expected a much better argument from Eric (for
or against this proposal) considering his progranmming skills.

>>> Although I thought there was an agreement that decimal kilobyte
>>> is kB, and binary kilobyte is KiB, decimal megabyte is MB, binary
>>> megabyte is MiB and so on, wasn't there?

>> That's the standard that the IEC has defined, and what this thread
>> is all about. Whether it'll get anywhere remains to be seen - ask
>> Ted T'so about the dangers of early adoption of proposed standards,
>> and he'll probably explain where his surname came from...

> Perhaps I will.

He explained that to me some time ago, and it's a similar story to this.

> But I still don't understand why you insist on choosing an opposite
> notation - that is xiB for decimal and xB for binary.

{Shrug} The exact text is an entry in Configure.help (under the symbol
DEFINE_UNITS as it happens) so in that sense, the fact that I made a
mistake as a result of misunderstanding the proposal is irrelevant.

> If at all, I would change the traditional convention to something
> exactly opposite, i.e. xiB for binary and xB for decimal, because
> M(mega),G(giga), etc. are standard SI units.

No problem - just edit the entries in Configure.help to say whatever
is consistent with the usage of the acronyms elsewhere in that file.

> PS. Don't Cc: me next time you reply, ok? I'm subscribed to lkml.

Blame the SysAdmin for that - if I choose (R)eply to a message, it
always addresses it to whoever posted it, and CC's anybody listed
elsewhere. I don't get the ability to change the "To" field, only the
"Cc" field, so you will always get a copy of any reply I send to an
email you've posted.

Best wishes from Riley.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVDLGUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVDLGUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVDLGSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:18:17 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.25]:54532 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262055AbVDLFpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:45:16 -0400
X-ME-UUID: 20050412054506286.45DC61C00204@mwinf0607.wanadoo.fr
Date: Tue, 12 Apr 2005 07:40:02 +0200
To: Marco Colombo <marco@esi.it>
Cc: Sven Luther <sven.luther@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050412054002.GB22393@pegasos>
References: <1113235942.11475.547.camel@frodo.esi> <20050411162514.GA11404@pegasos> <1113252891.11475.620.camel@frodo.esi> <20050411210754.GA11759@pegasos> <Pine.LNX.4.61.0504120034490.27766@Megathlon.ESI>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504120034490.27766@Megathlon.ESI>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 02:40:48AM +0200, Marco Colombo wrote:
> Which reminds me. The only reason why this thread belongs here, IMHO,
> it's because when it comes to GPL, it really doesn't matter what
> FSF's interpretation is, or anyone else's. The authors are choosing
> GPL as a license, so _thier_ interpretation is what really matters.

The main problem is that i feel that those binary firmware copyright holders
may have put it under the GPL, but i doubt they realize that this means they
have to release the source code of said firmware blobs.

Also, i believe you are wrong in the above, the only interpretation that is
important is the one the judge will take in case someone goes to suing.

And finally, if anyone could claim that a binary is the prefered form of
modification, which is most of the time obviously false, then the GPL would be
worthless. And anyway, the GPL states this (first paragraph after subclause c
in clause 3) :

  The source code for a work means the preferred form of the work for
  making modifications to it.  For an executable work, complete source
  code means all the source code for all modules it contains, plus any
  associated interface definition files, plus the scripts used to
  control compilation and installation of the executable.

So, this is not some interpretation of the GPL by the FSF, and since it is
written black on white in the actual GPL text, i don't think there is any
doubt what a judge will decice :

  judge : so, to create this piece of work, what do you use to make
  modifications ?
  A (having sworn on the bible to say the truth and only the truth) : euh,
  some C or asm code, and a compiler or assembler to compile it.
  judge : and you did voluntarily place said code and distribute it under the
  GPL ?
  A : yes, it was going into the linux kernel, so ...
  judge : so you should distribute the source code to your work also, and
  distributing it under GPL is a breach of expectation from whoever you
  distribute it to.

Or something such.

If A is going to say that he is the only author, and that he would never sue
because of this breach of the GPL, he could just as well have put it under a
different licence, or put a small disclaimer about it, since we cannot really
act as if we believed that A would never sue us, if he doesn't explicitly say
so.

As an example, i package the unicorn driver for the bewan soft-ADSL pci and
usb modems. These being soft-ADSL modems which use a non-free binary-only ADSL
emulating library, but are otherwise GPL, i discussed the matter with
upstream, and after council from debian-legal, and possibly the FSF people
themselves, we got to use this as GPL exception :

  In addition, as a special exception, BeWAN systems gives permission
  to link the code of this program with the modem SW library
  (modem_ant_PCI.o, modem_ant_USB.o), and distribute linked combinations
  including the two. You are also given permission to redistribute the
  modem SW library (modem_ant_PCI.o, modem_ant_USB.o) with the rest of the
  code.
  You must obey the GNU General Public License in all respects for all of
  the code used other than the modem SW library.

So, really, i doubt any manufacturer distributing non-free firmware would
really have trouble in adding to their licence something like this :

  In addition, <manufacturer>, considers the firmware blob, identified as <...>, as
  a non-derivative piece of work, and thus not covered by the GPL of the rest
  of it. <manufacturer> gives permission to distribute said firmware blob as
  part of the linux kernel module driver for their hardware. The actual syntax
  of the inclusion of the code is still covered by the GPL, as is the rest of
  the driver code.

If we where to get something as nicely pu as this, provide a patch, asking
the manufacturer to sign it of, then all issues would be void, i believe. 

> >>says so and it's A granting D the right to distribute. There's no way C
> >>can prevent D from distributing A's software, if A is fine with it.
> >>It's up to A to decide if GPL conditions are met by D.
> >
> >Even in that case, you still need explicit permission of A, and all the 
> >other
> >copyright holders of the rest of the GPLed work, to give you an explicit
> >exception to link with this non-free bit of code.
> 
> Yes, but it does not apply to our case here. There's no "all other
> copyright holders". _You_ stated that the firmware is included by mere
> aggregation, so there's no other holders involved. We're talking
> about the firmware case. A is one or two well identified subjects.
> And A wrote it is GPL'ed. Whether you agree or not, that's the licence
> A chose. A placed the copyright notice.

This is where i would need legal counsel, as to whether this means C or
someone else may stop you from distributing unless you provide the source. And
the real problem is that A didn't state anything, so we are only working on
the assumption that this may be the case, and A can change its mind later, and
the costs to defend ourselves in front of a judge, even if your
interpretations are right, are enough prohibitive for debian not to distribute
said files.

> The licence is a matter between A and D. A may sue D and D may (less
> likely) sue A, if conditions are not met. I'm not sure at all GPL
> is enforceable by D upon A. Let's assume it is, for sake of discussion,
> anyway.

Ah, but the licence is transitive, and if D may sue A, then C may also sue D,
since the GPL makes no distinction between who makes the distribution, apart
from the fact that A may relicence its code. But if he distributes it as part
of the GPL ...

> >No. The source code is clearly the prefered form of modification, not some
> >random intermediate state A may be claiming is source.
> 
> In this context, it is. Only A may sue D for not distributing the source.
> Whatever D distributes, D has to make A happy. If A is happy with D
> distributing `dd if=/dev/random count=1` as source, no one can stop D
> from doing that. Keep in mind A is the copyright holder. He grants
> rights to third parties. No one but A can remove them.

Yep, so if A was giving us an explicit right to distribute his sources,
everyone would be happy, this not being the case, we have to take the
hypothesis that A will sue us at a later time.

> [...]
> >>I'm not following. Are you saying what if A is bought? That is
> >>different. Well GPL is quite clear:
> >>
> >>1. You may copy and distribute verbatim copies of the Program's source
> >>code as you receive it, ...
> >>
> >>If D is distributing the source as received from A, D is in full
> >>compliance. How could A sue D? If A distributed incomplete source
> >>in the first place, it's not D's fault for sure. Do you really think
> >>the following scenario is likely:
> >>
> >>A to D: you must distribute the complete source, or the license will be
> >>        terminated!
> >>D to A: gimme the complete source, and I'll distribute it.
> >>A to D: no, I'm not willing to give you the full source of my firmware,
> >>        but you must distribute it anyway!
> >
> >The result is that the code in question has to be stopped from being
> >distributed by D. But the case here is different, since A is not the sole
> >copyright owner, so he doesn't get to set random interpretations of what is
> >source code.
> 
> Definitely I'm not following. How can D be ordered to stop distributing
> the software if A refuses to give the source? A is in violation. And
> even if GPL can't be enforced that way, by no means D is in violation
> when it's A that it's preventing D from complying.

The GPL says :

  If, as a consequence of a court judgment or allegation of patent
  infringement or for any other reason (not limited to patent issues),
  conditions are imposed on you (whether by court order, agreement or
  otherwise) that contradict the conditions of this License, they do not
  excuse you from the conditions of this License.  If you cannot
  distribute so as to satisfy simultaneously your obligations under this
  License and any other pertinent obligations, then as a consequence you
  may not distribute the Program at all.

The conditions of this licence are clear, the source code is the prefered form
of modification, so, if for "any other reason", you are not able to distribute
the source, then you "may not distribute the Program at all". The copyright
holder can, but there is no redistribution allowed. I will investigate about
if only A can sue over this though.

> The only way this can work the way you say is if A and D had a private
> agreement, and no proof can be made by D this agreement ever existed.

Well, there is no agreement whatsoever about this, and we don't know the
interpretation of A.

> But A released the software in public, and GPL'ed it. If A wants to keep
> part of the source obscured, he had better to stay well away from any
> court.

he could claim, as some did here, that obviously the fimrware was not GPLed,
but mere aggregation, and that he nowhere gave any right to distribute them.

> >>That, in court? Is this really what you're afraid of?
> >>The outcome is, very likely A will be forced to release the full source.
> >>(and D forced to distribute it, but all D's we're talking of here are
> >>very happy with the full disclosure scenario, aren't they?)
> >
> >Imagine A refusing to give away the source code, and D is ordered to remove
> >the incriminated code it is illegally distributing from all its servers, 
> >and
> >recall all those thousands of CD and DVD isos containing the code it
> >distributed, and being fined for each day it doesn't do so ?
> 
> Sorry, this is nonsense. D is well willing to distribute the source.
> In this case, he _is_ distributing what A publicly stated to be the source.

Yep, apart from the fact that A never did publicly state such issue, but just
passed it under silence.

> That's all. You say what if A changed his mind about what the source is?
> Well since it's still GPL'ed (we agree A can't chance the licence on the
> fly, right?) A is to provide the new, complete version of the source.
> Then, if and only if D refuses to distribute _that_ source, D is in
> violation. GPL requires D to distribute source _as received by A_.
> If A refuses to give the source, the specific requirement is not
> enforceable.

No, the GPL itself voids the distribubtion and redistribution rights if the
specific requirement is not fullfilled. This doesn't make the requirement not
enforceable, but voids the whole GPL licence and makes the work not
distributable.

> >>>This is the scenario i want to avoid by explicitly stating the 
> >>>relationships
> >>>of all copyright issues of those firmware blobs.
> >>
> >>I don't see this scenario nowhere close to likely. Of course, A can
> >>always sue any B, C, or D for whatever reason. It's very unlikely
> >>A will sue anyone in full compliance of GPL, but it's possible.
> >>There's nothing we can do about it. But there's no reason to worry
> >>either.
> >
> >So, we don't take the risk and don't distribute it. If A is not ready to 
> >put a
> >couple of lines of disclaimer on his work explaining the copyright and
> >licencing issues, then we are better of not distributing its code, which is
> >what debian will do.
> 
> There no such a risk. A already placed a copyright notice on his work.
> Is it the wrong one? Who cares? I'd even say that once he released it
> under GPL, he can't take it back.

But the GPL states that we must be able to distribute the sources, clearly
defines what said sources are, and states what happens if you can't fullfill
a clause of the GPL -> no right to distribute at all.

> >
> >I am not sure. If i where to get a copy of windows, and manage to install 
> >it
> >without clicking on the "i agree" button, does that make it a legal copy of
> >windows to use ?
> 
> Come on, please, do not mix things up. I've said GPL'ed software. Last time
> I checked, Windows was not GPL'ed (yet). :-)

What has the GPL to do with it ? 

Friendly,

Sven Luther


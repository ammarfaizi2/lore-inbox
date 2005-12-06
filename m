Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVLFUAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVLFUAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVLFUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:00:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:34006 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965008AbVLFUAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:00:09 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, David Woodhouse <dwmw2@infradead.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Bernd Petrovitsch <bernd@firmix.at>,
       Tim Bird <tim.bird@am.sony.com>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
In-Reply-To: <1133882715.4136.156.camel@baythorne.infradead.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <200512051826.06703.andrew@walrond.org>
	 <1133817575.11280.18.camel@localhost.localdomain>
	 <1133817888.9356.78.camel@laptopd505.fenrus.org>
	 <1133819684.11280.38.camel@localhost.localdomain>
	 <4394D396.1020102@am.sony.com> <20051206005341.GN28539@opteron.random>
	 <4394E750.8020205@am.sony.com> <1133861208.10158.34.camel@tara.firmix.at>
	 <1133863003.4136.42.camel@baythorne.infradead.org>
	 <20051206145025.GY28539@opteron.random>
	 <1133882715.4136.156.camel@baythorne.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Dec 2005 19:58:48 +0000
Message-Id: <1133899128.23610.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-06 at 15:25 +0000, David Woodhouse wrote:
> But yes -- its existence is indeed a 'sort of proof' that non-GPL
> modules are at least _considered_ to be OK in some situations. I wish
> we'd never invented EXPORT_SYMBOL_GPL() in the first place -- it appears
> to legitimise something which was never really OK in the first place,
> and weakens our position when we take it to court.

<Legalese see below for interesting content>

On the contrary. I can demonstrate I've repeatedly stated that I
consider almost all modules invalid, that I contributed code before
Linus ever made any comments about non-GPL modules and that he
incorporated code from bodies strongly of that view who granted no non
GPL usage without asking them for any exception (notably from the FSF)
(and Linus is added to this for legal reasons alone)

</End of legalese>


I think however you also have to work *with* rather than against a lot
of the vendors who are trying to manage awkward problems (even if
generally of their own historical making). There are plenty of people
who do need a good kicking and ship binary only Linux systems that need
dealing with well before you want to worry about the less clear cases.

People like Nvidia who have made business decisions based on the
licensing problems they face and looked at the question aren't the folks
to go chasing with large hammers even if its annoying. Start with the
folks who really genuinely don't care. A look at gpl-violations.org will
show the scale of that problem. 

Some of the other suggestions people have made don't work either. The
limit of power in a copyright license is constrained by law. The
drafters of copyright laws chose for good and sound reasons to say that
you can't use copyright agreements to interfere with non-derivative
works. They did this for a lot of good reasons.

EXPORT_SYMBOL_GPL also started with an intent to indicate internal
interfaces (ie those that are clearly derivative). If you want to split
the technology come legal issues and the politics rename it to
EXPORT_SYMBOL_INTERNAL. The only case for _GPL then would be to
specifically mark code that implements or derives from a work
implementing GPL patent licensed code. In those cases the derivative
work question is irrelevant as patents are not bounded in the same way.

That keeps the intent clear "this is an internal symbol", doesn't really
change the effect of any legal derivate works decision that I can see
(and its hard to see as caselaw for such cases is quite limited).

The enforcement side is also worth keeping because while we don't have
caselaw on the "lying about being GPL" case we do have some good
evidence in ongoing situations that corporate lawyers are very concerned
to discover they are shipping a lying module. Sorry no details on the
case in question can be public atm.

As to moving a function from _GPL, as I understand the legal situation
its up to the copyright holders to make a licensing change _if_ it is
one. If it isn't then it doesn't matter. If it is well Linus is probably
now personally liable (or OSDL) instead of Nvidia, his problem, his
choice. Is the new insert_page internal, that in itself isn't clear 

Alan


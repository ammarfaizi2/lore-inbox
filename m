Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbTGOLQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267200AbTGOLQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:16:46 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:35019 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S267190AbTGOLQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:16:44 -0400
Date: Tue, 15 Jul 2003 13:31:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Markus Gaugusch <markus@gaugusch.at>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030715113116.GA231@elf.ucw.cz>
References: <1058130071.1829.2.camel@laptop-linux> <20030713210934.GK570@elf.ucw.cz> <1058147684.2400.9.camel@laptop-linux> <20030714201245.GC24964@ucw.cz> <20030714201804.GF902@elf.ucw.cz> <20030714204143.GA25731@ucw.cz> <20030714230219.GB11283@elf.ucw.cz> <20030715063612.GB27368@ucw.cz> <20030715100842.GB3279@zaurus.ucw.cz> <Pine.LNX.4.53.0307151305270.30306@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307151305270.30306@dynast.gaugusch.at>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ... and so I believe right thing is to make magic sysrq combination for
> > aborting suspend...
> Pavel,
> SWSusp is mainly useful for desktop users. Although there may be cases
> where it is enabled on production machines, it should be aimed at desktop
> users as much as possible. The features to toggle reboot and abort suspend
> are really, really cool. And combining them with sysrq would just make
> them very very ugly. Someone mentioned the Gnome2 disaster, and I can only
> second that. Configurability IS important. And it should be easy as well
> (/proc is easy enough, good people or distributors can write a script and
> provide it to end users, etc.).
> To make the abort of swsusp configurable is the best compromise you can
> have, IMHO. I don't know why you are so stubborn and don't try to see the
> 'normal' people (I'm not one of those, but I'm trying to
> understand!!).

At one point I was suggesting that Esc feature perhaps could be done
by Esc and controlled same way magic sysrq is. No, nigel insisted that
it has to have separate config option.

I believe that's simply stupid.

Anyway, escape key has pretty well defined meaning: send ^[ to the
console. Altrough it might be nice for escape to return you back to
LILO during early boot, we are not doing that.

Kernel should do its job and policy should be in userland. "Escape
always stops suspend" is a security hole. => "Escape stops suspends"
has no place in kernel.

You might want Esc to mean ^C when user accidentaly starts "cat", but
you can't have that.

And now: special (and very ugly and very hacky) mechanism was
developed to control kernel from console. It is called magic
sysrq. Its ugly, but its also usefull. It is usable over serial
line. Aborting suspend fits in there.

Esc controlled by magic sysrq proc control is extremely ugly, but at
least it is not security hole any more, becuase user can already do
bad stuff to the computer.

Anyway, this thread is long and boring... If you are trying to
convince me with 10 000 mails "its important for users"... please
don't do that.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVF2BJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVF2BJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVF2BJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:09:45 -0400
Received: from smtp04.mrf.mail.rcn.net ([207.172.4.63]:28487 "EHLO
	smtp04.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S261389AbVF2BI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:08:56 -0400
X-IronPort-AV: i="3.93,240,1115006400"; 
   d="scan'208"; a="52944245:sNHT25078792"
Subject: Re: Newbie Roadmap?
From: Howard Owen <hbo@egbok.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: LKML List <linux-kernel@vger.kernel.org>, Eric Smith <eric@brouhaha.com>
In-Reply-To: <200506282141.j5SLfZbH010128@laptop11.inf.utfsm.cl>
References: <200506282141.j5SLfZbH010128@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Organization: EGBOK Consultants
Date: Tue, 28 Jun 2005 18:08:48 -0700
Message-Id: <1120007328.29900.67.camel@Quirk.egbok.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I originally sent this as a private reply to Horst, not having seen it
show up on the list. I can't resist tinkering, so this version is
slightly improved from the one I sent earlier. Sorry for the duplicate,
Horst. 


Thanks so much for your reply! 

If I needed the device to work for some practical purpose, I would agree
with your suggestion, and call the problem solved with a userland
driver. However, I'm interested in writing a proper driver mainly for
the fun and education of the effort. There is another hobbyist interest
that attracts me about the project. That will take a little explanation,
if you will indulge me.

The HP-41C won over a generation of engineers. It was a computing
system, rather than a mere programmable calculator. At about the same
time as the MITS, Altair and Apple 1 hobbyist microcomputers, HP came
out with this expandable machine. They also designed, and later released
the "dog-slow" HP-IL bit serial master/slave network. The fanatical
following of HP-41 enthiusiasts peaked in the US in the mid-to-late
1980s. Before then, they had built a culture of sharing that was not
unlike what emerged as the Berkeley branch of the "Open Source
Movement." The legacy of all this is a mountain of technical literature
and software. Hewlett Packard added greatly to the hoard by cutting
loose of most of the internal documentation on the HP-41C and its
peripherals under a "don't bother us" license.

Nowadays, there is still a community of engineers and similar folks who
like to play with HP-41Cs. These folks also have about 100 other HP
calculator models to play with, but the 41 seems to hang in there near
the top of people's lists. The culture partakes of the earlier sharing
culture that the original fans built. However, most of today's
participants are DOS or Windows users. For example, there are half a
dozen HP-41C emulators that run on PCs. All but one run on DOS/Windows
only. One of these is EMU41, by J. F. Garnier. This is a DOS application
that emulates the 41C at the microcode level. J. F. has also written
code to emulate the HP-IL loop, so his virtual calculator can have
virtual printers and disks attached to it. Another one of the old timers
of the HP-41 world, Cristoph Klug, has kept up correspondence with M.
Garnier. He decided to start raiding old HP-IL hardware for chips so he
could produce a new supply of the old HP-IL ISA card. This is the card
I'm interested in writing a driver for. Cristoph suggested to J. F. that
he modify EMU41 to allow it to talk to the real HP-IL board. J. F. did
this, and the result is a hardware/software combination that lets
virtual and real devices communicate over the HP-IL loop. It's pretty
cool. But J. F. and Cristoph are both old school. Neither of them have
expressed much interest in Linux. (One thing I hope to do is to tempt
them into paying more attention to Linux.)

I entered the picture a mere six weeks ago. I had been looking for a
software calculator to port to pdaXrom, a Linux OS for the Sharp Zaurus
clamshell PDA models. I ran across Nonpareil, the one and only HP-41C
emulator for Linux that I mentioned above. I successfully ported it in
an afternoon. (This is testament to the hard work of the pdaXrom crew
and to that of Eric Smith, the author of Nonpareil.) That got me
thinking about my old, long-lost  HP-41CV. I ended up buying one on eBay
and the rest, as they say, is history. I was hooked by the idea of
wedding the HP-41C, which is the machine on which I first learned to
program, to Linux, which has been my favorite OS since 1992, and is
currently what gives me the resources to buy old calculator gear. The
idea of bringing together the earliest computer technology I had contact
with and the latest cutting edge was irresistible to me.

So I've been in discussions with Eric Smith about emulating HP-IL for
Nonpareil. Eric is an obscure CPU microcode wizard. (Obscure CPU, not
obscure wizard. 8) Nonpareil doesn't merely emulate the HP-41C, it also
emulates every HP calculator leading up to the 41C with varying degrees
of success. Eric is a guy who could produce working emulations of disks
and printers, if I could talk him into it. And given a reasonable device
interface, he could talk to real hardware too. 

So that's my intention: to provide Eric with a reasonable driver for the
"HP-41C peripheral virtualization project," and to learn about 2.4 and
2.6 character mode drivers while I'm at it. Longer term, I want to
design and implement a USB interface to the HP-IL IC. That way I could
talk to my HP-41C from my Zaurus running pdaXrom, and then I wouldn't
need Nonpareil 8). (Although I'd still probably want access to the
virtual HP-IL driven coke machine Eric will undoubtedly write.)

Thanks again for your note!

Best regards,
 
Howard

On Tue, 2005-06-28 at 17:41 -0400, Horst von Brand wrote:
> Howard Owen <hbo@egbok.com> wrote:
> > I've embarked on a project to write device drivers for an obscure and
> > rare ISA card. It's a modern version of the HP 82973 HP-IL interface
> > produced by Cristoph Klug. HP-IL was a bit-serial, dog-slow version of
> > HP-IB (IEEE-488) that was designed to work with the HP-41C family of
> > calculators, and later with the HP-71 and HP-85. The 41C calculators are
> > my hobby interest. I'd like to introduce myself, and ask for pointers
> > for a newbie device driver author.
> 
> As you say later you have stuff working in userland under DOSEMU (and the
> "dog slow" part), I'd suggest a userspace driver. It is probably easier to
> work with, and has the advantage that you can run it under the bog-standard
> $DISTRO kernel with some care, no patching/reconfiguring/rebuilding to be
> done.
> 
> [No, I'm just an old hand here; no expert of any sort. Good luck!]
-- 
Howard Owen        hbo@egbok.com "Even if you are on the right
EGBOK Consultants Linux Architect track, you'll get run over if you
fwd:50279    pstn:+1-650-218-2216 just sit there." - Will Rogers


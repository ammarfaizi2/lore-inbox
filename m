Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSIAJyL>; Sun, 1 Sep 2002 05:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSIAJyL>; Sun, 1 Sep 2002 05:54:11 -0400
Received: from pd192.swietochlowice.sdi.tpnet.pl ([80.49.41.192]:18180 "EHLO
	cyborg.kernel.pl") by vger.kernel.org with ESMTP id <S316601AbSIAJyK>;
	Sun, 1 Sep 2002 05:54:10 -0400
Date: Sun, 1 Sep 2002 11:53:07 +0200 (CEST)
From: Krzysiek Taraszka <dzimi@pld.org.pl>
X-X-Sender: dzimi@chropaczow.eu.org
To: linuxppc-dev@lists.linuxppc.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <200208312335.g7VNZmk37659@sullivan.realtime.net>
Message-ID: <Pine.LNX.4.44L.0209011134310.2567-100000@chropaczow.eu.org>
References: <200208312335.g7VNZmk37659@sullivan.realtime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Aug 2002, Milton Miller wrote:

> At Fri Aug 30 2002 - 12:54:37 EST Krzysiek Taraszka (dzimi@pld.org.pl) wrote:
> > Great work, but in 2.2.22rc2 powerpc's still broken.
> > First of All Sources have got a lot of unsed stuff.
> > For example look like that:
> > 
> > [dzimi@cyborg linux]$ rgrep -n -R '*.*' 'CONFIG_PPC64' . 
> ...
> 
> Doesn't sound like -rc (release canidate) changes.

Well yes, in 2.2.10 someone tried to add CONFIG_PPC64 support in to 2.2 
kernel.
In 2.2.11 someone add CONFIG_PPC64 in to Config.in! but on 2.2.12 or 
2.2.13 someone remove it ... 
(without remove it from directory != arch/ppc/kernel/ )
 
> > Second kernel-2.2.21 still have got time init problems in symbios driver
> > on powerpc platform.
> > I send to you my ugly hack witch work, but IMHO he's ugly ;) I need to do
> > it correct.
> 
> > Third, kernel for powerpc boot and work on g3-266 but on g3-333 Ops ...
> > (kernel traps, kernel wrote: Caused by SRR1 or somethink like that, in 2.3
> > i saw #define FIX_SRR1 macro ...)
> 
> Well, SRR1 doesn't cause traps, but it does help tell you why they occurred.
> And the FIX_SRR1 stuff isn't the solution either if you look at it closer.
> How about a decoded oops?  Also, you didn't say what platform you were using.

I used g3 (pmac). My based system was PLD with 2.4.18 tree.
I used gcc-2.95.4 to build 2.2.21 vmlinux.

> As far as the open-pic changes you posted, how about explaining what your
> trying to fix (partly hidden by the rename and move to chrp_setup.c from
> open_pic.c)?

I tried to fix problem witch is on my IBM RS/6000 (model b50).
Openpic can't initialize propertly my scsi system. (sym82c8xx scsi 
driver). Some time init problems.

Oh I forgot, 2.2.22rc1/2 or kernel >= 2.2.16 (2.2 tree) didn't work on my 
IBM RS/6000 (b50).
Build with egcs work, but work slow (Bogomips: 16MHz!) and won't reboot 
and shutdown -h now.
The same code build with gcc Ops (Kernel Exception, look like openpic 
allocation address.)
I'll post the Ops later.

> I see you are wrapping the 8259 checks, but it also refers to a few new
> functions/macros I didn't see defined.

Hmm, yes, that why my patch is ugly. I want to do this correctly.
 
> How about discussing these problems and patches over at
> linuxppc-dev@lists.linuxppc.org ? (I set the reply-to there).

Ok, but first of all i should subscribe there.

Krzysiek Taraszka			(dzimi@pld.org.pl)



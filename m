Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263887AbTCWVYm>; Sun, 23 Mar 2003 16:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263894AbTCWVYm>; Sun, 23 Mar 2003 16:24:42 -0500
Received: from brynhild.mtroyal.ab.ca ([142.109.10.24]:22693 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S263887AbTCWVYk>; Sun, 23 Mar 2003 16:24:40 -0500
Date: Sun, 23 Mar 2003 14:35:25 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: linux-kernel@vger.kernel.org
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Robert Love <rml@tech9.net>,
       Martin Mares <mj@ucw.cz>, Alan Cox <alan@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, szepe@pinerecords.com,
       arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
In-Reply-To: <20030323203628.GA16025@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.51.0303231410250.17155@skuld.mtroyal.ab.ca>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz>
 <200303231938.h2NJcAq14927@devserv.devel.redhat.com>
 <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org>
 <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org>
 <402760000.1048451441@[10.10.2.4]> <20030323203628.GA16025@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Mar 2003, Pavel Machek wrote:

> Hi!
> 
...
> > If that's people's attitude ("you should use a vendor"), then we
> > need a 
> 
> I believe sentence "you should use a vendor kernel" schould be banned
> on this list ;-).
> 
> How badly would releasing 2.4.21 which does not have 2.4.20-preX as a
> parent mess version control systems?  

I shouldn't step in this but I am going to anyway.  BTW, the first 2 bits is
my opinion and can be discarded or whatever, not directed at anyone in
particular.

<subjectiveopinion>
First, I do agree with Alan, it's not his (or Marcelos'/Linus'/pick
your favorite kernel maintainer) problem if you choose not to go
with a vendor kernel.  I choose not to go with vendor kernels, primarily
because since days long past, when I started admining Linux
systems, the vendor kernels were not the most stable ones...  Times change
but habits are more difficult to.  That is why you can download the ptrace
patch from my personal website (http://www.hardrock.org/kernel/2.4.20/).
If you can't do it, or are not willing to stick your neck out to do it,
then use a vendor kernel and don't complain about the release cycle...

Second, the current patch isn't quite right.  It blocks even root from
tracing a process if needed and breaks chroot'ing from what I hear.
Including this as a release for 2.4.21 would be the "Wrong Thing" to do.
Could you imagine releasing something that breaks applications which require
these things to work as a "release" kernel?  Bad karma there...
</subjectiveopinion>

I do already host patches for current kernels which I use at work.  What
about just keeping a combined security and fixup patch set for the current
tree available for people to download and apply with instructions on doing
so and an index of what the patch contains and why? 

Given that the patches come from reputable sources (for example the ext3
patches for 2.4.20 and the ptrace patch) they can be
included without too much thought and some testing.  I could
maintain this, and it could be available either on kernel.org or just from
my website, no matter either way.  As I said, I'm already doing this so it
wouldn't be a huge bother anyway.

If anyone wants this to happen, let me know as it will then happen... 
Otherwise I'll continue to do it as I am now anyway, and everyone
is welcome to use this source for patches to the current tree.

Regards,
James Bourne



> 								Pavel

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

"There are only 10 types of people in this world: those who
understand binary and those who don't."


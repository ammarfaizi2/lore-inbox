Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270227AbRHGXhC>; Tue, 7 Aug 2001 19:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270219AbRHGXgx>; Tue, 7 Aug 2001 19:36:53 -0400
Received: from imladris.infradead.org ([194.205.184.45]:49413 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S270227AbRHGXgq>;
	Tue, 7 Aug 2001 19:36:46 -0400
Date: Wed, 8 Aug 2001 00:35:54 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Mark Atwood <mra@pobox.com>
cc: Andrzej Krzysztofowicz <ankry@pg.gda.pl>,
        Michael McConnell <soruk@eridani.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <m3g0b3v8zq.fsf@flash.localdomain>
Message-ID: <Pine.LNX.4.33.0108072359440.30936-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark.

 >>> Described above.

 >> What KERNEL problems then? I don't see any yet.

 > I smell the stench of finger pointing. It's a pity that it
 > stinks jsut as bad in the open source world as it is I am
 > "privileged" when closed source shops, or (even worse)
 > telco/network folks start playing "blameball".

I'm trying not to point any fingers anywhere, but I have to admit that
I'm finding it VERY difficult in this case. The basic problem that I
have is that the "way it's done" that I referred to in my posts so far
is the way that RedHat, Caldera, Debian, Mandrake, SUSE and Eridani
Linux all do it by default (I can't comment on SlackWare as I've never
been able to get it to install myself and don't know anybody who runs
it).

 > Userspace init scripts point the finger at kernel, saying "there
 > is no good and no well documented mapping method". Kernel points
 > its finger at userspace, saying "this is the way we do it" and
 > "we cant guarantee a perfect 100% mapping solution, so we're not
 > even going to try for 90%" and "futz with your drivers and
 > modules.conf and init scripts till you get something that
 > works".

I've certainly never stood in the position you call "Kernel" in that
description. Here's the situation as I see it, put in those sort of
terms, characters being InitScripts and Kernel respectively:

 1. InitScripts points at Kernel saying "there is no good and no
    well documented mapping method".

 2. Kernel replies "There is a good mapping method, which is to
    always map the ports starting with the lowest numbered one."

 3. InitScripts then tells Kernel "But I don't want to map the ports
    in ascending numerical order!"

So far, I've only seen the above scenario occur, and I have to admit
to having very little sympathy with it. However, I'm always open to
persuasion that the above is not the situation that is occurring.

 > Fingers back and forth, fingers pointing all around

 > and those of us with lots of different interfaces, and those of
 > us with several hot-plug interfaces

 > What happens to us?

 > We get the finger.

Not from me, you don't.

Let's deal with the various scenarios that I can see:

 1. Just one interface, either static or hotplug.

    By definition, there can be no problem here as the interface will
    always be eth0 when present, and missing when not.

 2. Multiple identical static interfaces.

    At the moment, you are required to initialise the interfaces in
    ascending order of their name in the modules.conf file.

    I've dealt with this situation on several occasions, and never
    found this to be a problem in any way.

 3. Multiple different static interfaces.

    At the moment, you are required to group these by the driver that
    controls them, simply because each driver will automatically map
    all interfaces that it supports when it is loaded. Likewise, you
    are required to initialise interfaces in ascending order of their
    name in the modules.conf file.

    I've dealt with this situation on several occasions, and never
    found this to be a problem in any way.

 4. Multiple hotplug interfaces.

    I have to admit to never having dealt with hotplug interfaces, but
    I understand some aspects of the interface are still being ironed
    out by the kernel developers. As a result, I would not be at all
    surprised to hear that problems still exist.

 5. Multiple static and hotplug interfaces.

    At the moment, you are required to group these by whether the
    interface is static or hotplug, configuring all static interfaces
    before any of the hotplug ones. This therefore reduces to being
    either case (2) or (3) followed by case (4), and should be dealt
    with accordingly.

As a result, the ONLY time I can see any problem occurring is when
there are multiple hotplug interfaces to deal with (case (4) above),
and this is acknowledged to be a case where some of the issues have
not yet been fully ironed out.

Can you agree with this analysis, or have I overlooked something?

Best wishes from Riley.


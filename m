Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270362AbRHHGrz>; Wed, 8 Aug 2001 02:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270358AbRHHGrq>; Wed, 8 Aug 2001 02:47:46 -0400
Received: from imladris.infradead.org ([194.205.184.45]:51974 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S270362AbRHHGrf>;
	Wed, 8 Aug 2001 02:47:35 -0400
Date: Wed, 8 Aug 2001 07:47:33 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Mark Atwood <mra@pobox.com>
cc: Andrzej Krzysztofowicz <ankry@pg.gda.pl>,
        Michael McConnell <soruk@eridani.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <m3g0b3v29e.fsf@flash.localdomain>
Message-ID: <Pine.LNX.4.33.0108080741280.12565-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark.

 >>	At the moment, you are required to group these by whether the
 >>     interface is static or hotplug, configuring all static interfaces
 >>     before any of the hotplug ones. This therefore reduces to being
 >>     either case (2) or (3) followed by case (4), and should be dealt
 >>     with accordingly.
 >>
 >> As a result, the ONLY time I can see any problem occurring is when
 >> there are multiple hotplug interfaces to deal with (case (4) above),
 >> and this is acknowledged to be a case where some of the issues have
 >> not yet been fully ironed out.
 >>
 >> Can you agree with this analysis, or have I overlooked something?

 > That is, yes indeed, pretty much the proper analysis, and my
 > situtation. My case can be summarized as one static interface,
 > followed by two (and if we can get the firewire stuff working,
 > soon potentially to be more) dynamic interfaces.

As long as the static interface is configured as eth0 before any of
the dynamic interfaces are looked at, it will remain fixed, and gets
taken out of the equation as a result.

As I understand it, the PCMCIA interface does the equivalent of...

	ifconfig eth1 down ; rmmod eth1

...when the interface on eth1 is unplugged, so the unplugging
shouldn't be a problem. However, I've no idea what it does on plugging
in a new interface, other than that is somehow signals the fact to the
kernel.

I can't comment on firewall as I know zilch about it, sorry.

Best wishes from Riley.


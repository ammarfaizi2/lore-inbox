Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267202AbSK3Aj5>; Fri, 29 Nov 2002 19:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbSK3Aj5>; Fri, 29 Nov 2002 19:39:57 -0500
Received: from s2.org ([195.197.64.39]:25063 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id <S267202AbSK3Aj4>;
	Fri, 29 Nov 2002 19:39:56 -0500
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-ac1
References: <200211292324.gATNOQO26672@devserv.devel.redhat.com>
From: Jarno Paananen <jpaana@s2.org>
Date: Sat, 30 Nov 2002 02:47:16 +0200
In-Reply-To: <200211292324.gATNOQO26672@devserv.devel.redhat.com> (Alan
 Cox's message of "Fri, 29 Nov 2002 18:24:26 -0500 (EST)")
Message-ID: <m3d6onx4rv.fsf@kalahari.s2.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> Linux 2.4.20-ac1
> o	VIA KT400 AGP support				(Nicolas Mailhot)

This doesn't seem to work on my setup, dmesg says:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT400 chipset
agpgart: unable to determine aperture size.

My machine has A7V8X motherboard with KT400 chipset and Radeon 9700
Pro running AGP 8X with sidebanding and fast-writes in Windows XP
so the setup itself should be ok.

AGP aperture is set to 64 megs in BIOS, other settings on auto.

I checked the code out a bit and the register supposed to be
containing the aperture size contains 0x1b while the values in the
array it is tested against are 0, 128, 192, 224, 240, 248 and 252
(192 being 64 megs)... Could this be caused by AGP 3.0 or something
that VIA handles differently than before? Anything else I could
test or help get it to work?

// Jarno

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSLAAyk>; Sat, 30 Nov 2002 19:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSLAAyj>; Sat, 30 Nov 2002 19:54:39 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:12439 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261354AbSLAAyj>;
	Sat, 30 Nov 2002 19:54:39 -0500
Date: Sun, 1 Dec 2002 00:59:04 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jarno Paananen <jpaana@s2.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-ac1
Message-ID: <20021201005904.GA22187@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jarno Paananen <jpaana@s2.org>, Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200211292324.gATNOQO26672@devserv.devel.redhat.com> <m3d6onx4rv.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d6onx4rv.fsf@kalahari.s2.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2002 at 02:47:16AM +0200, Jarno Paananen wrote:

 > > Linux 2.4.20-ac1
 > > o	VIA KT400 AGP support				(Nicolas Mailhot)
 > This doesn't seem to work on my setup, dmesg says:
 > agpgart: unable to determine aperture size.
 > My machine has A7V8X motherboard with KT400 chipset and Radeon 9700
 > Pro running AGP 8X with sidebanding and fast-writes in Windows XP
 > so the setup itself should be ok.
 > I checked the code out a bit and the register supposed to be
 > containing the aperture size contains 0x1b while the values in the
 > array it is tested against are 0, 128, 192, 224, 240, 248 and 252
 > (192 being 64 megs)... Could this be caused by AGP 3.0 or something
 > that VIA handles differently than before? Anything else I could
 > test or help get it to work?

I hadn't realised that was an AGP 3.0 chip. Its likely that we'll
need to change things to use different routines than the generic
ones if this is the case.  If it is the case, then it shouldn't be too
hard to figure out what to change, as long as VIA have the specs
available.. I'll dig around when I get back on Monday.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

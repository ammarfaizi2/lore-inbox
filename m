Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUGVWZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUGVWZn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 18:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUGVWZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 18:25:43 -0400
Received: from ns.indranet.co.nz ([210.54.239.210]:9687 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S267312AbUGVWZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 18:25:40 -0400
Date: Fri, 23 Jul 2004 10:25:07 +1200
From: Andrew McGregor <andrew@indranet.co.nz>
To: Florian Schmidt <mista.tapas@gmx.net>,
       "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
cc: rlrevell@joe-job.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary	Kernel
 Preemption Patch
Message-ID: <848056B606F178CF9FBDDAC2@[192.168.1.247]>
In-Reply-To: <20040721125352.7e8e95a1@mango.fruits.de>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
 	<1090306769.22521.32.camel@mindpipe>	<20040720071136.GA28696@elte.hu>
 	<200407202011.20558.musical_snake@gmx.de>
 	<1090353405.28175.21.camel@mindpipe>	<40FDAF86.10104@gardena.net>
 	<1090369957.841.14.camel@mindpipe>
 <20040721125352.7e8e95a1@mango.fruits.de>
X-Mailer: Mulberry/3.1.4 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, 21 July 2004 12:53 p.m. +0200 Florian Schmidt 
<mista.tapas@gmx.net> wrote:

> Hi,
>
> interesting that you mention the Xserver. I use a dual graphics card
> setup atm [Nvidia GF3 TI and some matrox pci card]. The nvidia card seems
> to work flawlessly even with HW accelleration [i use nvidias evil binary
> only drivers]. The matrox card OTH disturbs the soundcard severely.
> Whenever i have activity on my second monitor i get sound artefacts in
> jack's output [no cracklling, it's rather as if the volume is set to 0
> for short moments and then back to normal]. There's a certain chance that
> this artefact produces an xrun. I suppose it's because the card is on the
> pci bus.

<snip>

> Should i try a different 2nd gfx card? Should i avoid pci gfx cards at
> all costs? Will i just have to live w/o second monitor?  How do i find
> out which hw resources X is really using?
>
> Florian Schmidt


It is a PCI bus issue.  You simply don't have enough PCI bus cycles 
available to do what you want to do.  The resource you're running out of is 
bus bandwidth, and there's nothing to be done about it, other than remove 
the PCI gfx card from the system.

If you get another dualhead AGP graphics card (anything will do), the 
problem should go away.  We have a developer who does lowlatency 
multichannel sound stuff on a machine with a Matrox G450 dualhead card no 
problem.  I expect my own system (Radeon 9800 Pro and M-Audio 1010LT audio) 
would be fine dualhead too, although I only run it singlehead at the 
moment.  The 1010LT is 10 channels in and out of 24-bit 96kHz audio and 
works great down to 1.5ms buffers, so it is no small bus load itself.

Andrew


---------
Andrew McGregor
Director, Scientific Advisor
IndraNet Technologies Ltd
http://www.indranet-technologies.com/

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/E/B/PA/SS d+(++) s+:+ a C++$ ULS++++ !P+++(---)$ L++++$ E++ W++ !N
w(+++) !O() M++ V--() Y+$ PGP+ t- !5? X- !R !tv@ b++(++++) DI++ D+++@ G
e+++ h(*)@ r%
------END GEEK CODE BLOCK------

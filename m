Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266202AbUGULTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUGULTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 07:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUGULTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 07:19:40 -0400
Received: from pD9EB1635.dip.t-dialin.net ([217.235.22.53]:40837 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S266202AbUGULTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 07:19:39 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary	Kernel
	Preemption Patch
From: Thomas Charbonnel <thomas@undata.org>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       rlrevell@joe-job.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040721125352.7e8e95a1@mango.fruits.de>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1090306769.22521.32.camel@mindpipe> <20040720071136.GA28696@elte.hu>
	 <200407202011.20558.musical_snake@gmx.de>
	 <1090353405.28175.21.camel@mindpipe> <40FDAF86.10104@gardena.net>
	 <1090369957.841.14.camel@mindpipe>
	 <20040721125352.7e8e95a1@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1090408695.5179.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Jul 2004 13:18:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt wrote :
> Hi,
> 
> interesting that you mention the Xserver. I use a dual graphics card setup atm [Nvidia GF3 TI and some matrox pci card]. The nvidia card seems to work flawlessly even with HW accelleration [i use nvidias evil binary only drivers]. The matrox card OTH disturbs the soundcard severely. Whenever i have activity on my second monitor i get sound artefacts in jack's output [no cracklling, it's rather as if the volume is set to 0 for short moments and then back to normal]. There's a certain chance that this artefact produces an xrun. I suppose it's because the card is on the pci bus.
> 
> I figured it's maybe an irq issue problem, but whatever slot i put the gfx card in - it made no difference [btw: how do i find out which resources this card uses? it is not shown by /proc/interrupts]. I also tried putting the soundcard in many different slots to maybe get it on higher prio irq, but it always gets irq 5 [according to /proc/interrupts]..
> 
> Should i try a different 2nd gfx card? Should i avoid pci gfx cards at all costs? Will i just have to live w/o second monitor?  How do i find out which hw resources X is really using?
> 
> Florian Schmidt

You could try to adjust the pci latency timer value of your graphic card
and sound card, see this link for a paper on the subject by Daniel
Robbins :
http://www-106.ibm.com/developerworks/library/l-hw2.html

Thomas



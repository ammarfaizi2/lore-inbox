Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265175AbUGUKpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUGUKpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 06:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUGUKpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 06:45:33 -0400
Received: from imap.gmx.net ([213.165.64.20]:19689 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265175AbUGUKpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 06:45:31 -0400
X-Authenticated: #4399952
Date: Wed, 21 Jul 2004 12:53:52 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
Cc: rlrevell@joe-job.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary	Kernel
 Preemption Patch
Message-Id: <20040721125352.7e8e95a1@mango.fruits.de>
In-Reply-To: <1090369957.841.14.camel@mindpipe>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	<1090306769.22521.32.camel@mindpipe>
	<20040720071136.GA28696@elte.hu>
	<200407202011.20558.musical_snake@gmx.de>
	<1090353405.28175.21.camel@mindpipe>
	<40FDAF86.10104@gardena.net>
	<1090369957.841.14.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004 20:32:37 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> 
> Yes, this is important.  One problem I had recently with the Via EPIA
> board was that unless 2D acceleration was disabled by setting 'Option
> "NoAccel"' in /etc/X11/XF86Config-4, overloading the X server would
> cause interrupts from the soundcard to be completely disabled for tens
> of milliseconds.  Users should keep in mind that by using 2D or 3D
> hardware acceleration in X, you are allowing the X server to directly
> access hardware, which can have very bad results if the driver is
> buggy.  I am not sure the kernel can do anything about this.

Hi,

interesting that you mention the Xserver. I use a dual graphics card setup atm [Nvidia GF3 TI and some matrox pci card]. The nvidia card seems to work flawlessly even with HW accelleration [i use nvidias evil binary only drivers]. The matrox card OTH disturbs the soundcard severely. Whenever i have activity on my second monitor i get sound artefacts in jack's output [no cracklling, it's rather as if the volume is set to 0 for short moments and then back to normal]. There's a certain chance that this artefact produces an xrun. I suppose it's because the card is on the pci bus.

I figured it's maybe an irq issue problem, but whatever slot i put the gfx card in - it made no difference [btw: how do i find out which resources this card uses? it is not shown by /proc/interrupts]. I also tried putting the soundcard in many different slots to maybe get it on higher prio irq, but it always gets irq 5 [according to /proc/interrupts]..

Should i try a different 2nd gfx card? Should i avoid pci gfx cards at all costs? Will i just have to live w/o second monitor?  How do i find out which hw resources X is really using?

Florian Schmidt
-- 
Palimm Palimm!
Sounds/Ware:
http://affenbande.org/~tapas/


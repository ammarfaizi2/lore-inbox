Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTJaWzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 17:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbTJaWzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 17:55:21 -0500
Received: from griffin-can-au.getin2net.com ([203.43.225.34]:27144 "EHLO
	griffin-can-au.getin2net.com") by vger.kernel.org with ESMTP
	id S262092AbTJaWzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 17:55:16 -0500
Subject: Re: RadeonFB [Re: 2.4.23pre8 - ACPI Kernel Panic on boot]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Javier Villavicencio <jvillavicencio@arnet.com.ar>
In-Reply-To: <3FA2B4F4.8040404@enterprise.bidmc.harvard.edu>
References: <20031029210321.GA11437@dreamland.darkstar.lan>
	 <1067491238.1735.4.camel@ktkhome> <1067587196.715.1.camel@gaston>
	 <3FA2B4F4.8040404@enterprise.bidmc.harvard.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1067640904.1700.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 01 Nov 2003 09:55:05 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-11-01 at 06:16, Kristofer T. Karas wrote:
> Benjamin Herrenschmidt wrote:
> 
> >Ok, first thing: XFree "radeon" _is_ accelerated, though it doesn't
> >do 3D on recent cards
> >
> Hi Ben - Right, sorry, I mean to apply "accelerated" to the 3D effects; 
> the private ATI driver is much faster on glxgears than the version that 
> bundles with XFree.
> 
> >Then, the problem you are having is well known
> >
> I'm having two, actually.  The first is that YPAN is getting quite 
> confused.  If I switch VCs, then switch back, the text has been 
> re-arranged, the cursor is often invisible, and sometimes a page or two 
> of new text must be written before anything starts to show up on the 
> screen again.  Experimenting shows that setting VYRES = YRES works 
> around this problem.

I'll have to look at this in more details. I don't see why ypan would
cause such screen re-arrangement though...

> The second problem is of course the register contents issue when 
> returning from certain graphics programs (e.g. X+fglr) to text mode..  I 
> rather like your idea of doing a re-init when switching from KD_GRAPHICS 
> to KD_TEXT, as the monitor blank during resolution switch will likely 
> overshadow the re-init process.
> 
> >Can you verify that running fbset -accel 0 then back 1 cures the
> >problem for you ?
> >  
> >
> 
> At work now, will try when I return home later...
> 
> Kris

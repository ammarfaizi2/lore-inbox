Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVDVOgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVDVOgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 10:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVDVOgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 10:36:50 -0400
Received: from smtp06.auna.com ([62.81.186.16]:44249 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261947AbVDVOgq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 10:36:46 -0400
Date: Thu, 21 Apr 2005 21:17:03 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: nVidia stuff again
To: linux-kernel@vger.kernel.org
References: <1113341579.3105.63.camel@caveman.xisl.com>
	<425CEAC2.1050306@aitel.hist.no>
	<20050413125921.GN17865@csclub.uwaterloo.ca>
	<20050413130646.GF32354@marowsky-bree.de>
	<20050413132308.GP17865@csclub.uwaterloo.ca> <425D3924.1070809@nortel.com>
	<425E77BB.5010902@aitel.hist.no>
	<1114021024.26866.63.camel@compaq-rhel4.xsintricity.com>
	<21d7e997050420161234141e23@mail.gmail.com>
	<1114085702.26866.137.camel@compaq-rhel4.xsintricity.com>
	<20050421133554.GU17865@csclub.uwaterloo.ca> <4267BC1C.1050801@kromtek.com>
In-Reply-To: <4267BC1C.1050801@kromtek.com> (from manu@kromtek.com on Thu
	Apr 21 16:43:40 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1114118223l.10060l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.21, Manu Abraham wrote:
> Lennart Sorensen wrote:
> > On Thu, Apr 21, 2005 at 08:15:02AM -0400, Doug Ledford wrote:
> > 
> >>Ha!  That's the whole damn point Dave.  Use your head.  Just because ATI
> >>is getting more complex with their GPU does *not* mean nVidia is.  Go
> >>back to my original example of the aic7xxx cards.  The alternative to
> >>their simple hardware design is something like the BusLogic or QLogic
> >>cards that are far more complex.  Your assuming that because the ATI
> >>cards are getting more complex and people are less able to discern their
> >>makeup just by reading the specs that the nVidia cards are doing the
> >>same, nVidia is telling you otherwise, and you are just blowing that off
> >>as though you know more about their cards than they do.  Reality is that
> >>they *could* be telling the truth and the fact that their card is a more
> >>simplistic card than ATIs may be the very reason that ATI has ponied up
> >>specs and they haven't.  Therefore, you can reliably discern absolutely
> >>*zero* information about the nVidia cards from a reference to ATI specs.
> > 
> > 
> > Certainly possible.  Maybe all their real IP is in the code, although if
> > that was true, letting opensource peope ahve the programing spec and
> > have to do their own drivers wouldn't expose that IP.  I have no idea.
> > 
> 
> Even without opening up the code, but with programming specs there are 
> many graphics driver guys out there, given the specs out it would not be 
> too hard to have a decent driver, without the Nvidia IP. In that case 
> there would be no question of IP violation.
> 
> Or maybe somebody can do a clean room implementation provided Nvidia 
> agrees to some NDA, and the resultant work is acceptable to Nvidia 
> provided that it is free of their IP.. Many hardware vendors do resort 
> to these to get their hardware working properly under Linux, and in some 
> cases, the Linux driver has proved to be a better driver than their 
> Windows counterparts, albeit with lesser gimmicks/features.
> 

But the problem is like comparing CISC and RISC processors/code.
If you see the CISC assembler you do not see anything.
If you look at RISC code you can know many things about how the processor
pipelines are organized (you see interleaved float/int ops), you see how
much pipelines are there, what they do, and so on. Compare (hypothetically)
an ATI engine with 2 matrix-vector-multiply units and an nVidia with
8 dot product units. Perhaps ATI thought about doing matrices in parallel,
but never thought on doing rows in parallel. You could know that looking
at the code. Or at the programming specs ('load each row of your transform
in registers r0..r3 ....' )

I do not know how big are the ATI drivers, but looking at the nVidia ones,

werewolf:/lib/modules/2.6.11-jam14/kernel/drivers/video# ll
-rw-rw-r--  1 root root 4402072 Apr 14 23:18 nvidia.ko
werewolf:/usr/X11R6/lib# ll /usr/X11R6/lib/*7174*
-rwxr-xr-x  1 root root  485260 Apr 11 01:12 /usr/X11R6/lib/libGL.so.1.0.7174*
-rwxr-xr-x  1 root root 7626156 Apr 11 01:12 /usr/X11R6/lib/libGLcore.so.1.0.7174*

12 Mb of code is too much for a wrapper that just loads the hardware and
calls a rom ;) What is there ? Runtime loadable microcode ? Specially
optimized code for sending data to 2 pipes on a GeForce2 and 8 on a 6800 ?
Who knows. But sure the driver does _many_ things.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam14 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-7mdk)) #5



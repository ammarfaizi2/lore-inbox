Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265593AbTFXAhu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 20:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265596AbTFXAhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 20:37:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48654 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265593AbTFXAhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 20:37:47 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Crusoe's performance on linux?
Date: 23 Jun 2003 17:51:30 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bd87ai$bpp$1@cesium.transmeta.com>
References: <3EF1E6CD.4040800@thai.com> <3EF2144D.5060902@thai.com> <20030619221126.B3287@ucw.cz> <3EF67AD4.4040601@thai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3EF67AD4.4040601@thai.com>
By author:    Samphan Raruenrom <samphan@thai.com>
In newsgroup: linux.dev.kernel
>
> Vojtech Pavlik wrote:
> > Could you a test just for me? Take vanilla 2.4.21 and then
> > make oldconfig; make dep; time make bzImage 
> > That's basically what I want to know how long will take, since
> > it's one of the most common time consuming tasks the thing will
> > have to handle.
> Done! Here're the results:-
> 
> Desktop - Pentium III 1 G Hz 754 MB	->	10.x min.
> Tablet PC - Crusoe TM5800 1 GHz 731 MB	->	17.x min.
> 
>  From freshdiagnos benchmack, the TPC has about 2x faster RAM.
> I use tmpfs for the whole process so disk speed didn't count.
> Both test run without X or any foreground process using
> 2.4.21-ac1 and RedHat kernel.
> 
> What do you think?
> Shouldn't TM5800 with 4-wide VLIW engine and 64 registers,
> working on a single task, run as fast as a Pentium III?
> Why it take 70% longer for such small process (make+gcc+as)!
> There must be something wrong.
> 

I just realized something ... newer kernels if you do "make oldconfig"
without a .config file in the directory will look for one in /boot.
This could greatly skew the result.  Please create a .config and use
it on both systems to make sure that it's not an issue of what is
being compiled in.

I'm not saying that's the problem, I'm just trying to figure out what
the heck is going on here.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

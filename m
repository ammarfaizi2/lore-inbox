Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267275AbTGOLs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267300AbTGOLs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:48:26 -0400
Received: from mailb.telia.com ([194.22.194.6]:61890 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S267275AbTGOLsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:48:21 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, ajoshi@kernel.crashing.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb patch for 2.4.22...
References: <Pine.LNX.4.10.10307141315170.28093-100000@gate.crashing.org>
	<Pine.LNX.4.55L.0307141533330.8994@freak.distro.conectiva>
	<1058255052.620.2.camel@gaston>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Jul 2003 14:02:42 +0200
In-Reply-To: <1058255052.620.2.camel@gaston>
Message-ID: <m2ptkcknfh.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> > >
> > > Which is what the original 0.1.8 patch included, his fixes were included.
> > 
> > Ah really? I though that his changes were not merged in your 0.1.8 patch.
> > 
> > So can I just revert his patch and accept your instead that all of his
> > stuff is in ? Whoaa, great.
> 
> No. 0.1.8 lacks a lot of my stuffs

I have a small problem with radeonfb in 2.4.22-pre5 (+manually created
radeonfb.h file). During boot, when the console is switched over to
the frame buffer device, the screen becomes corrupted. Mostly by white
squares in a grid pattern and some squares with other colors. Between
the squares, normal characters can be seen, but each character is
duplicated. Here is a picture: (not very sharp unfortunately)

        http://w1.894.telia.com/~u89404340/radeonfb.jpg 

Text added after the switch is not corrupted, so eventually the
corruption is scrolled off the screen and after that the framebuffer
appears to be working correctly.

2.4.22-pre3 does not have this problem. I haven't found a patch for
the vanilla 0.1.8 version, so I don't know if that version also has
this problem. I think someone has reported a similar problem in 2.5.x,
but I don't remember the details.

Here are some messages from the kernel log:

Jul 14 23:08:44 best kernel: radeonfb: ref_clk=2700, ref_div=12, xclk=18300 from BIOS
Jul 14 23:08:44 best kernel: radeonfb: panel ID string: Samsung LTN150P1-L02    
Jul 14 23:08:44 best kernel: radeonfb: detected LCD panel size from BIOS: 1400x1050
Jul 14 23:08:44 best kernel: Console: switching to colour frame buffer device 175x65
Jul 14 23:08:44 best kernel: radeonfb: ATI Radeon M7 LW DDR SGRAM 64 MB
Jul 14 23:08:44 best kernel: radeonfb: DVI port LCD monitor connected
Jul 14 23:08:44 best kernel: radeonfb: CRT port no monitor connected

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

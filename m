Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTF0JCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 05:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTF0JCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 05:02:00 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:39301 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263632AbTF0JB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 05:01:59 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Date: Fri, 27 Jun 2003 19:15:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16124.2893.587755.586343@gargle.gargle.HOWL>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - ALPS glidepoint/dualpoint driver for 2.5.7x
In-Reply-To: message from Felipe Alfaro Solana on  June 27
References: <16123.44602.150927.280989@gargle.gargle.HOWL>
	<1056699687.599.2.camel@teapot.felipe-alfaro.com>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  June 27, felipe_alfaro@linuxmail.org wrote:
> 
> Is there any trick to force enabling ALPS support? I'm using a NEC
> Chrom@ laptop with an ALPS GlidePoint touchpad, 2.5.73-mm1 and your
> patch, but I can't seem to get the enhanced functionality of my
> touchpad, like using the edges of the touchpad to simulate the wheel or
> else. It seems to behave like a normal PS/2 mouse.

Well, if it behaves like a normal PS/2 mouse, it is quite possibly
working :-)  
That patch didn't add any obvious new functionality.  It just change
things to the ALPS device was used in absolute mode.
If you manage to find evtest.c, you can watch events on
/dev/input/event1 (or similar) and see the absolute event.

The next step is adding scroll-edge functionality and similar things
to mousedev.c 
I've almost got it so that when yor finger hits the edge of the
touchpad, the mouse keeps moving, and moves faster if you press
harder.   Once I'm happy with that I'll post it and start on the
scroll-wheel thing.

> 
> Also, on dmesg, I can't see any reference to an ALPS input device being
> detected. Any ideas?

No, the device isn't detected exactly.  See point 2 in the original
mail.

NeilBrown

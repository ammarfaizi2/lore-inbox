Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUDLPgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 11:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUDLPga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 11:36:30 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:60933 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262257AbUDLPgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 11:36:23 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Russell King <rmk+lkml@arm.linux.org.uk>, Ivica Ico Bukvic <ico@fuse.net>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- FIXED!
Date: Mon, 12 Apr 2004 17:31:20 +0200
User-Agent: KMail/1.5.2
Cc: "'Tim Blechmann'" <TimBlechmann@gmx.net>,
       "'Thomas Charbonnel'" <thomas@undata.org>, ccheney@debian.org,
       linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <20040412082801.A3972@flint.arm.linux.org.uk> <20040412144103.PIXB8029.smtp1.fuse.net@64BitBadass> <20040412155336.B12980@flint.arm.linux.org.uk>
In-Reply-To: <20040412155336.B12980@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404121731.20765.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 April 2004 16:53, Russell King wrote:
> On Mon, Apr 12, 2004 at 10:40:59AM -0400, Ivica Ico Bukvic wrote:
> > Sorry :-) Mandrake Community 10.0 using the 2.6.3 kernel with a patch to fix
> > the freezing when probing for the pcmcia card on this particular notebook
> > (see: http://www.muru.com/linux/amd64/).
> 
> Pavel's fix isn't really a fix, it's more a work-around.  If we keep
> increasing PCIBIOS_MIN_CARDBUS_IO until we hit 0xffff, everyones
> system stops working.
> 
> The problem there will be that there's some IO registers between 0x4000
> and 0x5000 which the BIOS wants access to, but the kernel didn't know
> that they existed.
> 
> In any case, 2.6.3 does not contain the patches for CB1410, so chances
> are that your problem is already half solved in 2.6.5.
> 
> Ok, so the action plan is:
> 
> - set 0xc9 to 0x04 for CB1410 (and others?)

EnE datasheet says it's also available in EnE 1211, 1225, 1420.
and since they are TI clones why not for the TI's too?


ico,

one question. when you insert the card in windows it changes
the latency timer at 0x0d to 0xff. what is the value at 0x1b? is it also 0xff?
if it's not 0xff can you try changing it to 0xff and set 0xc9 to 0x06?
i ask 'cos your screenshot w/o the card has it set to 0x00. and i have
the feeling that the bit at 0xc9 has something to do with the latency
timers....

rgds
-daniel


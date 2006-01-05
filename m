Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752141AbWAELFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbWAELFS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbWAELFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:05:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41655 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752141AbWAELFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:05:17 -0500
Date: Thu, 5 Jan 2006 12:05:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
In-Reply-To: <20060105103339.GG20809@redhat.com>
Message-ID: <Pine.LNX.4.61.0601051201200.21555@yvahk01.tjqt.qr>
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr>
 <20060105103339.GG20809@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>See the other patch I sent which halves the amount of lines needed
>for a backtrace on i386 (like x86-64 uses). This helps too.
>
.oO( Compress the oops, encode it base64 and display that instead )Oo. :-)

> > Is it be possible to change the VGA mode to 80x43/80x50/80x60
> > during protected mode?
>
>After an oops, we can't really rely on anything. What if the
>oops came from the console layer, or a framebuffer driver?
>
Well, setting the video mode can be done (on x86, ugh) with a BIOS call, so 
we would not need to run through oops-affected code. But that was the 
question, if this int 0x10 call was possible at all. Think of VBE -
VBE3 is the first version that can be done in protected mode.

>If I had any faith in the sturdyness of the floppy driver, I'd
>recommend someone looked into a 'dump oops to floppy' patch, but
>it too relies on a large part of the system being in a sane
>enough state to write blocks out to disk.
>
Right, sad world. (With fun I await the day someone writes a morse encoder 
that writes oops to keyboard leds.)



Jan Engelhardt
-- 

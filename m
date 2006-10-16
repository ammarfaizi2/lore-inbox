Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422746AbWJPMph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422746AbWJPMph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 08:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422752AbWJPMph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 08:45:37 -0400
Received: from twin.jikos.cz ([213.151.79.26]:29891 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1422746AbWJPMpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 08:45:36 -0400
Date: Mon, 16 Oct 2006 14:45:18 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Jan Beulich <jbeulich@novell.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: dwarf2 stuck Re: lockdep warning in i2c_transfer() with dibx000
 DVB - input tree merge plans?
In-Reply-To: <4533991C.76E4.0078.0@novell.com>
Message-ID: <Pine.LNX.4.64.0610161443010.29022@twin.jikos.cz>
References: <Pine.LNX.4.64.0610121521390.29022@twin.jikos.cz>
 <200610161231.30705.ak@suse.de> <4533991C.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Jan Beulich wrote:

> >> [<c0103b69>] dump_trace+0x65/0x1a2
> >> [<c0103cb6>] show_trace_log_lvl+0x10/0x20
> >> [<c0103f84>] show_trace+0xa/0xc
> >> [<c0103f99>] dump_stack+0x13/0x15
> >> [<c0132ea4>] __lock_acquire+0x7bd/0xa05
> >> [<c01333c1>] lock_acquire+0x5c/0x7b
> >> [<c034b683>] __mutex_lock_slowpath+0xab/0x1de
> >> [<f8902177>] i2c_transfer+0x23/0x40 [i2c_core]
> >> [<f88fa1bf>] dibx000_i2c_gated_tuner_xfer+0x166/0x185 [dibx000_common]
> >> [<f8902183>] i2c_transfer+0x2f/0x40 [i2c_core]
> >> [<f891f04b>] mt2060_readreg+0x4b/0x69 [mt2060]
> >> [<f891f45e>] mt2060_attach+0x40/0x1ea [mt2060]
> >> [<f895f468>] dibusb_dib3000mc_tuner_attach+0x126/0x16c 
> >> [dvb_usb_dibusb_common]
> >> [<d10ea000>] 0xd10ea000
> >> DWARF2 unwinder stuck at 0xd10ea000
> >Hmm, no assembly code or anything. Jan, do you have any ideas? This 
> >looks just like a simple callback that goes over a module boundary.
> No, except if this was compiled with gcc 4.0.x (or maybe earlier), in which
> case inspection of the unwind data might be needed to tell if it's one of the
> mis-generated cases that we saw earlier.

Hi,

(strippped CC list a bit)

Yes, it was compiled using gcc 4.0.2, specifically gcc (GCC) 4.0.2 
20051125 (Red Hat 4.0.2-8). I can easily reproduce this, what additional 
information do you need? Or should I just try with newer gcc?

-- 
Jiri Kosina

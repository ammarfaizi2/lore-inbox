Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270553AbTGUSSw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 14:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270627AbTGUSSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 14:18:52 -0400
Received: from dsl027-161-083.atl1.dsl.speakeasy.net ([216.27.161.83]:35847
	"EHLO hoist") by vger.kernel.org with ESMTP id S270553AbTGUSSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 14:18:51 -0400
Date: Mon, 21 Jul 2003 14:33:49 -0400
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 + matroxfb = unuusable VC
Message-ID: <20030721183349.GA492@suburbanjihad.net>
References: <7E154527EED@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E154527EED@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.28i
From: nick black <dank@suburbanjihad.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec assumed the extended riemann hypothesis and showed:
> I do not think that it has anything to do with AGP, as matroxfb does not
> initiate any AGP transfers. 

indeed, the issue would only happen after switching from x back to
console.  regardless, not building agp worked aorund the 2.4 problem for
me.

> > some info:  (cmdline, dmesg, config, lspci -v -v for bridge/card):
> > video=matroxfb:vesa:0x1bb
> 
> I think that you are using fbset somewhere in your initscripts. Either
> do not do that, or apply 
> ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.72.gz.

i am pretty sure no fbset is being employed; i find no reference to it
in /etc, nor does it seem to be installed anywhere.  i certainly haven't
set it up myself on this machine.

> And reconfigure your system to assign IRQ to the AGP devices too.
> matroxfb uses it for delivering some notifications to the userspace
> programs...
> >         Interrupt: pin A routed to IRQ 0
> ... if it hooked IRQ0 as MGA interrupt, anything can happen.

is this a bios issue?  if not, need i try anything save the suggested
irq=pcibios?  i'll report once i get home and can try things out;
thanks!

-- 
nick black <dank@reflexsecurity.com>
"np:  nondeterministic polynomial-time
the class of dashed hopes and idle dreams." - the complexity zoo

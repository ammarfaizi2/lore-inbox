Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUANEnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 23:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266298AbUANEnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 23:43:20 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:7383 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266296AbUANEm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 23:42:57 -0500
Date: Wed, 14 Jan 2004 04:40:45 +0000
From: Dave Jones <davej@redhat.com>
To: lkml@nitwit.de
Cc: Eric <eric@cisu.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: The hardware reports a non fatal, correctable incident occured on CPU 0.
Message-ID: <20040114044045.GA23845@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, lkml@nitwit.de,
	Eric <eric@cisu.net>, linux-kernel@vger.kernel.org
References: <200401091748.10859.lkml@nitwit.de> <200401091712.02802.eric@cisu.net> <200401101816.22612.lkml@nitwit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401101816.22612.lkml@nitwit.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 06:16:22PM +0100, lkml@nitwit.de wrote:

 > > 	Check your hardware CPU/MOBO/RAM. Overheating? Bad Ram? Cheap mobo?
 > > MCE should not be triggered under any circumstances unless it is a kernel
 > > bug(RARE, I believe the MCE code is simple) or you REALLY have a hardware
 > > problem. As said before, the bios is resetting your fsb to 100 as a
 > > fail-safe because something bad happened.
 > 
 > Well, my system did run very stable and in the meantime again does run very 
 > stable on both, 2.4.21 and Windows XP...

Neither of which check for the presence of these errors.

 > > > What the fuck is going on here?? As far as I figured out this has
 > > > something to do with MCE (CONFIG_X86_MCE=y, CONFIG_X86_MCE_NONFATAL=y)
 > > > (?).
 > >
 > > 	Leave it enabled, its a good thing to tell you when you have bad hardware.
 > > Its not a kernel problem, but a feature.
 > 
 > Well, it is a good thing to tell me, but it's not a good thing to make my 
 > system auto-reset itself before reaching the BIOS afterwards...

The non-fatal MCE code doesn't do anything like that.  Any odd side-effects that you
observed were very likely due to whatever caused the MCE in the first place.


		Dave


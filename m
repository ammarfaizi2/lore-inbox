Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbTKFA3Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 19:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTKFA3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 19:29:25 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:6272 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263294AbTKFA3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 19:29:23 -0500
Subject: Re: Re:No backlight control on PowerBook G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Egger <degger@fhm.edu>
Cc: Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1067976347.945.4.camel@sonja>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
	 <1067820334.692.38.camel@gaston>  <1067878624.7695.15.camel@sonja>
	 <1067896476.692.36.camel@gaston>  <1067976347.945.4.camel@sonja>
Content-Type: text/plain
Message-Id: <1068078504.692.175.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 11:28:25 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-05 at 07:05, Daniel Egger wrote:
> Am Mon, den 03.11.2003 schrieb Benjamin Herrenschmidt um 22:54:
> 
> > > Interesting, will try. I've a whole bunch of more pressing problems with
> > > my new baby, though. X is completely broken, no matter which X modelines
> > > I configure I get nothing but sizzle on the screen, it seems that the
> > > mode setup for the LVDS with the 9600 Mobility is bork.
> 
> Just checked. It doesn't work with the  latest (Linus) 2.6-test and
> radeonfb. Do you have any special patches in your tree for radeonfb?

No, I told you to use _my_ 2.6 tree which contains a new radeonfb
that have not yet been merged upstream.

bk://ppc.bkbits.net/linuxppc-2.5-benh or rsync from
source.mvista.com::linuxppc-2.5-benh

> BTW: It took me quite a while to figure out that the only working image
> with yaboot was the zImage.chrp. The normal vmlinux doesn't contain a
> valid ELF signature (according to yaboot) and the seemingly obvious
> vmlinux.elf-pmac goes boom while trying to decompress the kernel.

Ugh ?

Yaboot normally loads a plain vmlinux, though if you are using tftp, you
need to modify yaboot to be able to d/l more than 4Mb (edit fs_of.c and
change the allocated size). The ELF image should work, at least the
one produced by my tree does, it's possible that there's a similar size
problem with the one in Linus tree, a few of those recent changes haven't
yet made it to Linus.

Ben.



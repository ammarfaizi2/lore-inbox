Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbTKIDAZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 22:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTKIDAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 22:00:25 -0500
Received: from mel1.uecomm.net.au ([203.94.129.130]:13481 "EHLO
	mel1.unite.net.au") by vger.kernel.org with ESMTP id S262064AbTKIDAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 22:00:23 -0500
Subject: Re: Re:No backlight control on PowerBook G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Daniel Egger <degger@fhm.edu>
Cc: Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1068198639.796.109.camel@sonja>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
	 <1067820334.692.38.camel@gaston>  <1067878624.7695.15.camel@sonja>
	 <1067896476.692.36.camel@gaston>  <1067976347.945.4.camel@sonja>
	 <1068078504.692.175.camel@gaston>  <1068198639.796.109.camel@sonja>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1068346792.673.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 09 Nov 2003 13:59:53 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-07 at 20:50, Daniel Egger wrote:
> Am Don, den 06.11.2003 schrieb Benjamin Herrenschmidt um 01:28:
> 
> > No, I told you to use _my_ 2.6 tree which contains a new radeonfb
> > that have not yet been merged upstream.
> 
> Still cannot try this because your kernel wouldn't even survive yaboot.

Can you give details ? It should work just fine, except if I broke
something in the past few days when getting G5 support in, but I didn't
have any other report of this, so...

> With your tree I now have the problem that it doesn't even boot anymore.
> The CHRP kernel which worked before stopped after "CHRP kernel
> loader...", the elf-pmac one still crashes with:
> Elf32 kernel loaded...
> chrpboot starting: loaded at 0x01000000
> heap at 0x00003000
> gunzipping (0x00010000 <- 0x01006cf8:0x01155486)...
> Decrementer exception at %SRR0: 01005804   %SRR1: 00003030
>  ok
> 0 >

Well, you are not supposed to use the zImage.chrp on a PowerMac,
and definitely not from yaboot.

It may have altered some open firmware settings in a bad way.
I suggest you reset your nvram first (hopefully, booting with
cmd-opt-P-R will do the trick).

Last I tried, then just netbooting vmlinux.elf-pmac worked fine
on all the "newworld" models I have here). For yaboot, you need
to load a plain vmlinux binary.

Ben.


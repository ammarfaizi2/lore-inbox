Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbUKTHe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUKTHe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 02:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUKTHe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 02:34:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:58771 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262838AbUKTHeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 02:34:11 -0500
Subject: Re: pci-resume patch from 2.6.7-rc2 breakes S3 resume on some
	machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
References: <1100811950.3470.23.camel@mhcln03>
	 <20041119115507.GB1030@elf.ucw.cz> <1100872578.3692.7.camel@mhcln03>
	 <1100872578.3692.7.camel@mhcln03> <1100905563.3812.59.camel@gaston>
	 <E1CVLDU-0005jG-00@chiark.greenend.org.uk>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 18:33:40 +1100
Message-Id: <1100936020.5238.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 02:43 +0000, Matthew Garrett wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> >> Sorry, that's beyond my abilities. That's why I'm posting here. I'm not
> >> even sure that it's the radeon which is acting up here.
> > 
> > Have you tried with radeonfb in your kernel config ?
> 
> In the general case, it's harder to resume systems using framebuffers
> than systems that don't. The contortions that are necessary for non-fb
> systems tend to break fb systems (you end up with userspace and the
> kernel both trying to get the graphics hardware back into a sane state),
> so in an ideal world resume would work without any framebuffer support.

Bullshit...

Well... In an ideal world, the video chip would come up all back by
itself and nobody would have to care... unfortunately we aren't in an
ideal world.

With the way video cards are evolving, we'll soon have no choice but
have a kernel driver bring the chip back. Userspace has nothing to do
with that, and userspace & kernel aren't fighting over it.

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268147AbTBYNZW>; Tue, 25 Feb 2003 08:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbTBYNZW>; Tue, 25 Feb 2003 08:25:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21521 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268147AbTBYNZV>; Tue, 25 Feb 2003 08:25:21 -0500
Date: Tue, 25 Feb 2003 13:35:33 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Remco Post <r.post@sara.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Message-ID: <20030225133533.A18105@flint.arm.linux.org.uk>
Mail-Followup-To: Remco Post <r.post@sara.nl>, linux-kernel@vger.kernel.org
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk> <20030225110704.GD159052@niksula.cs.hut.fi> <20030225113557.C9257@flint.arm.linux.org.uk> <20030225135010.69f9f58f.r.post@sara.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030225135010.69f9f58f.r.post@sara.nl>; from r.post@sara.nl on Tue, Feb 25, 2003 at 01:50:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 01:50:10PM +0100, Remco Post wrote:
> Hmm, and how would you implement that on a system (ppc/prep) that could very
> easily netboot a kernel... no /boot needed? I for one build kernels on one
> box that is more or less production and netboot another just to see it fail
> horribly... having all stuff in one file could help....

So you want to transfer the complete zImage, including the redundant
configuration and system.map to the target over the network, only to
have it thrown away?

Guess what?  I netboot ARM boxes as well.  I cope.  It's easy.  You
change /boot/ to be $TARGET (eg, /var/boot/kernels/), which is where
you put your netboot kernel image today.

If you have more than one kernel build, then put it in
TARGET=/var/boot/kernels/<machine-name>/

Or, in the case of a NFS root setup, you place all the files in the
boot directory of the NFS root image for the target system.  This way,
the target gets the correct System.map, again with no extra hastles.

I do all of the above (minus the .config.)  It works.  Nice.  Simple.
No hastle.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLPR3P>; Sat, 16 Dec 2000 12:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129807AbQLPR3G>; Sat, 16 Dec 2000 12:29:06 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:48653 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129408AbQLPR2z>; Sat, 16 Dec 2000 12:28:55 -0500
Date: Sat, 16 Dec 2000 10:58:23 -0600
To: Dima Brodsky <dima@cs.ubc.ca>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Sound (emu10k1) broken in 2.2.18
Message-ID: <20001216105823.H3199@cadcamlab.org>
In-Reply-To: <20001215215031.A743@cascade.cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001215215031.A743@cascade.cs.ubc.ca>; from dima@cs.ubc.ca on Fri, Dec 15, 2000 at 09:50:31PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Dima Brodsky]
> 	cat x > /dev/dsp

> 	bash: /dev/dsp: No such device
> 
> But an ls -l shows:
> 
> crw-rw-rw-   1 root     sys       14,   3 Dec 15 21:25 dsp
> crw-rw-rw-   1 root     sys       14,  19 Dec 15 21:25 dsp1

'ls -l' is useless, here.  Sure the device files exist, but bash is
telling you that, kernel-side, they are not connected to anything.

- Do you have emu10k1 compiled in, or as a module?
- Does your SBLive appear to have been detected?  (Check 'dmesg')
- If emu10k1 is a module, is the module loaded?  Does it seem to detect
  your SBLive when loaded?  (Again check 'dmesg')

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

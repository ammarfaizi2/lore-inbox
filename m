Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268427AbTBYVQs>; Tue, 25 Feb 2003 16:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268424AbTBYVQo>; Tue, 25 Feb 2003 16:16:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45832 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268379AbTBYVOp>; Tue, 25 Feb 2003 16:14:45 -0500
Date: Tue, 25 Feb 2003 21:24:57 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Message-ID: <20030225212457.G21014@flint.arm.linux.org.uk>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk> <b3gi0e$g2i$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b3gi0e$g2i$1@cesium.transmeta.com>; from hpa@zytor.com on Tue, Feb 25, 2003 at 12:00:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 12:00:14PM -0800, H. Peter Anvin wrote:
> Followup to:  <20030225092520.A9257@flint.arm.linux.org.uk>
> By author:    Russell King <rmk@arm.linux.org.uk>
> In newsgroup: linux.dev.kernel
> >
> > On Tue, Feb 25, 2003 at 07:28:46AM +0100, Mikael Starvik wrote:
> > > >I don't know linker scripts very well.
> > > >Can this be done for all architectures?
> > > >I'd like to see a solution that is arch-independent.
> > > 
> > > In embedded systems it is probably not desirable to keep 
> > > System.map and config in zImage (takes too much valuable space).
> > 
> > Agreed - zImage is already around 1MB on many ARM machines, and since
> > loading zImage over a serial port using xmodem takes long enough
> > already, this is one silly feature I'll definitely keep out of the
> > ARM tree.
> > 
> 
> Isn't that what "strip" is for?

zImage on ARM is a binary blob without any formatting.  The first
instruction to be executed is at the start of the file.  Perfect
for loading directly into flash or RAM via whatever boot loader
or debugger you choose.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


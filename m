Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSFDU17>; Tue, 4 Jun 2002 16:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSFDU17>; Tue, 4 Jun 2002 16:27:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24582 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316674AbSFDU15>; Tue, 4 Jun 2002 16:27:57 -0400
Date: Tue, 4 Jun 2002 21:27:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 -- Hanging (no oops and sysrq fails) after switching to rivafb
Message-ID: <20020604212747.C32338@flint.arm.linux.org.uk>
In-Reply-To: <1023175418.7859.32.camel@agate> <Pine.LNX.4.44.0206041314110.1200-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 01:16:49PM -0700, James Simmons wrote:
> 
> > I tried booting both with acpi enabled and with pci=noacpi set.
> > When the machine freezes, the VT display mode has just switched
> > to using rivafb (video=riva:1600x1200-16).
> 
> I plan to port this driver next over to the new api. I planned on doing it
> today except Linus BK tree will not compile right now :-( I get a
> 
> /usr/include/asm/eerno.h:4: asm-generic/errno.h: No such file or directory
> make[1]: *** [split-include] Error 1

If you're seeing this then your /usr/include/{asm,linux} are symlinks to
your current kernel source.  These directories must contain a copy of
the kernel header files that were used to build glibc with, not the
copy that came with the kernel you're currently running.

(Please note: this is a FAQ - there's probably even a FAQ entry for it.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


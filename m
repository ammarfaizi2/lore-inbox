Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262505AbTDANEi>; Tue, 1 Apr 2003 08:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262508AbTDANEi>; Tue, 1 Apr 2003 08:04:38 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:60388 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262505AbTDANEh>; Tue, 1 Apr 2003 08:04:37 -0500
Date: Tue, 1 Apr 2003 14:15:55 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Eric Brunet <ebrunet@lps.ens.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 845GE Chipset severe performance problems
Message-ID: <20030401131555.GA27443@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Eric Brunet <ebrunet@lps.ens.fr>, linux-kernel@vger.kernel.org
References: <20030401124404.GA26931@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401124404.GA26931@lps.ens.fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 02:44:04PM +0200, Eric Brunet wrote:

 > As there is this thread about mtrr on Intel chipsets, I have some
 > messages in the log about mtrr, and I don't know whether they are
 > harmless warnings or errors that should be reported.
 > 
 > My computer is a 2.4 GhZ Pentium IV with an intel i845G/GL chipset.
 > Motherboard and bios by shuttle.
 > 
 > $ cat /proc/mtrr
 > reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
 > reg01: base=0x1f800000 ( 504MB), size=   8MB: uncachable, count=1
 > reg02: base=0xe0000000 (3584MB), size= 128MB: write-combining, count=2
 > 
 > I have 512 MB of memory, the motherboard doesn't support more than 2GB
 > and I don't see what is this range over 3.5 GB. Also, the two first
 > overlaping ranges look suspicious.

overlapping is allowed. Does this board have onboard graphics ?
It looks like your top 8MB is shared video memory. (Ie, the graphics
chip doesn't have its own RAM). Usually theres things in the BIOS
to adjust the amount of RAM to allocate to the 'card' including
a disable option if you have a real card inserted instead.

 > So... Is this situation normal ?

Could be. If the answer to the above question is yes, then its normal.
What exactly are you finding slow ?

		Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266154AbTIKG2w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 02:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266160AbTIKG2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 02:28:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29157 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266154AbTIKG2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 02:28:22 -0400
Date: Thu, 11 Sep 2003 08:28:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030911062816.GX27368@fs.tum.de>
References: <200309071647.h87Glp4t014359@harpo.it.uu.se> <20030907174341.GA21260@mail.jlokier.co.uk> <1062958188.16972.49.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062958188.16972.49.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 07:09:49PM +0100, Alan Cox wrote:
>...
> > I'm not sure if an Athlon is "lower" than a PII or not....  Which do I
> > option do I pick, to run on either of those without including
> > redundant stuff for older CPUs?
> 
> Right now its ordered
> 
> 386 - 486 - 586 - 586+TSC - 686 - PPro - PII - PIII - PIV
> 
> Geode is a branch off 586+TSC and supports 686+ too
> Athlon branches off from PIII if I remember rightly
> Winchip branches off from 586 and supports all later x86 too
> ELAN is its own weird world
> Xmeta comes off 686 somewhere depending how you handle PGE

x86 is a complicated family...

My current list of CPU specific questions is:

- Does the Cyrix III support 686 instructions?
- Do -march=winchip{2,-c6} and -march=c3{,-2} add anything not in
  -march=i686 (except optimizations of otherwise compatible code)?
- Which CPUs exactly need X86_ALIGNMENT_16?
- X86_GOOD_APIC: Are there really that many processors with a bad APIC?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


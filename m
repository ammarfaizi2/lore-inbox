Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbSJZOEi>; Sat, 26 Oct 2002 10:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbSJZOEi>; Sat, 26 Oct 2002 10:04:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52787 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262178AbSJZOEh>; Sat, 26 Oct 2002 10:04:37 -0400
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@redhat.com
Subject: Re: [PATCH] Double x86 initialise fix.
References: <200210261242.g9QCgSqp030280@noodles.internal>
	<1035640580.13032.100.camel@irongate.swansea.linux.org.uk>
	<20021026134947.GA31349@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Oct 2002 08:08:46 -0600
In-Reply-To: <20021026134947.GA31349@suse.de>
Message-ID: <m1fzutl2c1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:

> On Sat, Oct 26, 2002 at 02:56:20PM +0100, Alan Cox wrote:
>  > > For many moons, we've been executing identify_cpu()
>  > > on the boot processor twice on SMP kernels.
>  > > This is harmless, but has a few downsides..
>  > > - Extra cruft in bootlog/dmesg
>  > > - Spawns one too many timers for the mcheck handler
>  > > - possibly other wasteful things..
>  > > 
>  > > This seems to do the right thing here..
> 
> Isn't this always the case on x86 ?
> /me waits to hear gory details of some IBM monster.

If it is the logical cpu id yes, then id 0 is always the bootstrap
cpu.

For apic id #0 to not be the bootstrap cpu you don't need an IBM
monster, there are several SMP machines with that property.

Eric

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292483AbSBPSt2>; Sat, 16 Feb 2002 13:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292485AbSBPStJ>; Sat, 16 Feb 2002 13:49:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17229 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S292483AbSBPStE>; Sat, 16 Feb 2002 13:49:04 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tyson@rwii.com (Tyson D Sawyer), linux-kernel@vger.kernel.org
Subject: Re: Missed jiffies
In-Reply-To: <E16c7yN-0006a2-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Feb 2002 11:44:30 -0700
In-Reply-To: <E16c7yN-0006a2-00@the-village.bc.nu>
Message-ID: <m14rkh5ks1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > My system looses about 8 seconds every 20 minutes.  This is reported
> > by ntp and verified by comparing 'date' to 'hwclock --show' and a wall
> > clock.
> > 
> > My system is a x86 Dell laptop with HZ=1024.
> > 
> > I am quite certain that the issue is the System Management Interrupt
> > (SMI).
> 
> Possibly and if it is you can't really do much about it.

Except usually the truly annoyed can reprogram the chipset so an SMI
interrupt is not generated.  But I doubt that is practical on a
laptop. 

> ACPI may help here but lots of vendors implement their ACPI subsystem using
> I/O cycles to jump into SMM mode so its game over again.

Hmm.  I wonder if this is a simple transition technique or if it is
their long term strategy.  

Now I'm going to research and see if SMM mode is supported on with
x86-64 and ia64.  With ACPI the case can at least be made that SMM
mode is not strictly necessary and should be dropped.  I'm dreaming
but if the processors didn't have this super protected mode, BIOS
vendors and operating system vendors would be force to cooperate on
these issues.

Eric

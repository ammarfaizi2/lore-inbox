Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282145AbRKWNy2>; Fri, 23 Nov 2001 08:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282146AbRKWNyS>; Fri, 23 Nov 2001 08:54:18 -0500
Received: from elin.scali.no ([62.70.89.10]:5388 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S282145AbRKWNyF>;
	Fri, 23 Nov 2001 08:54:05 -0500
Subject: Re: [Q] was the SYSENTER/SYSCALL fast system calls completed or
		discared in the end??
From: Terje Eggestad <terje.eggestad@scali.no>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <p73snb6x1wo.fsf@amdsim2.suse.de>
In-Reply-To: <1006184327.19902.2.camel@pc-16.office.scali.no.suse.lists.linux.kernel>
	<20011121225402.A175@elf.ucw.cz.suse.lists.linux.kernel>
	<1006440069.22598.4.camel@pc-16.office.scali.no.suse.lists.linux.kernel> 
	<p73snb6x1wo.fsf@amdsim2.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 23 Nov 2001 14:54:02 +0100
Message-Id: <1006523642.25167.7.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool, 

do you happen top know where the patch is? On e that I can apply to
stock 2.4.1x??

TJ

tor, 2001-11-22 kl. 16:26 skrev Andi Kleen:
> Terje Eggestad <terje.eggestad@scali.no> writes:
> 
> > ons, 2001-11-21 kl. 22:54 skrev Pavel Machek:
> > > 
> > > On Mon 19-11-01 16:38:45, Terje Eggestad wrote:
> > > > subject says it all....
> > > > 
> > > > I remember there was a discussion and a patch floating around that 
> > > > implemented SYSCALL/SYSRET, just want to know what happened to it....
> > > 
> > > discarded
> > 
> > Because there was no perf benefit  or because the patch was in poor
> > quality?
> 
> The x86-64 port uses SYSCALL/SYSRET as the native call method for 64bit
> programs.
> 
> Before x86-64 it turned out that SYSCALL is not really usable because
> of some builtin limitations (which are fixed in x86-64). This is only
> a problem for the K6, K7 should have support for SYSENTER/SYSEXIT (the 
> Intel equivalent), which seems to be better designed. There is a patch
> to use SYSENTER/SYSEXIT.
> 
> 
> -Andi
-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________


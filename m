Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279884AbRKVP0l>; Thu, 22 Nov 2001 10:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279860AbRKVP0b>; Thu, 22 Nov 2001 10:26:31 -0500
Received: from ns.suse.de ([213.95.15.193]:7692 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279842AbRKVP0S>;
	Thu, 22 Nov 2001 10:26:18 -0500
To: Terje Eggestad <terje.eggestad@scali.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] was the SYSENTER/SYSCALL fast system calls completed or 	discared in the end??
In-Reply-To: <1006184327.19902.2.camel@pc-16.office.scali.no.suse.lists.linux.kernel> <20011121225402.A175@elf.ucw.cz.suse.lists.linux.kernel> <1006440069.22598.4.camel@pc-16.office.scali.no.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Nov 2001 16:26:15 +0100
In-Reply-To: Terje Eggestad's message of "22 Nov 2001 15:46:31 +0100"
Message-ID: <p73snb6x1wo.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Eggestad <terje.eggestad@scali.no> writes:

> ons, 2001-11-21 kl. 22:54 skrev Pavel Machek:
> > 
> > On Mon 19-11-01 16:38:45, Terje Eggestad wrote:
> > > subject says it all....
> > > 
> > > I remember there was a discussion and a patch floating around that 
> > > implemented SYSCALL/SYSRET, just want to know what happened to it....
> > 
> > discarded
> 
> Because there was no perf benefit  or because the patch was in poor
> quality?

The x86-64 port uses SYSCALL/SYSRET as the native call method for 64bit
programs.

Before x86-64 it turned out that SYSCALL is not really usable because
of some builtin limitations (which are fixed in x86-64). This is only
a problem for the K6, K7 should have support for SYSENTER/SYSEXIT (the 
Intel equivalent), which seems to be better designed. There is a patch
to use SYSENTER/SYSEXIT.


-Andi

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285709AbSBCESy>; Sat, 2 Feb 2002 23:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285666AbSBCESp>; Sat, 2 Feb 2002 23:18:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26681 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S286179AbSBCESc>; Sat, 2 Feb 2002 23:18:32 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davem@redhat.com (David S. Miller), vandrove@vc.cvut.cz,
        torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
In-Reply-To: <E16WQYs-0003Ux-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Feb 2002 21:14:33 -0700
In-Reply-To: <E16WQYs-0003Ux-00@the-village.bc.nu>
Message-ID: <m17kpv8amu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > As a side note, this thing is so tiny (less than 4K on sparc64!) so
> > why don't we just include it unconditionally instead of having all
> > of this "turn it on for these drivers" stuff?
> 
> Because 100 4K drivers suddenly becomes 0.5Mb. There are those of us trying
> to stuff Linux into embedded devices who if anything want more configuration
> options not people taking stuff out.
> 
> What I'd much rather see if this is an issue is:
> 
> bool	'Do you want to customise for a very small system' 
> 
> which auto enables all the random small stuff if you say no, and goes
> much deeper into options if you say yes.

I mostly agree.  Except when I have looked at trying to get the kernel
(compiled size down) the biggest bloat was in the core.  Things like
having both a page and a block cache.

Getting code reuse in the core higher would cut down on kernel size a
lot.  But that isn't quick fix territory.

Eric

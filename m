Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286336AbSBCHDo>; Sun, 3 Feb 2002 02:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbSBCHDe>; Sun, 3 Feb 2002 02:03:34 -0500
Received: from a1as10-p200.stg.tli.de ([195.252.189.200]:31126 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S286336AbSBCHDX>; Sun, 3 Feb 2002 02:03:23 -0500
Date: Sun, 3 Feb 2002 08:01:35 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        vandrove@vc.cvut.cz, torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
Message-ID: <20020203080134.C19813@dea.linux-mips.net>
In-Reply-To: <E16WQYs-0003Ux-00@the-village.bc.nu> <m17kpv8amu.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m17kpv8amu.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Feb 02, 2002 at 09:14:33PM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 09:14:33PM -0700, Eric W. Biederman wrote:

> > > As a side note, this thing is so tiny (less than 4K on sparc64!) so
> > > why don't we just include it unconditionally instead of having all
> > > of this "turn it on for these drivers" stuff?
> > 
> > Because 100 4K drivers suddenly becomes 0.5Mb. There are those of us trying
> > to stuff Linux into embedded devices who if anything want more configuration
> > options not people taking stuff out.
> > 
> > What I'd much rather see if this is an issue is:
> > 
> > bool	'Do you want to customise for a very small system' 
> > 
> > which auto enables all the random small stuff if you say no, and goes
> > much deeper into options if you say yes.
> 
> I mostly agree.  Except when I have looked at trying to get the kernel
> (compiled size down) the biggest bloat was in the core.  Things like
> having both a page and a block cache.
> 
> Getting code reuse in the core higher would cut down on kernel size a
> lot.  But that isn't quick fix territory.

Is it really worth the effort?  During the past year the average size of
embedded systems that people want to use for seems to have increased
dramatically.  In case of the MIPS port the core activity is about to
move away from the 32-bit to 64-bit kernel.

  Ralf

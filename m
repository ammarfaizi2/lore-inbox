Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRBBPUu>; Fri, 2 Feb 2001 10:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129862AbRBBPUj>; Fri, 2 Feb 2001 10:20:39 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:35512 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129759AbRBBPU3>; Fri, 2 Feb 2001 10:20:29 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200102021520.f12FK0O20218@devserv.devel.redhat.com>
Subject: Re: ReiserFS Oops (2.4.1, deterministic, symlink
To: mason@suse.com (Chris Mason)
Date: Fri, 2 Feb 2001 10:20:00 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), reiser@namesys.com (Hans Reiser),
        kas@informatics.muni.cz (Jan Kasprzak), linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
In-Reply-To: <595250000.981126989@tiny> from "Chris Mason" at Feb 02, 2001 10:16:29 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What makes you think its gcc 2.96 ?
> 
> We have had many reports of exactly this symlink problem, and each time it
> was a redhat user with a gcc 2.96, and switching to kgcc fixed it.  We have
> one report (now two with Alan's) that 2.96-69 does not show this crash.

Ok.  That would make sense.

> Hans, decisions about proper compilers should not be made in each
> individual part of the kernel.  If unpatched gcc 2.96 is getting reiserfs
> wrong, it is compiling other parts of the kernel wrong as well.  l-k has
> discussed this at length already ;-)

Unpatched 2.96 miscompiles some of the asm in the audio drivers for one.
2.96-69 as far as I can tell breaks just DAC960 and thats an apparently 
accidental ABI change in 2.96 and the CVS gcc about how packed enums are
handled.

2.95 and egcs 1.1.2 miscompile strstr() instead 8)

So yes.. nobody should be compiling kernels with 2.96 without the errata
rpm. With it nobody should see any problems and if they do find ones that
go away with kgcc I'd like to know about them (bug me Im sure Linus doesnt care
about them ;))

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

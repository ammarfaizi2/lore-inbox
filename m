Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKDUk6>; Sat, 4 Nov 2000 15:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbQKDUkr>; Sat, 4 Nov 2000 15:40:47 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:28425 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129057AbQKDUke>; Sat, 4 Nov 2000 15:40:34 -0500
Date: Sat, 4 Nov 2000 14:37:03 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: asm/resource.h
Message-ID: <20001104143703.A14407@vger.timpanogas.org>
In-Reply-To: <3A032C1D.D50C8D46@transmeta.com> <3A032E4E.A08DC0EB@timpanogas.org> <20001103203336.L1041@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001103203336.L1041@wire.cadcamlab.org>; from peter@cadcamlab.org on Fri, Nov 03, 2000 at 08:33:36PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 08:33:36PM -0600, Peter Samuelson wrote:
> 
> [Jeff Merkey]
> > Is this what is causing the lockup problems on 2.4.0-pre-10 with
> > PPro, or something else.  Looks like something else.
> 
> Yeah, it does, doesn't it.  If this particular patch cured a
> kernel-side lockup I would be very surprised.  Because the only effect
> this patch is *supposed* to have is the visibility of certain kernel
> header code when compiling userspace programs.
> 
> HPA, for what it's worth, which isn't much, I think your patch is
> spot-on..

I got a little further with the lock up problem, and it is related to 
MPS reporting a 2nd processor being present in some PPro systems 
when in fact only one CPU is really installed (but MPS is reporting default
table entry 6 with a second CPU as present).  What seems to be different
here is that on this system, NT and NetWare both timeout on attempts 
to activate the non-existent CPU, while 2.4 hard hangs after sending 
a STARTUP_IPI command.  hpa does some work on the APIC code I've noticed,
so I thought I'd ask him about it.  

Jeff

> 
> Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

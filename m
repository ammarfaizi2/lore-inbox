Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268852AbRHPV0u>; Thu, 16 Aug 2001 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268848AbRHPV0l>; Thu, 16 Aug 2001 17:26:41 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:64526 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268856AbRHPV0Z>; Thu, 16 Aug 2001 17:26:25 -0400
Date: Tue, 14 Aug 2001 14:00:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: David Ford <david@blue-labs.org>
Cc: linux-kernel@vger.kernel.org
Subject: "VM watchdog"? [was Re: VM nuisance]
Message-ID: <20010814140011.B38@toy.ucw.cz>
In-Reply-To: <3B748AA8.4010105@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B748AA8.4010105@blue-labs.org>; from david@blue-labs.org on Fri, Aug 10, 2001 at 09:30:16PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Is there anything measurably useful in any -ac or -pre patches after 
> 2.4.7 that helps or fixes the blasted out-of-memory-but-let's-go-fsck 
> -ourselves-for-a-few-hours?
> 
> I was very close to hitting the reset button and losing a lot of 
> important information because of this.  I accidently got too close to 
> the edge of memory (~6megs free) and the kernel went into FMM (fsck 
> myself mode)...i.e. spin mightily looking for memory and going noplace 
> whilst ignoring it's little buddy the OOM handler.
> 
> Again, it doesn't matter if I have swap or not, if I get within ~6 megs 
> of the end of memory, the kernel goes FMM.  I've tested with and without 
> swap.  And _please_  don't tell me "just add more swap".  That's 
> ludicruous and isn't solving the problem, it's covering up a symptom.

Maybe creating userland program that
*) allocates few megs
*) while 1 sleep 1m, gettimeofday. If more tha two minutes elapsed,
	tell OOM handler to kick in.

Or maybe kernel could have some "VM watchdog", which would trigger OOM if
it is not polled once a minute...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263499AbTC3CWE>; Sat, 29 Mar 2003 21:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263500AbTC3CWE>; Sat, 29 Mar 2003 21:22:04 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:2491 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S263499AbTC3CWD>;
	Sat, 29 Mar 2003 21:22:03 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Robert Love <rml@tech9.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
Date: Sun, 30 Mar 2003 12:33:03 +1000
User-Agent: KMail/1.5
Cc: Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
References: <3E8610EA.8080309@telia.com> <1048987260.679.7.camel@teapot> <1048989922.13757.20.camel@localhost>
In-Reply-To: <1048989922.13757.20.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303301233.03803.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Mar 2003 12:05, Robert Love wrote:
> On Sat, 2003-03-29 at 20:21, Felipe Alfaro Solana wrote:
> > Theoretically, with interactivity enhancaments, you'll never need to
> > renice X. In fact, I'm running X with no renice and it feels pretty
> > snappy.
>
> I know.
>
> I was wondering, since we are working on an actual bug here, whether or
> not renicing X is leading to a starvation issue between X and whatever
> is starving.  I have seen it before.
>
> My system is responsive, too, and I do not renice X.  But it might
> help.  Or it might cause starvation issues.  We have a bug somewhere...

Are you sure this should be called a bug? Basically X is an interactive 
process. If it now is "interactive for a priority -10 process" then it should 
be hogging the cpu time no? The priority -10 was a workaround for lack of 
interactivity estimation on the old scheduler.

Con

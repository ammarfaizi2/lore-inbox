Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbSBOF4L>; Fri, 15 Feb 2002 00:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287048AbSBOF4C>; Fri, 15 Feb 2002 00:56:02 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:53776 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S286934AbSBOFz6>;
	Fri, 15 Feb 2002 00:55:58 -0500
Date: Thu, 14 Feb 2002 22:55:54 -0700
From: Val Henson <val@nmt.edu>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp_send_reschedule vs. smp_migrate_task
Message-ID: <20020214225554.K1557@boardwalk>
In-Reply-To: <15466.6058.686853.295549@argo.ozlabs.ibm.com> <20020214150331.P30586@boardwalk> <15468.14888.334751.716019@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15468.14888.334751.716019@argo.ozlabs.ibm.com>; from paulus@samba.org on Fri, Feb 15, 2002 at 09:28:56AM +1100
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 09:28:56AM +1100, Paul Mackerras wrote:
> Val Henson writes:
> 
> > I had only one IPI for the RPIC (an interrupt controller only used on
> > Synergy PPC boards) and I implemented a little message queue to
> > simulate all 4 IPI's.  The mailbox implementation suggested by James
> > Bottomley ended up having race conditions on our board.  It's probably
> > not the most elegant solution, but it works and required no change to
> > the PowerPC SMP code.  See my "Make Gemini boot" patch to linuxppc-dev
> > and take a look at the files rpic.c and rpic.h.
> 
> In that post I was really asking the following questions:
> 
> * how often does smp_send_reschedule get called?
> * how often does smp_migrate_task get called?
> * if smp_send_reschedule and smp_migrate_task were mutually exclusive,
>   i.e. both used the same spinlock, could that lead to deadlock?
> 
> James Bottomley answered the first two for me but not the third.

Understood.

I'm still a little disgusted by a system that works for 4
smp_<whatever> functions but not 5. :)

-VAL

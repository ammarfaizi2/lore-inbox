Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291944AbSBNWDu>; Thu, 14 Feb 2002 17:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291942AbSBNWDl>; Thu, 14 Feb 2002 17:03:41 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:62478 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S291944AbSBNWDg>;
	Thu, 14 Feb 2002 17:03:36 -0500
Date: Thu, 14 Feb 2002 15:03:31 -0700
From: Val Henson <val@nmt.edu>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp_send_reschedule vs. smp_migrate_task
Message-ID: <20020214150331.P30586@boardwalk>
In-Reply-To: <15466.6058.686853.295549@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15466.6058.686853.295549@argo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Feb 13, 2002 at 06:37:14PM +1100
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 06:37:14PM +1100, Paul Mackerras wrote:
> I am looking at the updates for PPC that are needed because of the
> changes to the scheduler in 2.5.x.  I need to implement
> smp_migrate_task(), but I do not have another IPI easily available;
> the Open PIC interrupt controller used in a lot of SMP PPC machines
> supports 4 IPIs in hardware and we are already using all of them.

I had only one IPI for the RPIC (an interrupt controller only used on
Synergy PPC boards) and I implemented a little message queue to
simulate all 4 IPI's.  The mailbox implementation suggested by James
Bottomley ended up having race conditions on our board.  It's probably
not the most elegant solution, but it works and required no change to
the PowerPC SMP code.  See my "Make Gemini boot" patch to linuxppc-dev
and take a look at the files rpic.c and rpic.h.

-VAL

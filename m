Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270021AbRHYRiX>; Sat, 25 Aug 2001 13:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269891AbRHYRiN>; Sat, 25 Aug 2001 13:38:13 -0400
Received: from [209.250.58.175] ([209.250.58.175]:8196 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S269909AbRHYRh4>; Sat, 25 Aug 2001 13:37:56 -0400
Date: Sat, 25 Aug 2001 12:37:36 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Odd __alloc_pages failure in 2.4.9
Message-ID: <20010825123736.A709@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010825113344.A528@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010825113344.A528@hapablap.dyn.dhs.org>; from srwalter@yahoo.com on Sat, Aug 25, 2001 at 11:33:44AM -0500
X-Uptime: 12:36pm  up 5 min,  0 users,  load average: 1.08, 0.87, 0.40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm... I just recompiled with gcc 2.95.3, and now it works.  The kernel
had been compiled with gcc 3.0; guess its a compiler bug.

I'll look into this more and see if I can't file a formal gcc bugreport.

On Sat, Aug 25, 2001 at 11:33:44AM -0500, Steven Walter wrote:
> Running kernel 2.4.9, if I start xcdroast 0.98alpha9 as an ordinary
> user, the system seems to freeze indefinitely.
> 
> If I start it as root, however, the system only freeze for 2-3 seconds.
> After this time, if I check dmesg, I get a slew of __alloc_pages
> failures, even 0-order failures.
> 
> Being unable to diagnose the complete lockup in the user case any
> better, I assume that this is what's happening there, too, only
> indefinitely.
> 
> The system is an AMD Thunderbird 900MHz with 2 IDE CD-ROM drives, both
> use ide-scsi.  One is a burner, the other is a DVD-ROM drive.
> 
> I'll try and get a backtrace of whats happening during the lockup later
> when I can hook up my serial console.
> -- 
> -Steven
> In a time of universal deceit, telling the truth is a revolutionary act.
> 			-- George Orwell
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

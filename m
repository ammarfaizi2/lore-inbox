Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVGYT7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVGYT7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVGYT5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:57:49 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:57419 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261484AbVGYT5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:57:45 -0400
Message-ID: <42E54436.5070203@keysounds.co.uk>
Date: Mon, 25 Jul 2005 20:57:42 +0100
From: Steve Wooding <steve_wooding@keysounds.co.uk>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041227)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karsten Wiese <annabellesgarden@yahoo.de>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: =?iso-8859-1?Q?[COMPILE_ERROR]_realtime-preempt-2=2E6=2E12-final-V0=2E7=2E51-33_on_x86_64_SMP_system
References: <200507221113.02246.annabellesgarden@yahoo.de>
In-Reply-To: <200507221113.02246.annabellesgarden@yahoo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Karsten,

That fixed it. Though now my bleeding edge InfiniBand driver is 
complaining about SPIN_LOCK_UNLOCKED being undeclared. Could this be 
caused by the preemt patch, as the IB driver compiles against an 
unpatched kernel. I'll look into further.

Cheers,

Steve.

Karsten Wiese wrote:

>Steve,
>
>to make it compile and build replace
> arch/x86_64/kernel/smpboot.c: line 191
>with this:
><snip>
>static __cpuinitdata raw_spinlock_t tsc_sync_lock = RAW_SPIN_LOCK_UNLOCKED;
></snip>
>
>or alternativly:
><snip>
>static DEFINE_RAW_SPINLOCK(tsc_sync_lock);
></snip>
>
>    Karsten
>
>	
>
>	
>		
>___________________________________________________________ 
>Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280929AbRKKFAY>; Sun, 11 Nov 2001 00:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280931AbRKKFAP>; Sun, 11 Nov 2001 00:00:15 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:49035 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S280929AbRKKFAB>;
	Sun, 11 Nov 2001 00:00:01 -0500
Date: Sun, 11 Nov 2001 00:00:00 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Petro <petro@auctionwatch.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Machine Crash--Can someone decipher this for me?
In-Reply-To: <20011109170857.I22434@auctionwatch.com>
Message-ID: <Pine.LNX.4.30.0111102359350.22386-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You should probably resolve those symbols present in your cpu registers so
that people here can help you!  :)

-Calin

On Fri, 9 Nov 2001, Petro wrote:

>
>     About 10 minutes ago we had one of our DB machines crashed, and I
>     really need to find out why.
>
>     Symptoms were that we lost connectivity on the Gig-E port, things
>     were *really* slow accessing the 100bT port (different network), so
>     I grabbed the Serial console to try and troubleshoot. This very soon
>     stoped responding, so I had to power-cycle the box.
>
>     We'd been playing with the box all day testing a new configuration
>     (we are migrating a DB from an e4500 to this machine).
>
>     Here is the log file:
>
>     Nov  9 16:33:21 dbgsh01 kernel: Unable to handle kernel paging request at virtual address 8fab6104
>     Nov  9 16:33:21 dbgsh01 kernel:  printing eip:
>     Nov  9 16:33:21 dbgsh01 kernel: c01087da
>     Nov  9 16:33:21 dbgsh01 kernel: *pde = 00000000
>     Nov  9 16:33:21 dbgsh01 kernel: Oops: 0002
>     Nov  9 16:33:21 dbgsh01 kernel: CPU:    1
>     Nov  9 16:33:21 dbgsh01 kernel: EIP:    0010:[do_IRQ+42/236]    Not tainted
>     Nov  9 16:33:21 dbgsh01 kernel: EFLAGS: 00010093
>     Nov  9 16:33:21 dbgsh01 kernel: eax: cf792580   ebx: 000002a0   ecx: 0000011a   edx: 0858ba10
>     Nov  9 16:33:21 dbgsh01 kernel: esi: c0303aa0   edi: 00000015   ebp: d9a63d1c   esp: d9a63d08
>     Nov  9 16:33:21 dbgsh01 kernel: ds: 0018   es: 0018   ss: 0018
>     Nov  9 16:33:21 dbgsh01 kernel: Process xml_search_pull (pid: 2901, stackpage=d9a62000)
>     Nov  9 16:33:21 dbgsh01 kernel: Stack: 40156368 08597564 0858bff4 d7f2229d 081a28b0 bffff45c c010a8f4 40156368
>     Nov  9 16:33:21 dbgsh01 kernel:        0000011a 0858ba10 08597564 0858bff4 bffff45c 00000a4c c010002b 0000002b
>     Nov  9 16:33:21 dbgsh01 kernel:        ffffff15 400b51d7 00000023 00010206 bffff454 0000002b ffffffff 0000000a
>     Nov  9 16:33:21 dbgsh01 kernel: Call Trace: [call_do_IRQ+5/13] [vsnprintf+991/1056] [reschedule_idle+533/540] [wake_up_parent+29/48] [do_notify_p arent+178/188]
>     Nov  9 16:33:21 dbgsh01 kernel:    [__mmdrop+35/40] [do_exit+557/564] [sys_exit+14/16] [system_call+47/52]
>     Nov  9 16:33:21 dbgsh01 kernel:
>     Nov  9 16:33:21 dbgsh01 kernel: Code: ff 84 b8 30 3b 32 c0 f0 fe 8b 10 38 30 c0 0f 88 a3 60 14 00
>     Nov  9 16:35:58 dbgsh01 kernel:  <5>nfs: server cart2-1 not responding, still trying
>     Nov  9 16:36:12 dbgsh01 kernel: nfs: server cart1-1 not responding, still trying
>
>     Hardware: VALinux 2200 dual CPUs, 2 gig ram.
>     Netgear GA620
>     IBM 9gig HD on /dev/sda (using Adaptec aic7896/97 Ultra2 SCSI adapter)
>     3ware 64xx card with 2 75 Gig IDE drives.
>
>     Kernel: 2.4.13-ac8. Using Acenic driver .83 for GA620. EEpro1.09 for
>     onboad 100bT.
>
>     I suspect that something caused the Acenic driver to, go bad.
>
>     Is this a case of "upgrade to the lastest version (IIRC .84) and
>     hope it doesn't happen again", or am I barking down the wrong
>     branch?
>
>


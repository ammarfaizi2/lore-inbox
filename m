Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKAFDa>; Wed, 1 Nov 2000 00:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129118AbQKAFDU>; Wed, 1 Nov 2000 00:03:20 -0500
Received: from mx2.core.com ([208.40.40.41]:57029 "EHLO smtp-2.core.com")
	by vger.kernel.org with ESMTP id <S129168AbQKAFDK>;
	Wed, 1 Nov 2000 00:03:10 -0500
Message-ID: <39FFB221.D6A1B5FF@megsinet.net>
Date: Wed, 01 Nov 2000 00:03:13 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: Re: Linux-2.4.0-test10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI,

My list of 2.4.0-testX problems

Further details, .config, etc...available if needed

Martin

2.4.0-test10 and earlier problem list:
 
Problem |       UP              UP-APIC         SMP
--------|------------------------------------------------
1       |       OK              OK              HARDLOCK
2       |       OK              FAILS           OK
3       |       HARDLOCK        HARDLOCK        HARDLOCK
4       |       BROKEN          BROKEN          BROKEN

Problem description:
 
1.  kernel compiled w/o FB support.  When attempting to switch
    back to X from VC1-6 system locks hard for SMP.  Nada thing
    fixes this except hard reset... no Alt-SysRq-B, nothing
    DRI not enabled.  Video card has r128 chipset.
 
2.  System is a NFS root machine, after a period of heavy ntwk
    activity, eg. "make clean" in /usr/src/linux ETH0 no longer
    works or sometimes just ntwk activity during system boot is
    enough to cause the ETH activity to cease.
    The only recourse is to Alt-SysRq-B the system.
    NIC = NE2K ISA
 
3. Enabling PIIX4, kernel locks hard when printing the partition
   tables for hdc.   hdc has no partitions.
   I think this problem is on Ted's problem list???
 
4. ISAPNP assigns an invalid/unusable IRQ to NE2K NIC card.
   Previously reported to Linux & Ingo, they asked for an MPTABLE
   dump, haven't heard back since providing said data.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

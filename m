Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318716AbSHWInu>; Fri, 23 Aug 2002 04:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318718AbSHWInu>; Fri, 23 Aug 2002 04:43:50 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:55712 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id <S318716AbSHWInt>; Fri, 23 Aug 2002 04:43:49 -0400
Mime-Version: 1.0
Message-Id: <a05111609b98ba20903b0@[129.98.90.227]>
In-Reply-To: <1030090864.5932.5.camel@irongate.swansea.linux.org.uk>
References: <a05111608b98b96373cce@[129.98.90.227]>
 <1030090864.5932.5.camel@irongate.swansea.linux.org.uk>
Date: Fri, 23 Aug 2002 04:47:57 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: SMP Netfinity 340 hangs under 2.4.19
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > A single processor Netfinity 340 running RedHat 7.1 and kernel 2.4.18
>>  was recently upgraded to
>>
>>  1) 1 GB RAM
>>  2) second processor (1 Ghz Xeon)
>>  3) 2.4.19 for SMP with bigmem and added NFS server patches and
>>  ext3-related patches.
>
>Exactly what patches ? and does unpatched 2.4.19 behave ?

These from Neil Brown:
patch-A-UmemWarn	Fix the compile warning ....
patch-B-0-9-18	Latest Ext3 patches
patch-C-Ext3Fixes	Fix some problems with ext3
patch-D-NfsdLookupTidy	Tidy up code in nfsd_lookup
patch-E-NfsdInit	Tidyup init/exit fof nfsd module
patch-F-NfsdFsid	Support fsid= export option to be device 
number independent
patch-G-NfsdLocksExplock	Change export table lock to (SMP 
safe) rwsemaphore
patch-H-NfsdLocksCachelock	Lock reply cache with SMP safety.
patch-I-NfsdLocksNfssvc	Tidy up locking in nfssvc - preparing for BKL removal
patch-J-NfsdLocksRename	protect rename and related operations by kernel_lock
patch-K-NfsdFhLock	protect file handle lookup by kernel lock
patch-L-NfsdLocksRacache	protect read-ahead cache with SMP safe locking
patch-M-NfsdBKLgone	Remove last unneeded bit of BKL from knfsd
patch-N-RpcLists	Change sunrpc to use more list.h lists
patch-O-RpcInit	Get sunrpc to use module_init properly
patch-P-RpcSvcLocking	Tidy up SMP locking for svc_sock
patch-Q-RpcTcpCloseBad	Detect and close tcp connections that we 
cannot work with.
patch-R-RpcTcpCloseIdle	Close idle rpc/tcp sockets
patch-S-RpcTcpReserve	Make sure there is alway adequate sndbuf 
space for replies.
patch-T-RpcSvcTcpLimit	Limit number of active tcp connections to an 
RPC service
patch-U-NfsdTcpEnable	Enable NFS over TCP via config option
patch-c-NfsfhErrFix	Correct some error codes reutrned in nfsfh.c

I haven't tried plain 2.4.19 yet. Should I have reason to not trust 
these patches?

>  > Is there significance to the fact that keyboard and mouse are frozen
>>  but apparently some processes are still up?
>
>Interrupts are running but its stuck looping in kernel space I suspect.

So could this be taken to mean the issue is most likely software 
(presumably kernel)-related?
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University

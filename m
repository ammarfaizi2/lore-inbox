Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281546AbRKUAse>; Tue, 20 Nov 2001 19:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281547AbRKUAsY>; Tue, 20 Nov 2001 19:48:24 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:9132 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S281546AbRKUAsI>; Tue, 20 Nov 2001 19:48:08 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: [REISERFS TESTING] new patches on ftp.namesys.com: 2.4.15-pre7
Date: Wed, 21 Nov 2001 01:47:51 +0100
X-Mailer: KMail [version 1.3.2]
Cc: ReiserFS List <reiserfs-list@Namesys.COM>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011121004818Z281546-17408+16782@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 21. November 2001 01:07 schrieb Dieter Nützel:
> Sorry Nikita,
>
> but kernel 2.4.15-pre7 + preempt + ReiserFS A-N do _NOT_ boot for me.
> I've tried it with "old" and "new" (current) N-inode-attrs.patch. But that
> doesn't matter.
>
> [-]
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> reiserfs: checking transaction log (device 08:03) ...
> Using r5 hash to sort names
> ReiserFS version 3.6.25
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 208k freed
> "Warning: unable to open an initial console."
>
> SysRq: Show Regs
>
> Pid: 1, comm: init
> EIP: 0023 : [<0804c842>] CPU: 0 ESP: 002b:bffffe10 EFLAGS: 00010246 Not
> tainted EAX: ffffffff EBX: bfffff00 ECX: 0000000d EDX: ffffffff
> ESI: bffffef4 EDI: 00000002 EBP: bffffe78 DS: 002b ES: 002b
> CR0: 8005003b CR2: 080609c0 CR3: 27adc000 CR4: 000002d0
> Call Trace:
>
> SysRq: Show State
>
> init, keventd, ksoftirqd_CPU, kswapd, bdflush, kupdated, scsi_eh_0,
> kreiserfsd

OK, I've found it.

N-inode-attrs.patch (both versions) is broken. After I've backed it out 
2.4.15-pre7 + preempt + ReiserFS A-M is up and running.

-Dieter

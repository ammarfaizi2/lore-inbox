Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSGEKCY>; Fri, 5 Jul 2002 06:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316679AbSGEKCX>; Fri, 5 Jul 2002 06:02:23 -0400
Received: from [195.223.140.120] ([195.223.140.120]:27964 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316605AbSGEKCW>; Fri, 5 Jul 2002 06:02:22 -0400
Date: Fri, 5 Jul 2002 12:05:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: r.ems@gmx.net
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Hubert Mantel <mantel@suse.de>
Subject: Re: kernel OOPS: 2.4.18, nscd, nfsd
Message-ID: <20020705100522.GA7094@dualathlon.random>
References: <3D104DF4.A8053F67@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D104DF4.A8053F67@gmx.net>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 11:25:08AM +0200, Richard Ems wrote:
> Jun 18 22:35:59 bingo kernel: Unable to handle kernel paging request at virtual address 92766008
> Jun 18 22:35:59 bingo kernel:  printing eip:
> Jun 18 22:35:59 bingo kernel: c0217944
> Jun 18 22:35:59 bingo kernel: *pde = 00000000
> Jun 18 22:35:59 bingo kernel: Oops: 0000
> Jun 18 22:35:59 bingo kernel: CPU:    0
> Jun 18 22:35:59 bingo kernel: EIP:    0010:[sock_poll+4/32]    Not tainted
> Jun 18 22:35:59 bingo kernel: EFLAGS: 00210282
> Jun 18 22:35:59 bingo kernel: eax: c0217940   ebx: 00000145   ecx: 00000000   edx: 92766000
> Jun 18 22:35:59 bingo kernel: esi: dcd88000   edi: c2bf76e0   ebp: 00000000   esp: c3419f28
> Jun 18 22:35:59 bingo kernel: ds: 0018   es: 0018   ss: 0018
> Jun 18 22:35:59 bingo kernel: Process nscd (pid: 863, stackpage=c3419000)
> Jun 18 22:35:59 bingo kernel: Stack: c0149610 92766000 00000000 00000000 000005dd 00000000 00000000 c01496fc
> Jun 18 22:35:59 bingo kernel:        00000001 dcd88000 c3419f60 c3419f64 c3418000 c3418000 00000000 00000000
> Jun 18 22:35:59 bingo kernel:        00000001 bf7ffa04 00000000 00000001 c0149860 00000001 00000000 00000001
> Jun 18 22:35:59 bingo kernel: Call Trace: [do_pollfd+128/144] [do_poll+220/240] [sys_poll+336/704] [sys_time+17/80] [system_call+51/64]
> Jun 18 22:35:59 bingo kernel:
> Jun 18 22:35:59 bingo kernel: Code: 8b 42 08 8b 40 08 05 14 01 00 00 8b 48 08 ff 74 24 08 50 52
> Jun 18 22:35:59 bingo kernel: klogd 1.4.1, ---------- state change ----------
> Jun 18 22:35:59 bingo kernel: Inspecting /boot/System.map-2.4.18-4GB
> Jun 18 22:35:59 bingo kernel: Loaded 13574 symbols from /boot/System.map-2.4.18-4GB.
> Jun 18 22:35:59 bingo kernel: Symbols match kernel version 2.4.18.
> Jun 18 22:35:59 bingo kernel: Loaded 168 symbols from 13 modules.
> Jun 18 22:40:00 bingo /USR/SBIN/CRON[24006]: (root) CMD ( /usr/lib/sa/sa1      )
> Jun 18 22:50:00 bingo /USR/SBIN/CRON[24053]: (root) CMD ( /usr/lib/sa/sa1      )
> Jun 18 22:50:00 bingo kernel:  <1>Unable to handle kernel paging request at virtual address 42627044
> Jun 18 22:50:00 bingo kernel:  printing eip:
> Jun 18 22:50:00 bingo kernel: 42627044
> Jun 18 22:50:00 bingo kernel: *pde = 00000000
> Jun 18 22:50:00 bingo kernel: Oops: 0000
> Jun 18 22:50:00 bingo kernel: CPU:    0
> Jun 18 22:50:00 bingo kernel: EIP:    0010:[zisofs_cleanup+1113747380/-1072693392]    Not tainted

Not that we can trust a second oops and I guess also the first oops
isn't near the bug, but are you using the zisofs actively or the above
is just a random EIP?

Also note if you exported the iso via nfs in the past without a reboot
and fsck -f in between, you could have mem/fs corruption that trigger
days after you stopped exporting iso via nfsd.

If you can reproduce that would be helpful.

thanks,

Andrea

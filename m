Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbQKUQnS>; Tue, 21 Nov 2000 11:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbQKUQnI>; Tue, 21 Nov 2000 11:43:08 -0500
Received: from [64.64.109.142] ([64.64.109.142]:37387 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S130180AbQKUQmi>; Tue, 21 Nov 2000 11:42:38 -0500
Message-ID: <3A1A9EC6.BF0A3C83@didntduck.org>
Date: Tue, 21 Nov 2000 11:11:50 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: William Stearns <wstearns@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: CC=kgcc incomplete in 2.4.0-test11-ac1
In-Reply-To: <Pine.LNX.4.30.0011211058200.1207-100000@sparrow.websense.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Stearns wrote:
> 
> Good day, Alan,
>         A kernel build with your latest prepatch still seems to use gcc
> to compile some of the auxiliary tools:
> 
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/mkdep scripts/mkdep.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer gentbl.c -o gentbl -lm
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/split-include scripts/split-include.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o conmakehash conmakehash.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o gen-devlist gen-devlist.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o tools/build tools/build.c -I/usr/src/linux-2.4.0/include
> 
>         Do any of the above tools need to use kgcc as well, or is gcc
> likely to work just fine?
>         Cheers,
>         - Bill

The userspace tools should be fine with the newer gcc.  It is set up
this way so that the userspace tools use the native compiler when
cross-compiling.  If you're really paranoid, set HOSTCC=kgcc as well.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

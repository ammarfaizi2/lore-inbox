Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131546AbQLLBZi>; Mon, 11 Dec 2000 20:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131613AbQLLBZ2>; Mon, 11 Dec 2000 20:25:28 -0500
Received: from chicago.cheek.com ([207.202.196.154]:29706 "EHLO
	chicago.cheek.com") by vger.kernel.org with ESMTP
	id <S131546AbQLLBZP>; Mon, 11 Dec 2000 20:25:15 -0500
Message-ID: <3A357756.6ED72940@cheek.com>
Date: Mon, 11 Dec 2000 16:54:46 -0800
From: Joseph Cheek <joseph@cheek.com>
Organization: LinuxCare, Inc.
X-Mailer: Mozilla 4.72C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.2.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [FIXED!] kernel BUG at buffer.c:827 in test12-pre6 and 7
In-Reply-To: <3A30125D.5F71110D@cheek.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this works fine in pre8.  thanks all!

Joseph Cheek wrote:

> copying files off a loopback-mounted vfat filesystem exposes this bug.
> test11 worked fine.
>
> loop.o built as module.  this hard crashes the machine, every time
> [PIII-450].  i don't know how to debug this, is there a FAQ?
>
> [transcribed by hand]:
>
> # mount -o loop /tmp/cdboot.288 /mnt/cd
> # cd /mnt/cd
> # cp menu.lst /tmp
> kernel BUG at buffer.c:827!
> invalid operand: 0000
> CPU: 0
> EIP: 0010:[<c013660c>]
> EFLAGS: 00010082
> eax: 0000001c ebx: c1d8fc60 ecx: 00000000 edx: 00000001
> esi: c10658e4 edi: 00000002 ebp: c1d8fca8 esp: c1793dc0
> ds: 0018 es: 0018 ss: 0018
> Process cp (pid 762, stackpage=c1793000)
> Stack: c01fe484 c01fe95a 0000033b c1d8fc60 c1cef420 00000001 00000001
> c01610e1
>        c1d8fc60 00000001 c1cef420 00000000 c1cef420 c02c8ed8 c88df91c
> c1cef420
>        00000001 c88e0986 00000007 00000000 00000001 c02c8ed8 c02c8ee8
> c4f18800
> Call Trace: [<c01fe484>] [<c01fe95a>] [<c0130703>] [<c8895de3>]
> [<c88df91c>] [<c8894494>] [<c0160d2f>] [<c0160ead>]
>        [<c0161011>] [<c0137a49>] [<c0130703>] [<c8895de3>] [<c8894494>]
> [<c01284d3>] [<c012887b>] [c0128720>]
>        [<c889448d>] [<c01349a7>] [c010b56b>]
> Code: 0f 0b 83 c4 0c 8d 5e 28 8d 46 2c 39 46 2c 74 24 b9 01 00 00
>
> as soon as i reboot i will look what's at buffer.c:827

thanks!

joe

--
Joseph Cheek, Sr Linux Consultant, Linuxcare | http://www.linuxcare.com/
Linuxcare.  Support for the Revolution.      | joseph@linuxcare.com
CTO / Acting PM, Redmond Linux Project       | joseph@redmondlinux.org
425 990-1072 vox [1074 fax] 206 679-6838 pcs | joseph@cheek.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

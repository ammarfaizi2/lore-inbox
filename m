Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130300AbQK0NKf>; Mon, 27 Nov 2000 08:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130415AbQK0NKZ>; Mon, 27 Nov 2000 08:10:25 -0500
Received: from linuxpc1.lauterbach.com ([194.195.165.177]:23152 "HELO
        linuxpc1.lauterbach.com") by vger.kernel.org with SMTP
        id <S130300AbQK0NKU>; Mon, 27 Nov 2000 08:10:20 -0500
Message-Id: <4.3.2.7.2.20001127133105.00e44b00@mail.munich.netsurf.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 27 Nov 2000 13:40:12 +0100
To: David Riley <oscar@the-rileys.net>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: asm-ppc/elf.h error
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3A1ED883.9AD8136A@the-rileys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:07 24.11.00, David Riley wrote:
>In asm-ppc/elf.h, <asm/types.h> is not included.  This breaks
>compilations of anything that compiles it (e.g. binutils) because the
>vector registers for Altivec aren't defined elsewhere.  Included is a
>quick diff.  I didn't know which PPC maintainer to send this to, so I
>posted it to the linuxppc-dev list.

(Looking at the correct patch)

Why do you need that? Your claim that binutils needs that is simply wrong, 
I compiled CVS binutils without problems against bk 2.4.0-t11. In any case, 
glibc-2.1.3 and glibc-2.2 have this stuff in sys/procfs.h, so you should 
use that instead I guess. That's at least what gdb uses.

Franz.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

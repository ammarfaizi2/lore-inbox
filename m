Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbQKRTEX>; Sat, 18 Nov 2000 14:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130775AbQKRTED>; Sat, 18 Nov 2000 14:04:03 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:19985 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S130673AbQKRTDz>; Sat, 18 Nov 2000 14:03:55 -0500
Message-ID: <3A16CB81.30AD0439@Hell.WH8.TU-Dresden.De>
Date: Sat, 18 Nov 2000 19:33:37 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Markus Schoder <markus_schoder@yahoo.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <20001118182230.14470.qmail@web3407.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Schoder wrote:

> My test program caused the exception (and the freeze)
> unintendedly in the return statement since the
> division was optimized away as Brian pointed out.

It's quite strange that I cannot seem to trigger the
problem here on my machine.

> I know of another guy with the exact same CPU (Athlon
> Thunderbird 900MHz) and mainboard (ABIT KT7-RAID) who
> has the same problem.
>
> I use gcc 2.95.2 to compile the kernel.

Makes me wonder whether it could be an issue with your
board (I have an Asus A7V) or with gcc 2.95-2 (I use
egcs-1.1.2).

> Note that cpuinfo shows model 4 whereas e.g. Brian had
> model 2 if that means anything.

Mine is a model 4 also, so if it's related to that, I
should probably see the problem here as well.

/proc/cpuinfo

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 807.000213
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1608.91

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

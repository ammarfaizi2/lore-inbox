Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316840AbSFVGSB>; Sat, 22 Jun 2002 02:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316842AbSFVGSA>; Sat, 22 Jun 2002 02:18:00 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:35078 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316840AbSFVGR7>; Sat, 22 Jun 2002 02:17:59 -0400
Date: Sat, 22 Jun 2002 08:17:42 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.24 doesn't compile on Alpha
Message-ID: <20020622061742.GA6119@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20020621064835.GA13502@alpha.of.nowhere> <000301c2191e$5a4a3080$010b10ac@sbp.uptime.at> <20020621141957.GA22555@alpha.of.nowhere> <20020621192405.A749@jurassic.park.msu.ru> <20020621203726.GA2308@alpha.of.nowhere> <20020621205741.GN24903@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020621205741.GN24903@lug-owl.de>
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Date: Fri, Jun 21, 2002 at 10:57:41PM +0200
> On Fri, 2002-06-21 22:37:26 +0200, Jurriaan on Alpha <thunder7@xs4all.nl>
> wrote in message <20020621203726.GA2308@alpha.of.nowhere>:
>>
>> This patchs helps a lot; now I get:
>> drivers/built-in.o(.data+0x37118): undefined reference to `local symbols in discarded section .text.exit'
> 
> I think this "bug" appears with some binutils some weeks/months old. Try
> to upgrade them.
> 
Hmm, I had an up-to-date debian testing system.
So I upgraded to the latest binutils from unstable, that didn't work.
Then I downloaded binutils-2.12.1 from source and installed that - still
doesn't work.
The latest from unstable was 2.12.90.0.9.

make[1]: Leaving directory `/usr/src/linux-2.5.24/init'
  ld -static -T arch/alpha/vmlinux.lds -N  arch/alpha/kernel/head.o init/init.o --start-group arch/alpha/kernel/kernel.o arch/alpha/m
m/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/alpha/math-emu/built-in.o /usr/src/linux-2.5.24/arch/alpha/lib/lib.a lib/lib.a
/usr/src/linux-2.5.24/arch/alpha/lib/lib.a drivers/built-in.o sound/sound.o net/network.o --end-group -o vmlinux
drivers/built-in.o(.data+0x37118): undefined reference to `local symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1
alpha:/usr/src/linux-2.5.24# ld -v
GNU ld version 2.12.90.0.9 20020526 Debian GNU/Linux
alpha:/usr/src/linux-2.5.24# ld -static -T arch/alpha/vmlinux.lds -N  arch/alpha/kernel/head.o init/init.o --start-group arch/alpha/k
ernel/kernel.o arch/alpha/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/alpha/math-emu/built-in.o /usr/src/linux-2.5.24/arch
/alpha/lib/lib.a lib/lib.a /usr/src/linux-2.5.24/arch/alpha/lib/lib.a drivers/built-in.o sound/sound.o net/network.o --end-group -o v
mlinux
drivers/built-in.o(.data+0x37118): undefined reference to `local symbols in discarded section .text.exit'
alpha:/usr/src/linux-2.5.24# ld -v
GNU ld version 2.12.1
alpha:/usr/src/linux-2.5.24#

> I'm not hitting this bug, but for me, ./arch/alpha/kernel/head.o isn't
> build (actually, there aren't any .o files in that directory), even if
> I try to explicitely compile head.o by 'make arch/alpha/kernel/head.o'.
> Any hints there?
> 
None, but could you please tell me what version of binutils you're
using?

Thanks,
Jurriaan
-- 
"A cat's got her own opinion of human beings. She don't say much, but you
 can tell enough to make you anxious not to hear the whole of it."
	Jerome K. Jerome (1859 - 1927) 
Debian GNU/Linux 2.4.19p10 on Alpha 990 bogomips 5 users load:2.45 2.33 1.71

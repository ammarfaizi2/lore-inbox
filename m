Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289761AbSAOXnb>; Tue, 15 Jan 2002 18:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289764AbSAOXnR>; Tue, 15 Jan 2002 18:43:17 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:60551
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S289761AbSAOXnI>; Tue, 15 Jan 2002 18:43:08 -0500
Date: Tue, 15 Jan 2002 18:52:45 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to compile 2.4.14 on alpha
Message-ID: <20020115185245.A20198@animx.eu.org>
In-Reply-To: <20020114212550.A17323@animx.eu.org> <20020115113213.A1539@werewolf.able.es> <20020115115530.A19073@animx.eu.org> <20020116002642.A1838@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20020116002642.A1838@werewolf.able.es>; from J.A. Magallon on Wed, Jan 16, 2002 at 12:26:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, 2.4.17:
gcc -D__KERNEL__ -I/usr/src/2.4.17/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev4 -Wa,-mev6 -DMODULE   -DEXPORT_SYMTAB -c DAC960.c
DAC960.c: In function `DAC960_V2_EnableMemoryMailboxInterface':
DAC960.c:1054: internal error--unrecognizable insn:
(insn 949 477 474 (set (reg:DI 2 $2)
        (plus:DI (reg:DI 30 $30)
            (const_int 4398046511104 [0x40000000000]))) -1 (nil)
    (nil))
cpp0: output pipe has been closed
make[2]: *** [DAC960.o] Error 1
make[2]: Leaving directory `/usr/src/2.4.17/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/usr/src/2.4.17/drivers'
make: *** [_mod_drivers] Error 2

any ideas?  gcc-3.0 compiles it but I don't know if that's a good idea or not.
the kernel compiled with 2.95.4

> Recent binutils warn about symbols marked as discardable but referenced
> when the driver is built-in instead of modularized. Older ones just shut up.
> 
> Original explanation:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=100753194504523&w=2
> 
> Corrected mainly in 2.4.17-pre6 (and some leftovers in following pres).
> >From ChangeLog-2.4.17:
> 
> pre6:
> ...
> - Create __devexit_p() function and use that on 
>   drivers which need it to make it possible to
>   use newer binutils                (Keith Owens)
> ...
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131090AbRABO3h>; Tue, 2 Jan 2001 09:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131093AbRABO31>; Tue, 2 Jan 2001 09:29:27 -0500
Received: from [203.36.158.121] ([203.36.158.121]:22912 "HELO kabuki.eyep.net")
	by vger.kernel.org with SMTP id <S131090AbRABO3R>;
	Tue, 2 Jan 2001 09:29:17 -0500
To: Elmer Joandi <elmer@ylenurme.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: Compile errors: RCPCI, LANE, and others 
In-Reply-To: Your message of "Tue, 02 Jan 2001 14:33:29 BST."
             <Pine.LNX.4.30.0101021427070.4279-100000@yle-server.ylenurme.sise> 
In-Reply-To: <Pine.LNX.4.30.0101021427070.4279-100000@yle-server.ylenurme.sise> 
Date: Wed, 03 Jan 2001 01:02:21 +1100
From: Daniel Stone <daniel@kabuki.eyep.net>
Message-Id: <20010102142920Z131090-439+7909@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Did full compile, just for fun:
> 
> CONFIG_for Red Creek  whatever RCPCI has a syntax error
> other warnings and errors, compiled on 2.4.0-prerelease, nonSMP, PIII
> 
> md5sum: WARNING: 11 of 12 computed checksums did NOT match

This indicates a corrupted download.

> net/network.o: In function `atm_ioctl':
> net/network.o(.text+0x3c742): undefined reference to `atm_lane_init'
> net/network.o(.text+0x3c7f2): undefined reference to `atm_mpoa_init'
> make: *** [vmlinux] Error 1

Known problem, AFAIK.

> objcopy: Warning: Output file cannot represent architecture UNKNOWN!

um. this is completely rooted. what compiler are you using, what
distribution? (hint: if it's redhat 7, don't bother).

> ip2/i2cmd.c:142: warning: `ct89' defined but not used
> sx.c:1623: warning: `do_memtest_w' defined but not used
> i2o_block.c:595: warning: #warning "RACE"

this is most likely a bad thing, yes.

> md5sum: WARNING: 11 of 12 computed checksums did NOT match

see first warning

> bttv-cards.c: In function `bttv_check_chipset':
> bttv-cards.c:1389: warning: unused variable `i'
> bttv-cards.c: At top level:
> bttv-cards.c:1379: warning: `needs_etbf' defined but not used
> mtdchar.c: In function `init_mtdchar':
> mtdchar.c:452: warning: unused variable `mtd'
> mtdchar.c:451: warning: unused variable `name'
> mtdchar.c:450: warning: unused variable `i'
> ftl.c:139: warning: `debug' defined but not used
> nftlmount.c: In function `check_and_mark_free_block':
> nftlmount.c:363: warning: unused variable `buf'
> nftlmount.c:362: warning: unused variable `i'

harmless.

> sunhme.c:2791: warning: #warning This needs to be corrected... -DaveM
> sdla_chdlc.c: In function `if_send':
> sdla_chdlc.c:936: warning: unsigned int format, long unsigned int arg (arg 3)
> sdla_chdlc.c: In function `wpc_isr':
> sdla_chdlc.c:1501: warning: unsigned int format, long unsigned int arg (arg 3)
> sdla_ppp.c: In function `if_send':
> sdla_ppp.c:901: warning: unsigned int format, long unsigned int arg (arg 3)


believe these fall under the set_bit domain.

<more shit snipped>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

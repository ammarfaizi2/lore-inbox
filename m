Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbTIYKPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 06:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTIYKPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 06:15:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59857 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261781AbTIYKPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 06:15:47 -0400
Date: Thu, 25 Sep 2003 12:15:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: mac@melware.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: 2.6 eicon/ and hardware/eicon/ drivers using the same symbols
Message-ID: <20030925101541.GH15696@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the link error below in 2.6.0-test5-mm4 (but it doesn't seem to be 
specific to -mm).

It seems some drivers under eicon/ and hardware/eicon/ use the same 
symbols. Either some symbols should be renamed or Kconfig dependencies 
should ensure that you can't build two such drivers statically into the 
kernel at the same time.

cu
Adrian

<--  snip  -->

  LD      drivers/isdn/built-in.o
drivers/isdn/sc/built-in.o(.bss+0x0): multiple definition of `adapter'
drivers/isdn/hardware/built-in.o(.data+0x1134): first defined here
ld: Warning: size of symbol `adapter' changed from 4 in 
drivers/isdn/hardware/built-in.o to 16 in drivers/isdn/sc/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x97ac): In function `mem_inw':
: multiple definition of `mem_inw'
drivers/isdn/hardware/built-in.o(.text+0x10240): first defined here
ld: Warning: size of symbol `mem_inw' changed from 26 in 
drivers/isdn/hardware/built-in.o to 66 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x9944): In function 
`mem_out_buffer':
: multiple definition of `mem_out_buffer'
drivers/isdn/hardware/built-in.o(.text+0x10378): first defined here
ld: Warning: size of symbol `mem_out_buffer' changed from 48 in 
drivers/isdn/hardware/built-in.o to 74 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x9690): In function 
`DIVA_DIDD_Read':
: multiple definition of `DIVA_DIDD_Read'
drivers/isdn/hardware/built-in.o(.text+0xd454): first defined here
ld: Warning: size of symbol `DIVA_DIDD_Read' changed from 17 in 
drivers/isdn/hardware/built-in.o to 93 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x9a78): In function `io_in_buffer':
: multiple definition of `io_in_buffer'
drivers/isdn/hardware/built-in.o(.text+0x1041c): first defined here
ld: Warning: size of symbol `io_in_buffer' changed from 105 in 
drivers/isdn/hardware/built-in.o to 73 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x9a34): In function `io_inw':
: multiple definition of `io_inw'
drivers/isdn/hardware/built-in.o(.text+0x103f0): first defined here
ld: Warning: size of symbol `io_inw' changed from 44 in 
drivers/isdn/hardware/built-in.o to 65 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x9768): In function `mem_in':
: multiple definition of `mem_in'
drivers/isdn/hardware/built-in.o(.text+0x10224): first defined here
ld: Warning: size of symbol `mem_in' changed from 25 in 
drivers/isdn/hardware/built-in.o to 66 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x9c0c): In function `io_inc':
: multiple definition of `io_inc'
drivers/isdn/hardware/built-in.o(.text+0x105b8): first defined here
ld: Warning: size of symbol `io_inc' changed from 87 in 
drivers/isdn/hardware/built-in.o to 83 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x9b7c): In function `io_outw':
: multiple definition of `io_outw'
drivers/isdn/hardware/built-in.o(.text+0x1051c): first defined here
ld: Warning: size of symbol `io_outw' changed from 47 in 
drivers/isdn/hardware/built-in.o to 68 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x9990): In function `mem_inc':
: multiple definition of `mem_inc'
drivers/isdn/hardware/built-in.o(.text+0x103a8): first defined here
ld: Warning: size of symbol `mem_inc' changed from 25 in 
drivers/isdn/hardware/built-in.o to 80 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x9bc0): In function 
`io_out_buffer':
: multiple definition of `io_out_buffer'
drivers/isdn/hardware/built-in.o(.text+0x1054c): first defined here
ld: Warning: size of symbol `io_out_buffer' changed from 105 in 
drivers/isdn/hardware/built-in.o to 73 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x983c): In function 
`mem_look_ahead':
: multiple definition of `mem_look_ahead'
drivers/isdn/hardware/built-in.o(.text+0x102c4): first defined here
ld: Warning: size of symbol `mem_look_ahead' changed from 74 in 
drivers/isdn/hardware/built-in.o to 118 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x99e0): In function `io_in':
: multiple definition of `io_in'
drivers/isdn/hardware/built-in.o(.text+0x103c4): first defined here
ld: Warning: size of symbol `io_in' changed from 44 in 
drivers/isdn/hardware/built-in.o to 81 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x98fc): In function `mem_outw':
: multiple definition of `mem_outw'
dridn/hardware/built-in.o(.text+0x10328): first defined here
ld: Warning: size of symbol `mem_outw' changed from 25 in 
drivers/isdn/hardware/built-in.o to 69 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x98b4): In function `mem_out':
: multiple definition of `mem_out'
drivers/isdn/hardware/built-in.o(.text+0x10310): first defined here
ld: Warning: size of symbol `mem_out' changed from 24 in 
drivers/isdn/hardware/built-in.o to 69 in drivers/isdn/eicon/built-in.o
drivers/isdn/eicon/built-in.o(.text+0x9b38): In function `io_out':
: multiple definition of `io_out'
drivers/isdn/hardware/built-in.o(.text+0x104ec): first defined here
ld: Warning: size of symbol `io_out' changed from 47 in 
drivers/isdn/hardware/built-in.o to 68 in drivers/isdn/eicon/built-in.o
...
make[2]: *** [drivers/isdn/built-in.o] Error 1

<--  snip  -->

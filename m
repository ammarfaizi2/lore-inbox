Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTLJXDt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTLJXDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:03:49 -0500
Received: from gizmo06ps.bigpond.com ([144.140.71.16]:7049 "HELO
	gizmo06ps.bigpond.com") by vger.kernel.org with SMTP
	id S264259AbTLJXDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:03:47 -0500
Message-ID: <3FD7A64F.4A6ABCF7@eyal.emu.id.au>
Date: Thu, 11 Dec 2003 10:03:43 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.23 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.24-pre1: failure in scsi/pcmcia
References: <Pine.LNX.4.44.0312101417080.1546-100000@logos.cnet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes 2.4.24-pre1...

I was getting this in 2.4.23-aa, but now I have it here.

ld -m elf_i386 -r -o qlogic_cs.o qlogic_stub.o qlogicfas.o
qlogicfas.o: In function `init_module':
qlogicfas.o(.text+0xe40): multiple definition of `init_module'
qlogic_stub.o(.text+0x770): first defined here
ld: Warning: size of symbol `init_module' changed from 77 to 58 in
qlogicfas.o
qlogicfas.o: In function `cleanup_module':
qlogicfas.o(.text+0xe80): multiple definition of `cleanup_module'
qlogic_stub.o(.text+0x7c0): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 40 to 16 in
qlogicfas.
o
make[3]: *** [qlogic_cs.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/scsi/pcmc
ia'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>

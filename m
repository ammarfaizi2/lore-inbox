Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281495AbRKHJ4e>; Thu, 8 Nov 2001 04:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281496AbRKHJ4Y>; Thu, 8 Nov 2001 04:56:24 -0500
Received: from relay.datanet.hu ([194.149.0.156]:12355 "HELO relay.datanet.hu")
	by vger.kernel.org with SMTP id <S281495AbRKHJ4M>;
	Thu, 8 Nov 2001 04:56:12 -0500
From: "Bakonyi Ferenc" <fero@sztalker.hu>
Organization: =?ISO-8859-1?Q?=3D=3FISO-8859-2=3FQ=3FDatakart=5FGeod=82zia=5FKFT.=3F=3D?=
To: linux-kernel@vger.kernel.org
Date: Thu, 8 Nov 2001 10:55:33 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: isa_* problems (hgafb is broken since 2.4.13)
Message-ID: <3BEA64AF.18141.2926868D@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi!

Calls for isa_memset_io() and isa_writeb() in hga_clear_screen() and 
hga_show_logo() make garbage and bad things since 2.4.13. (Unable to 
handle kernel paging request at virtual address...)
Anybody experiencing problems may want to revert changes made in 
2.4.13. It solves the problem.

I have two questions about asm-i386/io.h:
1. Why #define __ISA_IO_base ((char *)(PAGE_OFFSET)) ?
2. Why not #define __ISA_IO_base ((char *)0) ? 

Regards:
	Ferenc Bakonyi

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276759AbRKHRUe>; Thu, 8 Nov 2001 12:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276761AbRKHRUY>; Thu, 8 Nov 2001 12:20:24 -0500
Received: from www.transvirtual.com ([206.14.214.140]:35600 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S276759AbRKHRUS>; Thu, 8 Nov 2001 12:20:18 -0500
Date: Thu, 8 Nov 2001 09:19:30 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Bakonyi Ferenc <fero@sztalker.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: isa_* problems (hgafb is broken since 2.4.13)
In-Reply-To: <3BEA64AF.18141.2926868D@localhost>
Message-ID: <Pine.LNX.4.10.10111080917360.13456-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have two questions about asm-i386/io.h:
> 1. Why #define __ISA_IO_base ((char *)(PAGE_OFFSET)) ?
> 2. Why not #define __ISA_IO_base ((char *)0) ? 

For ix86 the ISA IO space start is at the very begining of memory. On
other platforms like the PPC the ISA IO space is seperate from the
regular memory space. It starts after the regular memory space thus the
__ISA_IO_base will not be 0x0. 


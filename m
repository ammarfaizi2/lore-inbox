Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUBJWH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 17:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUBJWH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 17:07:57 -0500
Received: from shiva.warpcore.org ([216.81.249.60]:41705 "EHLO
	shiva.warpcore.org") by vger.kernel.org with ESMTP id S261735AbUBJWH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 17:07:56 -0500
Subject: Re: Kernel GPL Violations and How to Research
From: Gidon <gidon@warpcore.org>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040210215213.GA8092@one-eyed-alien.net>
References: <1076388828.9259.32.camel@CPE-65-26-89-23.kc.rr.com>
	 <20040210192007.GA6987@one-eyed-alien.net>
	 <1076449796.6373.3.camel@CPE-65-26-89-23.kc.rr.com>
	 <20040210215213.GA8092@one-eyed-alien.net>
Content-Type: text/plain
Message-Id: <1076450874.6373.13.camel@CPE-65-26-89-23.kc.rr.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 10 Feb 2004 16:07:54 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-10 at 15:52, Matthew Dharm wrote:
> Obfuscation can obscure the names of functions, but generally not string
> constants or the structure of functions calling other functions.

Sadly, objdump turns up nothing really interesting. The kernel image is
in i386-linux a.out format. This is all it gives me for headers:

SOME.FILE:     file format a.out-i386-linux
SOME.FILE
architecture: i386, flags 0x000001be:
EXEC_P, HAS_LINENO, HAS_DEBUG, HAS_SYMS, HAS_LOCALS, WP_TEXT, D_PAGED
start address 0x00100020
                                                                                                                                                         
Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00079fc0  00000020  00000020  00000020  2**2
                  CONTENTS, ALLOC, LOAD, CODE
  1 .data         0002a000  0007a000  0007a000  00079fe0  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  2 .bss          00018004  000a4000  000a4000  00000000  2**2
                  ALLOC


It is easier to read some of the function names and other things using
objdump's -s option, but beyond that it's not much more useful than
strings. It appears that I will have to get medieval on it.

-- 
I am subscribed to this mailing list. It is not necessary to CC me.
Thank you. -Gidon


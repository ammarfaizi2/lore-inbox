Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265170AbSJWTnv>; Wed, 23 Oct 2002 15:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265175AbSJWTnv>; Wed, 23 Oct 2002 15:43:51 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:7492 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265176AbSJWTno>; Wed, 23 Oct 2002 15:43:44 -0400
Date: Wed, 23 Oct 2002 12:58:10 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Stephen Hemminger <shemminger@osdl.org>
cc: Kernel List <linux-kernel@vger.kernel.org>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [PATCH] LKCD for 2.5.44 (8/8): dump driver and build files
In-Reply-To: <1035398127.9615.21.camel@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210231238430.28800-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected, fixed version is on the LKCD patch download site.

Thanks, Stephen.

--Matt

On 23 Oct 2002, Stephen Hemminger wrote:
|>The variable dump_page_buf is declared with different scope in
|>dump_base.c and dump_block_dev.c. This causes a link error, but maybe if
|>LKCD is built as a module, then the symbol export masks the problem.
|>
|>diff -Nru a/drivers/dump/dump_base.c b/drivers/dump/dump_base.c
|>--- a/drivers/dump/dump_base.c	Wed Oct 23 11:34:14 2002
|>+++ b/drivers/dump/dump_base.c	Wed Oct 23 11:34:14 2002
|>@@ -200,7 +200,7 @@
|> static long dump_nondisruptive_enabled = 1;/* Default:non-disruptive enabled*/
|> 
|> /* Other global fields */
|>-static void *dump_page_buf;        /* dump page buffer for memcpy()!       */
|>+void *dump_page_buf;        	   /* dump page buffer for memcpy()!       */
|> static void *dump_page_buf_0;      /* dump page buffer returned by kmalloc */
|> struct __dump_header dump_header;  /* the primary dump header              */
|> struct __dump_header_asm dump_header_asm; /* the arch-specific dump header */



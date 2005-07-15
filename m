Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVGOWOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVGOWOv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 18:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVGOWMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 18:12:32 -0400
Received: from smtp04.auna.com ([62.81.186.14]:20958 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S261835AbVGOWLJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 18:11:09 -0400
Date: Fri, 15 Jul 2005 22:11:08 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: [PATCH] fix LDT tss
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1121465068l.13352l.0l@werewolf.able.es> (from
	jamagallon@able.es on Sat Jul 16 00:04:28 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1121465468l.13352l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.215.11] Login:jamagallon@able.es Fecha:Sat, 16 Jul 2005 00:11:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.16, J.A. Magallon wrote:
> 
> On 07.15, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> > 

--- linux.orig/include/asm-i386/processor.h
+++ linux/include/asm-i386/processor.h
@@ -476,7 +476,6 @@ struct thread_struct {
 	.esp0		= sizeof(init_stack) + (long)&init_stack,	\
 	.ss0		= __KERNEL_DS,					\
 	.ss1		= __KERNEL_CS,					\
-	.ldt		= GDT_ENTRY_LDT,				\
 	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,			\
 	.io_bitmap	= { [ 0 ... IO_BITMAP_LONGS] = ~0 },		\
 }

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam9 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))



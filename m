Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbVIASVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbVIASVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVIASVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:21:52 -0400
Received: from smtp06.auna.com ([62.81.186.16]:6609 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1030283AbVIASVv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:21:51 -0400
Date: Thu, 01 Sep 2005 18:21:50 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.13-mm1
To: Linux-Kernel Lista <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
X-Mailer: Balsa 2.3.4
Message-Id: <1125598910l.24887l.2l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.208.222] Login:jamagallon@able.es Fecha:Thu, 1 Sep 2005 20:21:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Back from holydays and trying to get up-to-date with new kernel releases.
With 2.6.13-mm1, I get this:


werewolf:/usr/src/linux# make
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  LD      drivers/scsi/aic7xxx/built-in.o
drivers/scsi/aic7xxx/aic79xx.o: In function `aic_parse_brace_option':
: multiple definition of `aic_parse_brace_option'
drivers/scsi/aic7xxx/aic7xxx.o:: first defined here
make[3]: *** [drivers/scsi/aic7xxx/built-in.o] Error 1
make[2]: *** [drivers/scsi/aic7xxx] Error 2
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

I have both aic7xxx and aic79xx built-in in my config. The problem is
including aiclib.c from both source files...
Fast and dirty workaround is plaguing it with 'static inline's, but it has
to be a better way...

by

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam12 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269012AbUJKOnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269012AbUJKOnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269024AbUJKOki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:40:38 -0400
Received: from mail.dif.dk ([193.138.115.101]:13539 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S269012AbUJKOgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:36:05 -0400
Date: Mon, 11 Oct 2004 16:43:43 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc4
In-Reply-To: <1097504290l.6177l.1l@werewolf.able.es>
Message-ID: <Pine.LNX.4.61.0410111632360.26100@dragon.hygekrogen.localhost>
References: <1097504290l.6177l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Oct 2004, J.A. Magallon wrote:

> Hi...
> 
> Lets polish it... I get this warnings on build:
> 
>  CC      fs/binfmt_elf.o
> fs/binfmt_elf.c: In function `padzero':
> fs/binfmt_elf.c:113: warning: ignoring return value of `clear_user', declared
> with attribute warn_unused_result
> include/asm/uaccess.h: In function `create_elf_tables':
> fs/binfmt_elf.c:175: warning: ignoring return value of `__copy_to_user',
> declared with attribute warn_unused_result
> fs/binfmt_elf.c:273: warning: ignoring return value of `copy_to_user',
> declared with attribute warn_unused_result
> fs/binfmt_elf.c: In function `load_elf_binary':
> fs/binfmt_elf.c:758: warning: ignoring return value of `clear_user', declared
> with attribute warn_unused_result
> fs/binfmt_elf.c: In function `fill_psinfo':
> fs/binfmt_elf.c:1226: warning: ignoring return value of `copy_from_user',
> declared with attribute warn_unused_result
> 
I've submitted a patch for review for the above (which seems to have 
fallen into a black hole). Search the archives for 
"[PATCH][Please review] fix various missing return value checks in binfmt_elf"
I see there's another proposed patch by "ramsez" - mail with topic "[FIX]: 
fs/binfmt_elf.c compilation warns"

I've also submitted a fix for the last one of those binfmt_elf warnings as 
a sepperate patch - search for 
"[PATCH] small binfmt_elf warning fix (copy_from_user return value checking)"


>  CC [M]  drivers/ieee1394/raw1394.o
> include/asm/uaccess.h: In function `raw1394_read':
> drivers/ieee1394/raw1394.c:446: warning: ignoring return value of
> `__copy_to_user', declared with attribute warn_unused_result
> 

This one I recently posted a patch for. Search for the thread with subject 
"[PATCH] check copy_to_user return value in raw1394"


I'll try submitting them again post 2.6.9 final, I've been re-reading them 
and I guess they could be done better. But if the warnings bug you too 
much, then they are in the archives and it certainly wouldn't hurt that 
they got some testing :)


--
Jesper Juhl



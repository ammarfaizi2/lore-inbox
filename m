Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTDVUhn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTDVUhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:37:43 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:4307 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263850AbTDVUhm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:37:42 -0400
Message-Id: <200304222049.h3MKnj7S011734@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: 2.5.68-bk3 - #if cleanup arch/* (1/6)
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Date: Tue, 22 Apr 2003 22:47:45 +0200
References: <20030422194012$5ab2@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> --- linux-2.5.68-bk3/arch/s390/kernel/traps.c.dist    2003-04-22 13:56:53.000000000 -0400
> +++ linux-2.5.68-bk3/arch/s390/kernel/traps.c 2003-04-22 15:04:11.293300921 -0400
> @@ -304,7 +304,7 @@
>       }
>       else
>       {
> -#if CONFIG_REMOTE_DEBUG
> +#ifdef CONFIG_REMOTE_DEBUG
>               if(gdb_stub_initialised)
>               {
>                       gdb_stub_handle_exception(regs, signal);

This is actually dead code, the config option was already killed. 
I'll change it in our tree.

        Arnd <><

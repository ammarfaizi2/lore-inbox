Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWJJTfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWJJTfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWJJTfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:35:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15581 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030220AbWJJTe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:34:59 -0400
Date: Tue, 10 Oct 2006 12:34:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, Vadim Lobanov <vlobanov@speakeasy.net>,
       linuxppc-dev@ozlabs.org
Subject: Re: BUG() in copy_fdtable() with 64K pages (2.6.19-rc1-mm1)
Message-Id: <20061010123449.7be924f0.akpm@osdl.org>
In-Reply-To: <20061010121519.447d62f8@localhost.localdomain>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<20061010121519.447d62f8@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 12:15:19 -0500
Olof Johansson <olof@lixom.net> wrote:

> I keep hitting this on -rc1-mm1. The system comes up but I can't login
> since login hits it.
> 
> Bisect says that fdtable-implement-new-pagesize-based-fdtable-allocator.patch is at fault.
> 
> CONFIG_PPC_64K_PAGES=y is required for it to fail, with 4K pages it's fine.
> 
> (Hardware is a Quad G5, 1GB RAM, g5_defconfig + CONFIG_PPC_64K_PAGES, defaults 
> on all new options)
> 
> 
> 
> kernel BUG in copy_fdtable at fs/file.c:138!

OK, thanks.  I put the revert patch into
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/hot-fixes/

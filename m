Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbUCABKV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbUCABKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:10:21 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:65503 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262210AbUCABKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:10:16 -0500
Date: Mon, 1 Mar 2004 02:10:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       Torrey Hoffman <thoffman@arnor.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: 2.6.4-rc1-mm1: multiple definitions of `debug'
Message-ID: <20040301011012.GI13764@fs.tum.de>
References: <20040229140617.64645e80.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040229140617.64645e80.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 02:06:17PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.3-mm4:
>...
>  bk-usb.patch
> 
>  Latest versions of various external trees.
>...

I got the following error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.bss+0x85224): multiple definition of `debug'
arch/i386/kernel/built-in.o(.entry.text+0xfd4): first defined here
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The new drivers/usb/input/ati_remote.c driver thinks "debug" would be a
good name for a global variable...


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


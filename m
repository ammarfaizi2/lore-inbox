Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbUAFSN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUAFSN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:13:29 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8428 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264921AbUAFSN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:13:27 -0500
Date: Tue, 6 Jan 2004 19:13:18 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, linux@syskonnect.de
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.1-rc1-mm2: warning in drivers/net/sk98lin/skge.c
Message-ID: <20040106181318.GH11523@fs.tum.de>
References: <20040105002056.43f423b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105002056.43f423b1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 12:20:56AM -0800, Andrew Morton wrote:
>...
> All 253 patches
>...
> 2.6.0-rc1-netdrvr-exp1.patch
>...

I got the following compile warning:

<--  snip  -->

...
  CC      drivers/net/sk98lin/skge.o
drivers/net/sk98lin/skge.c: In function `skge_probe':
drivers/net/sk98lin/skge.c:713: warning: unused variable `proc_root_initialized'
...

<--  snip  -->


2.6.0-rc1-netdrvr-exp1.patch contains

--- 25/drivers/net/sk98lin/skge.c~2.6.0-rc1-netdrvr-exp1        2004-01-03 14:07:17.000000000 -0800
+++ 25-akpm/drivers/net/sk98lin/skge.c  2004-01-03 14:07:18.000000000 -0800
...
 #ifdef CONFIG_PROC_FS
+       int                     proc_root_initialized = 0;
        struct proc_dir_entry   *pProcFile;
 #endif
...


but no other occurence of proc_root_initialized where it would be used.


Is this some kind of merge error?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbUAIXh0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbUAIXh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:37:26 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42710 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264453AbUAIXhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:37:23 -0500
Date: Sat, 10 Jan 2004 00:37:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, thomas@winischhofer.net
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
Subject: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Message-ID: <20040109233714.GL1440@fs.tum.de>
References: <20040109014003.3d925e54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109014003.3d925e54.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 01:40:03AM -0800, Andrew Morton wrote:
>...
> All 393 patches
>...
> use-soft-float.patch
>   Use -msoft-float
>...

FYI:

This causes the following link error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x55814f): In function `sisfb_do_set_var':
: undefined reference to `__floatsidf'
drivers/built-in.o(.text+0x55816d): In function `sisfb_do_set_var':
: undefined reference to `__divdf3'
drivers/built-in.o(.text+0x55817a): In function `sisfb_do_set_var':
: undefined reference to `__floatsidf'
drivers/built-in.o(.text+0x558196): In function `sisfb_do_set_var':
: undefined reference to `__divdf3'
drivers/built-in.o(.text+0x5581a9): In function `sisfb_do_set_var':
: undefined reference to `__floatsidf'
drivers/built-in.o(.text+0x5581bf): In function `sisfb_do_set_var':
: undefined reference to `__divdf3'
drivers/built-in.o(.text+0x5581cb): In function `sisfb_do_set_var':
: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x5581e0): In function `sisfb_do_set_var':
: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x5581ea): In function `sisfb_do_set_var':
: undefined reference to `__fixunsdfsi'
drivers/built-in.o(.text+0x5584fa): In function `sisfb_do_set_var':
: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x558514): In function `sisfb_do_set_var':
: undefined reference to `__adddf3'
drivers/built-in.o(.text+0x55852e): In function `sisfb_do_set_var':
: undefined reference to `__adddf3'
drivers/built-in.o(.init.text+0x5cde2): In function `sisfb_init':
: undefined reference to `__floatsidf'
drivers/built-in.o(.init.text+0x5cdf5): In function `sisfb_init':
: undefined reference to `__divdf3'
drivers/built-in.o(.init.text+0x5cdff): In function `sisfb_init':
: undefined reference to `__fixunsdfsi'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


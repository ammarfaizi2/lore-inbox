Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUCPMlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 07:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUCPMlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 07:41:24 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:470 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261348AbUCPMkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 07:40:41 -0500
Date: Tue, 16 Mar 2004 13:40:35 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc1-mm1: IPMI_SMB still doesn't compile
Message-ID: <20040316124035.GN27056@fs.tum.de>
References: <20040316015338.39e2c48e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316015338.39e2c48e.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 01:53:38AM -0800, Andrew Morton wrote:
>...
> All 253 patches:
>...
> ipmi-updates-3.patch
>   IPMI driver updates
>...

IPMI_SMB still causes the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x135a0b): In function `smbus_client_read_block_data':
: undefined reference to `i2c_set_spin_delay'
drivers/built-in.o(.text+0x135bad): In function `smbus_client_write_block_data':
: undefined reference to `i2c_set_spin_delay'
drivers/built-in.o(.text+0x13629f): In function `set_run_to_completion':
: undefined reference to `i2c_set_spin_delay'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Until this issue is sorted out, please either drop ipmi-updates-3.patch
or remove the SMBus IPMI driver from this patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


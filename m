Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbUCIBjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 20:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUCIBjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 20:39:24 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23527 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261450AbUCIBjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 20:39:22 -0500
Date: Tue, 9 Mar 2004 02:39:17 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
Message-ID: <20040309013917.GH14833@fs.tum.de>
References: <20040307223221.0f2db02e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040307223221.0f2db02e.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 10:32:21PM -0800, Andrew Morton wrote:
>... 
> +ipmi-updates-3.patch
> +ipmi-socket-interface.patch
> 
>  IPMI driver updates
>...

This causes the following compile error:

<--  snip  -->

...
  CC      drivers/char/ipmi/ipmi_smb.o
drivers/char/ipmi/ipmi_smb.c: In function `smbus_client_read_block_data':
drivers/char/ipmi/ipmi_smb.c:224: warning: implicit declaration of 
function `i2c_set_spin_delay'
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x1342eb): In function 
`smbus_client_read_block_data':
: undefined reference to `i2c_set_spin_delay'
drivers/built-in.o(.text+0x13448d): In function 
`smbus_client_write_block_data':
: undefined reference to `i2c_set_spin_delay'
drivers/built-in.o(.text+0x134b7f): In function `set_run_to_completion':
: undefined reference to `i2c_set_spin_delay'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


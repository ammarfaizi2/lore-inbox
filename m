Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWBTOhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWBTOhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWBTOhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:37:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61959 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030254AbWBTOhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:37:19 -0500
Date: Mon, 20 Feb 2006 15:37:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: 2.6.16-rc4-mm1: usbfs2 multiply defined symbols
Message-ID: <20060220143713.GA4661@stusta.de>
References: <20060220042615.5af1bddc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220042615.5af1bddc.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 04:26:15AM -0800, Andrew Morton wrote:
>...
> +gregkh-usb-usbfs2.patch
> 
>  USB tree updates
>...

This patch causes the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `securityfs_create_dir': multiple definition of `securityfs_create_dir'
security/built-in.o: first defined here
drivers/built-in.o: In function `securityfs_remove': multiple definition of `securityfs_remove'
security/built-in.o: first defined here
drivers/built-in.o: In function `securityfs_create_file': multiple definition of `securityfs_create_file'
security/built-in.o: first defined here
ld: Warning: size of symbol `securityfs_create_file' changed from 331 in security/built-in.o to 332 in drivers/built-in.o
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVBUGGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVBUGGo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 01:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVBUGGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 01:06:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:61419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261884AbVBUGGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 01:06:42 -0500
Date: Sun, 20 Feb 2005 22:06:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Panic in 2.6.11-rc4
Message-Id: <20050220220627.487a2fc7.akpm@osdl.org>
In-Reply-To: <4218E251.1010000@candelatech.com>
References: <4218E251.1010000@candelatech.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> wrote:
>
>  SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
>  SCSI device sda: drive cache: write back
>  SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
>  SCSI device sda: drive cache: write back
>    sda: sda1 sda2 sda3
>  Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>  Unable to handle kernel paging request at virtual address e09a68e8
>    printing eip:
>  c014976e
>  *pde = 0151f067
>  Oops: 0000 [#1]
>  PREEMPT SMP
>  Modules linked in: ext3 jbd ata_piix libata sd_mod scsi_mod
>  CPU:    1
>  EIP:    0060:[<c014976e>]    Not tainted VLI
>  EFLAGS: 00010006   (2.6.11-rc4)
>  EIP is at cache_alloc_refill+0x20e/0x240

I assume something has wrecked the slab caches.  Please enable
CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC.


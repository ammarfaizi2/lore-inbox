Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270988AbTHCCGg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 22:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270986AbTHCCGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 22:06:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:20650 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270980AbTHCCGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 22:06:32 -0400
Date: Sat, 2 Aug 2003 19:07:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Diffie <diffie@blazebox.homeip.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Badness in device_release at drivers/base/core.c:84
Message-Id: <20030802190737.3c41d4d8.akpm@osdl.org>
In-Reply-To: <20030803015510.GB4696@blazebox.homeip.net>
References: <20030801182207.GA3759@blazebox.homeip.net>
	<20030801144455.450d8e52.akpm@osdl.org>
	<20030803015510.GB4696@blazebox.homeip.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diffie <diffie@blazebox.homeip.net> wrote:
>
> After applaying the above patch and testing it still oopses the kernel.
> 
> I noticed same patch in today's mm3 which i compiled and use right now.
> 
> When using cat /proc/scsi/aic7xxx/0 i get segmentation fault and oops
> which i'll attach to this email.
>
> ...
>
>  EIP is at aic7xxx_proc_info+0xc28/0xc80

This is crashing in a different place.  Probably the same bug, showing up
later on.

I don't know if anyone is maintaining aic7xxx_old in 2.7.  It looks like it
was subject to some random untested change a couple of months back.



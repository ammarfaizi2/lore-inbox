Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUAIKvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 05:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUAIKvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 05:51:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:59552 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266481AbUAIKvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 05:51:02 -0500
Date: Fri, 9 Jan 2004 02:51:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Qlogic ISP 1280/12160 did not call scsi_unregister
Message-Id: <20040109025134.04f9eff5.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.44.0401091143180.366-100000@math.ut.ee>
References: <Pine.GSO.4.44.0401091143180.366-100000@math.ut.ee>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> wrote:
>
> I tried the qla1280 driver on 2.6.1-rc3 (x86 32-bit PCI). It worked
>  well, even under stress. But on rmmod I got the following error:
> 
>  Qlogic ISP 1280/12160 did not call scsi_unregister
>  Call Trace:
>   [<d8b064b2>] exit_this_scsi_driver+0xd2/0x115 [qla1280]
>   [<c01340bc>] sys_delete_module+0x11c/0x140
>   [<c0149bf4>] sys_munmap+0x44/0x70
>   [<c01093d9>] sysenter_past_esp+0x52/0x71

This should be fixed by

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm1/broken-out/qla1280-update-2.patch

which is a part of 2.6.1-mm1.


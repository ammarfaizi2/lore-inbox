Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265675AbTGIFGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 01:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbTGIFGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 01:06:07 -0400
Received: from air-2.osdl.org ([65.172.181.6]:3731 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265675AbTGIFGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 01:06:05 -0400
Date: Tue, 8 Jul 2003 22:21:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: ramon.rey@hispalinux.es
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 892] New: kernel BUG at include/linux/list.h:148!
Message-Id: <20030708222101.47b7c10d.akpm@osdl.org>
In-Reply-To: <53240000.1057726175@[10.10.2.4]>
References: <53240000.1057726175@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> kernel BUG at include/linux/list.h:148!
> EIP is at remove_wait_queue+0x59/0x80
> Call Trace:
>  [<c0194a85>] devfs_d_revalidate_wait+0x145/0x160
>  [<c0116f60>] default_wake_function+0x0/0x20
>  [<c0116f60>] default_wake_function+0x0/0x20
>  [<c01574e4>] do_lookup+0x44/0x80
>  [<c015796e>] link_path_walk+0x44e/0x840
>  [<c01585ea>] open_namei+0x8a/0x3a0

There will be a patch in 2.5.74-mm3 which should fix this.  If you know how
to reproduce the bug, please test that kernel.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbTGEWtO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 18:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbTGEWtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 18:49:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:9439 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266532AbTGEWtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 18:49:13 -0400
Date: Sat, 5 Jul 2003 16:04:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: paterley <paterley@DrunkenCodePoets.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm2
Message-Id: <20030705160445.2ab1e0ec.akpm@osdl.org>
In-Reply-To: <20030705182359.269b404d.paterley@DrunkenCodePoets.com>
References: <20030705132528.542ac65e.akpm@osdl.org>
	<20030705175830.4ccfead8.paterley@DrunkenCodePoets.com>
	<20030705182359.269b404d.paterley@DrunkenCodePoets.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paterley <paterley@DrunkenCodePoets.com> wrote:
>
> ok, I get 4 of a kernel oops during boot, but the kernel seems to stay happy.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 EIP:    0060:[<00000000>]    Not tainted VLI
  [<c01637ab>] __lookup_hash+0x9b/0xd0
  [<c0163ff7>] open_namei+0x2e7/0x420
  [<c0153751>] filp_open+0x41/0x70
  [<c0153bd3>] sys_open+0x53/0x90
  [<c010945f>] syscall_call+0x7/0xb

inode->i_op->lookup() is NULL.  Not good.

> according to dmesg, immediately prior to the first oops, smbfs was
> unloaded due to unsafe usage.

Well no, it say it cannot be unloedad.

Could you please unconfigure smbfs in the kernel build?  And any other
less commonly used filesytems?

Does it still oops if smbfs is build into the kernel (not a module).

Please send a copy of your /etc/fstab.

Thanks.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbUBWUIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUBWUIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:08:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:19116 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262025AbUBWUII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:08:08 -0500
Date: Mon, 23 Feb 2004 12:08:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.3-mm2] unregister path on devfs_remove
Message-Id: <20040223120804.57f54623.akpm@osdl.org>
In-Reply-To: <20040223192807.GA4359@localhost.localdomain>
References: <20040223192807.GA4359@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov <arvidjaar@mail.ru> wrote:
>
> The patch implements cleanup of device path on devfs_remove. It does not
> use extra counters as was suggested once - rather it simply removes all
> empty directories. Manually created directories (and connecting paths)
> are preserved and cleaned up on rmdir/unlink.
> 
> The creation/removing of path is not atomic; it will be addressed later.
> It apparently requires replacing per-directory locks with global one;
> using extra counters does not actually helps here.
> 
> This patch will cause devfs_remove on directories emit warning in most
> cases. Removing connecting directories makes no sense with this change
> so if it is agreed upon I send patch that removes all
> devfs_remove("directory") from kernel.

Well could you please either send that patch or remove the warning?  I get
way too much mail when -mm kernels start spitting new warnings.


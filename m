Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbVCKEzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVCKEzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbVCKEzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:55:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:45032 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262966AbVCKEzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:55:48 -0500
Date: Thu, 10 Mar 2005 20:55:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jody McIntyre <scjody@modernduck.com>
Cc: linux-kernel@vger.kernel.org, willy@debian.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: [PATCH, RFC 1/3] Add sem_getcount() to arches that lack it
Message-Id: <20050310205503.6151ab83.akpm@osdl.org>
In-Reply-To: <20050311000646.GJ1111@conscoop.ottawa.on.ca>
References: <20050311000646.GJ1111@conscoop.ottawa.on.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody McIntyre <scjody@modernduck.com> wrote:
>
> parisc and frv define sem_getcount() in semaphore.h, which returns the
>  current semaphore value.  This is cleaner than doing
>  atomic_read(&semaphore.count), currently done in
>  drivers/ieee1394/nodemgr.c and fs/xfs/linux-2.6/xfs_buf.c, and will work
>  on all architectures if sem_getcount() is added.

That's a fairly bizarre thing to want to do.  Would it be hard to modify
xfs and 1394 to stop wanting to read a semaphore's up() count?

(Why do they want to do this anyway?)

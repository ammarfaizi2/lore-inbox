Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265980AbTGDLVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 07:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbTGDLVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 07:21:11 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:38196 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S265980AbTGDLVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 07:21:09 -0400
Date: Fri, 4 Jul 2003 04:35:37 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: help backporting workqueue to 2.4; for net/sunrpc/cache.c
Message-ID: <20030704043537.A21552@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Should I expect any problems backporting the 2.5 workqueue.c to 2.4?
It looks pretty straightforward, but I am {naive,novice}.  The only
interesting looking bit is setting current->flags |= PF_IOTHREAD,
which doesn't exist in 2.4.  At a glance, it looks like I can ignore
this; it's used in suspend.c which doesn't exist in 2.4 either.

The reason I'd like to backport this is because of changes in sunrpc
which now use the workqueue to clean auth caches.  Related question:
how is this (periodic cache clean) done in 2.5.73 and earlier?
net/sunrpc/cache.c didn't use the workqueue until 2.5.74.

Any advice is appreciated.

thanks
/fc

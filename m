Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUDMR3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 13:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUDMR3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 13:29:40 -0400
Received: from mproxy.gmail.com ([216.239.56.253]:4831 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S263645AbUDMR3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 13:29:38 -0400
Message-ID: <AA1FCD0C.1328532@mail.gmail.com>
Date: Tue, 13 Apr 2004 10:29:05 -0700
From: Martin Peck <coderman@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question about dentry cache in VFS
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on a userspace filesystem and would like
the ability to selectively decache inodes and their children
from the VFS.

I can do this on a global scale using invalidate_inodes() and
shrink_dcache_sb(), however, I would also like to be able
to decache for specific inodes/entries.

One possibility (and perhaps the 'right' way) to do this which
I had considered is using dentry_operations to trap d_revalidate
as needed, however, I would like to avoid an invocation here
for every dentry if there is another way to selectively decache.

Thanks in advance,

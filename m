Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267463AbRGLJkS>; Thu, 12 Jul 2001 05:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267462AbRGLJkI>; Thu, 12 Jul 2001 05:40:08 -0400
Received: from [62.172.234.2] ([62.172.234.2]:48954 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S267458AbRGLJjr>;
	Thu, 12 Jul 2001 05:39:47 -0400
Date: Thu, 12 Jul 2001 10:41:21 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: yxpeng <ursamajor@163.com>
cc: linux-kernel@vger.kernel.org
Subject: a bug in ext2_put_inode? (was Re: Some question about VFS
In-Reply-To: <00b201c109f8$d1d45ee0$c600a8c0@ursamajor>
Message-ID: <Pine.LNX.4.21.0107121035300.1638-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, yxpeng wrote:
> When I read the source of VFS, I notice that the fs-specific
> function sb->s_op->put_inode() is called before the inode->i_count is
> decremented and then checked. In the ext2 source, we can see that what
> the put_inode() does is to free the preallocated blocks without checking
> the i_count. I want to know why the put_inode() should be taken before
> i_count is checked. I think maybe there are some other processes that
> hold this file open and may use the preallocated blocks. Now that the
> other processes may use the preallocated blocks, why here we should free
> them? I am really confused.

It is possible that you may have found a bug, I am forwarding your
question to the linux-kernel list where someone can answer with more
certainty...

Regards,
Tigran


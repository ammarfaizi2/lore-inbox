Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUBCKKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 05:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265988AbUBCKKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 05:10:21 -0500
Received: from pop.gmx.net ([213.165.64.20]:7581 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265986AbUBCKKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 05:10:15 -0500
X-Authenticated: #4512188
Message-ID: <401F7382.3030507@gmx.de>
Date: Tue, 03 Feb 2004 11:10:10 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.2-rc3-mm1
References: <20040202235817.5c3feaf3.akpm@osdl.org> <401F70E1.5070408@gmx.de>
In-Reply-To: <401F70E1.5070408@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Hi,
> 
> I am getting this on init. I think while udev inits:
> 
> i_size_write() called without i_sem
> Feb  3 10:53:53 tachyon Call Trace:
> Feb  3 10:53:53 tachyon [<c013d347>] i_size_write_check+0x57/0x60
> Feb  3 10:53:53 tachyon [<c01767de>] simple_commit_write+0x3e/0xa0
> Feb  3 10:53:53 tachyon [<c0167f3c>] page_symlink+0xec/0x1dd
> Feb  3 10:5i_size_write() called without i_sem
> Feb  3 10:53:53 tachyon Call Trace:
> Feb  3 10:53:53 tachyon [<c013d347>] i_size_write_check+0x57/0x60
> Feb  3 10:53:53 tachyon [<c01767de>] simple_commit_write+0x3e/0xa0
> Feb  3 10:53:53 tachyon [<c0167f3c>] page_symlink+0xec/0x1dd
> Feb  3 10:53:53 tachyon [<c01bbbdd>] ramfs_symlink+0x5d/0xc0
> Feb  3 10:53:53 tachyon [<c0166e37>] vfs_symlink+0x57/0xb0
> Feb  3 10:53:53 tachyon [<c0166f63>] sys_symlink+0xd3/0xf0
> Feb  3 10:53:53 tachyon [<c038fa86>] sysenter_past_esp+0x43/0x65
> 3:53 tachyon [<c01bbbdd>] ramfs_symlink+0x5d/0xc0
> Feb  3 10:53:53 tachyon [<c0166e37>] vfs_symlink+0x57/0xb0
> Feb  3 10:53:53 tachyon [<c0166f63>] sys_symlink+0xd3/0xf0
> Feb  3 10:53:53 tachyon [<c038fa86>] sysenter_past_esp+0x43/0x65

BTW, my root is reiserfs, my boot ext2, which shouldn't be mounted by 
default, so this is reiferfs case.

Prakash

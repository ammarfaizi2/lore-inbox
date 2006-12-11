Return-Path: <linux-kernel-owner+w=401wt.eu-S937426AbWLKSRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937426AbWLKSRg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763004AbWLKSRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:17:36 -0500
Received: from mail.parknet.jp ([210.171.160.80]:2005 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763003AbWLKSRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:17:35 -0500
X-AuthUser: hirofumi@parknet.jp
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark Fasheh <mark.fasheh@oracle.com>, Andrew Morton <akpm@google.com>
Subject: Re: Status of buffered write path (deadlock fixes)
References: <45751712.80301@yahoo.com.au>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 12 Dec 2006 03:17:19 +0900
In-Reply-To: <45751712.80301@yahoo.com.au> (Nick Piggin's message of "Tue\, 05 Dec 2006 17\:52\:02 +1100")
Message-ID: <878xhewb4g.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> Finally, filesystems. Only OGAWA Hirofumi and Mark Fasheh have given much
> feedback so far. I've tried to grok ext2/3 and think they'll work OK, and
> have at least *looked* at all the rest. However in the worst case, there
> might be many subtle and different problems :( Filesystem developers need
> to review this, please. I don't want to cc every filesystem dev list, but
> if anybody thinks it would be helpful to forward this then please do.

BTW, there are still some from==to users.

	fs/affs/file.c:affs_truncate
	fs/hfs/extent.c:hfs_file_truncate
	fs/hfsplus/extents.c:hfsplus_file_truncate
	fs/reiserfs/ioctl.c:reiserfs_unpack

I'll see those this weekend.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

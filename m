Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWAXVeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWAXVeg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWAXVeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:34:36 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:51401 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750742AbWAXVef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:34:35 -0500
Subject: Re: [patch 2.6.15-mm4] sem2mutex: JFS
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060114152901.GA27921@elte.hu>
References: <20060114152901.GA27921@elte.hu>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 15:34:27 -0600
Message-Id: <1138138468.13654.26.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,
Sorry for letting this sit so long.  I've put it in the jfs tree, so
Andrew can pull it from there now.  I'll push it to Linus when the next
window opens.

Thanks,
Shaggy

On Sat, 2006-01-14 at 16:29 +0100, Ingo Molnar wrote:
> From: Ingo Molnar <mingo@elte.hu>
> 
> semaphore to mutex conversion.
> 
> the conversion was generated via scripts, and the result was validated
> automatically via a script as well.
> 
> build and boot tested.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ----
> 
>  fs/jfs/acl.c        |    4 +-
>  fs/jfs/inode.c      |   14 +++----
>  fs/jfs/jfs_dmap.c   |    6 +--
>  fs/jfs/jfs_dmap.h   |    2 -
>  fs/jfs/jfs_extent.c |   20 +++++-----
>  fs/jfs/jfs_imap.c   |   22 +++++------
>  fs/jfs/jfs_imap.h   |    4 +-
>  fs/jfs/jfs_incore.h |    5 +-
>  fs/jfs/jfs_lock.h   |    1 
>  fs/jfs/jfs_logmgr.c |    6 +--
>  fs/jfs/jfs_logmgr.h |    2 -
>  fs/jfs/jfs_txnmgr.c |   10 ++---
>  fs/jfs/namei.c      |   98 ++++++++++++++++++++++++++--------------------------
>  fs/jfs/super.c      |    2 -
>  fs/jfs/xattr.c      |    8 ++--
>  15 files changed, 103 insertions(+), 101 deletions(-)
-- 
David Kleikamp
IBM Linux Technology Center


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270142AbTHSKxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270230AbTHSKxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:53:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:24026 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270142AbTHSKxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:53:30 -0400
Date: Tue, 19 Aug 2003 03:55:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: chrisl@vmware.com
Cc: azarah@gentoo.org, linux-kernel@vger.kernel.org, adilger@clusterfs.com,
       ext3-users@redhat.com, x86-kernel@gentoo.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] fix for htree corruption. Was: [2.6] Perl weirdness
 with ext3 and HTREE
Message-Id: <20030819035506.28f72a6a.akpm@osdl.org>
In-Reply-To: <20030819104026.GA25402@vmware.com>
References: <68F326C497FDB743B5F844B776C9B146097700@pa-exch4.vmware.com>
	<1060208887.12477.31.camel@nosferatu.lan>
	<20030819104026.GA25402@vmware.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chrisl@vmware.com wrote:
>
> Martin,
> 
> The first patch should fix it. The bug is trigger by creating the index.
> Coping out the index we assume the dirents start with the first entry
> after "." "..".
> 
> It can make the first previous deleted entry reappear.
> In the past we set inode to zero for empty entry so this is not
> a problem. That is not true any more.

whee, neat, thanks.

> Andrew, I assume touch inode->i_ctime after
> ext3_mark_inode_dirty is a bug? The second patch is for that.

That's correct.

Could you please regenerate a full, single diff against a known kernel
version?  That patch generated 100% rejects for me...


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269357AbTGJPhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269393AbTGJPht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:37:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:63466 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269357AbTGJPgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:36:45 -0400
Date: Thu, 10 Jul 2003 08:51:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: bzzz@tmi.comex.ru
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] minor optimization for EXT3
Message-Id: <20030710085155.40c78883.akpm@osdl.org>
In-Reply-To: <87isqaiegy.fsf@gw.home.net>
References: <87smpeigio.fsf@gw.home.net>
	<20030710042016.1b12113b.akpm@osdl.org>
	<87isqaiegy.fsf@gw.home.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bzzz@tmi.comex.ru wrote:
>
> >>>>> Andrew Morton (AM) writes:
> 
>  AM> Alex Tomas <bzzz@tmi.comex.ru> wrote:
>  >> 
>  >> Andreas Dilger proposed do not read inode's block during inode updating
>  >> if we have enough data to fill that block. here is the patch.
> 
>  AM> ok, thanks.  Could you please redo it for the current kernel?
> 
> hmmm. it was against 2.5.72. I just tried it on 2.5.74 and all is OK.
> 

2.5.74 is some crufty ancient old thing.

ext3_read_inode() got reorganised.  Your latest patch will not apply to
current kernels.

The diff for the current devel kernel is always available at
http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/

The "gzipped full patch".  You should use that when generating and testing
changess.

There is even a nice patch-script for it:

	linus-patch http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-20030710_0516.txt.gz




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266541AbUA3Dlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 22:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266542AbUA3Dls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 22:41:48 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:22030 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266541AbUA3Dlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 22:41:47 -0500
To: Frodo Looijaard <frodol@dds.nl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       linux-7110-psion@lists.sourceforge.net
Subject: Re: PATCH to access old-style FAT fs
References: <20040126173949.GA788@frodo.local>
	<bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp>
	<4016B316.4060304@zytor.com> <87ad4987ti.fsf@devron.myhome.or.jp>
	<20040128115655.GA696@arda.frodo.local>
	<87y8rr7s5b.fsf@devron.myhome.or.jp>
	<20040128202443.GA9246@frodo.local>
	<87bron7ppd.fsf@devron.myhome.or.jp>
	<20040129223944.GA673@frodo.local>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 30 Jan 2004 12:40:58 +0900
In-Reply-To: <20040129223944.GA673@frodo.local>
Message-ID: <874quehzn9.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frodo Looijaard <frodol@dds.nl> writes:

> > The above should "goto EODir;". Likewise, another "contiure" of
> > fat_search_long().
> 
> I am not convinced that the goto is always safe, and I am pretty sure
> that it works now (though not as efficient as possible, perhaps), so I
> have left that in place for now.

But, if there is directory entries after 0, you must not allow access
to those entries. Because those invalid entries may have reference to
the valid data block.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263506AbTCNULj>; Fri, 14 Mar 2003 15:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263512AbTCNULj>; Fri, 14 Mar 2003 15:11:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:49538 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263506AbTCNULi>;
	Fri, 14 Mar 2003 15:11:38 -0500
Date: Fri, 14 Mar 2003 12:22:22 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64-mm6
Message-Id: <20030314122222.1b55e7ab.akpm@digeo.com>
In-Reply-To: <m3y93haevn.fsf@lexa.home.net>
References: <20030313032615.7ca491d6.akpm@digeo.com>
	<1047572586.1281.1.camel@ixodes.goop.org>
	<20030313113448.595c6119.akpm@digeo.com>
	<1047611104.14782.5410.camel@spc1.mesatop.com>
	<20030313192809.17301709.akpm@digeo.com>
	<20030314133126.GB2679@ncsu.edu>
	<20030314120537.715e5bf0.akpm@digeo.com>
	<m3y93haevn.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Mar 2003 20:22:19.0639 (UTC) FILETIME=[69BE1070:01C2EA67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> >>>>> Andrew Morton (AM) writes:
> 
>  AM> jlnance@unity.ncsu.edu wrote:
>  >> 
>  >> Andrew, I am not sure what you mean by this.  Are you saying that
>  >> the way ld accesses files causes the blocks on the disk to be
>  >> layed out poorly?  That is the only thing I can think of that
>  >> would get fixed by copying.
>  >> 
> 
>  AM> Exactly that.  ld seeks all over the file when adding new blocks
>  AM> to it, so with ext2 and ext3 (at least) there is poor
>  AM> correspondence between file offset and block indices.
> 
> 
> hmm. I thought delayed allocation should solve this problem. Isn't it?

Absolutely.  XFS shouldn't have this problem.

I have patches (against 2.5.7!) which get it all working for ext2
as well.



